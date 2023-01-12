//
//  ChatGroupViewController.swift
//  WoWonder
//
//  Created by Mac on 19/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Async

class ChatGroupViewController: BaseVC {
    
    //MARK: - All IBOutlet This View Controller
    @IBOutlet weak var topVeiw: UIView!
    @IBOutlet weak var collectionMediaView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userActiveStutesLabel: UILabel!
    @IBOutlet weak var userNamLabel: UILabel!
    @IBOutlet weak var backButton: UIControl!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendMessageView: UIImageView!
    @IBOutlet weak var sendBtn: UIControl!
    @IBOutlet weak var voiceBtn: UIControl!
    @IBOutlet weak var messageRiplayView: UIView!
    @IBOutlet weak var riplayhightConstraint: NSLayoutConstraint!
    @IBOutlet weak var riplayMessgaeLabel: UILabel!
    @IBOutlet weak var userNAmeRiplayLAbel: UILabel!
    @IBOutlet weak var subRiplyView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var audioCancelView: UIControl!
    @IBOutlet weak var audioSecountCount: UILabel!
    @IBOutlet weak var sendAudio: UIControl!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var moreImageVIew: UIImageView!
    
    //
    var isProfileImage = ""
    var isGroupName = ""
    var recipientID = ""
    var chatModel: Chats?
    var messagesArray = [GroupChatModel.Message]()
    var groupId = ""
    var DocUrl = ""
    var audioDuration = ""
    var isFistTry = true
    private var isMedia = false
    private var scrollStatus:Bool? = true
    private var messageCount = 0
    private var toneStatus = false
    private var isReplyStatus = false
    private var replyMessageID = ""
    private var player = AVPlayer()
    private var playerItem: AVPlayerItem!
    private var playerController = AVPlayerViewController()
    private var receiveMessageAudioPlayer: AVAudioPlayer?
    private var isimagePicker = UIImagePickerController()
    private var soundPlay = AVAudioPlayer()
    private var play = false
    private var audioFileURL: URL?
    let mpRecorder: MPAudioRecorder = MPAudioRecorder()
    var parts = [FetchGroupModel.UserData]()
    var groupsArray = [FetchGroupModel.Datum]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.SetUpScreenUI()
        self.fetchData()
        self.mpRecorder.delegateMPAR = self
        
        self.rightImage.image = UIImage(named: "ic_Chat_Back")?.withRenderingMode(.alwaysTemplate)
        self.rightImage.tintColor = UIColor(hex: "C83747")
        self.moreImageVIew.image = UIImage(named: "ic_chat_More_df")?.withRenderingMode(.alwaysTemplate)
        self.moreImageVIew.tintColor = UIColor(hex: "C83747")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setSendBytton()
        self.messageRiplayView.isHidden = true
        for index in 0..<groupsArray.count {
            let obj = groupsArray[index]
            if isGroupName == obj.groupName {
                self.userActiveStutesLabel.text = "\(obj.parts?.count ?? 0) people join this"
            }
        }
        
        
    }
    
    func SetUpScreenUI() {
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.chatTableView.addGestureRecognizer(longPressRecognizer)
        
        let URL = URL(string: isProfileImage)
        self.userProfileImageView.kf.indicatorType = .activity
        self.userProfileImageView.kf.setImage(with: URL, placeholder: UIImage(named: ""))
        self.userNamLabel.text = isGroupName
        
        self.allregisterXIB()
        self.setmediaCollectionView()
        self.chatTableView.clipsToBounds = true
        self.chatTableView.layer.cornerRadius = 20
        self.chatTableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.collectionMediaView.isHidden = true
        
        self.audioView.isHidden = true
        let voiceBtnLongClick = UILongPressGestureRecognizer(target: self, action: #selector(SetUpOnAudioSend))
        self.voiceBtn.addGestureRecognizer(voiceBtnLongClick)
    }
    
    @objc func SetUpOnAudioSend() {
        self.audioView.isHidden = false
        self.mpRecorder.startAudioRecording()
        self.audioSecountCount.text = "Audio Recording...."
    }
    
    func allregisterXIB() {
        let leftTextXIB = UINib(nibName: "LeftTextTableViewCell", bundle: nil)
        self.chatTableView.register(leftTextXIB, forCellReuseIdentifier: "LeftTextTableViewCell")
        
        let rightTextXIB = UINib(nibName: "RightTextTableViewCell", bundle: nil)
        self.chatTableView.register(rightTextXIB, forCellReuseIdentifier: "RightTextTableViewCell")
        
        let rightImageXIB = UINib(nibName: "RightImageTableViewCell", bundle: nil)
        self.chatTableView.register(rightImageXIB, forCellReuseIdentifier: "RightImageTableViewCell")
        
        let leftImageXIB = UINib(nibName: "LeftImageTableViewCell", bundle: nil)
        self.chatTableView.register(leftImageXIB, forCellReuseIdentifier: "LeftImageTableViewCell")
        
        let leftDocXIB = UINib(nibName: "LeftDocumentTableViewCell", bundle: nil)
        self.chatTableView.register(leftDocXIB, forCellReuseIdentifier: "LeftDocumentTableViewCell")
        
        let rightDocXIB = UINib(nibName: "RightDocumentTableViewCell", bundle: nil)
        self.chatTableView.register(rightDocXIB, forCellReuseIdentifier: "RightDocumentTableViewCell")
        
        let leftVidoeXIB = UINib(nibName: "LeftVidoeTableViewCell", bundle: nil)
        self.chatTableView.register(leftVidoeXIB, forCellReuseIdentifier: "LeftVidoeTableViewCell")
        
        let rightVidoeXIB = UINib(nibName: "RightVidoeTableViewCell", bundle: nil)
        self.chatTableView.register(rightVidoeXIB, forCellReuseIdentifier: "RightVidoeTableViewCell")
        
        let rightGiftXIB = UINib(nibName: "RightGiftTableViewCell", bundle: nil)
        self.chatTableView.register(rightGiftXIB, forCellReuseIdentifier: "RightGiftTableViewCell")
        
        let leftGiftXIB = UINib(nibName: "LeftGiftTableViewCell", bundle: nil)
        self.chatTableView.register(leftGiftXIB, forCellReuseIdentifier: "LeftGiftTableViewCell")
        
        let LeftLocationXIB = UINib(nibName: "LeftLocationTableViewCell", bundle: nil)
        self.chatTableView.register(LeftLocationXIB, forCellReuseIdentifier: "LeftLocationTableViewCell")
        
        let RightLocationXIB = UINib(nibName: "RightLocationTableViewCell", bundle: nil)
        self.chatTableView.register(RightLocationXIB, forCellReuseIdentifier: "RightLocationTableViewCell")
        
        let leftAudioXIB = UINib(nibName: "LeftAudioTableViewCell", bundle: nil)
        self.chatTableView.register(leftAudioXIB, forCellReuseIdentifier: "LeftAudioTableViewCell")
        
        let rightAudioXIB = UINib(nibName: "RightAudioTableViewCell", bundle: nil)
        self.chatTableView.register(rightAudioXIB, forCellReuseIdentifier: "RightAudioTableViewCell")
        
        let messageDateXIB = UINib(nibName: "MessageDateTableViewCell", bundle: nil)
        self.chatTableView.register(messageDateXIB, forCellReuseIdentifier: "MessageDateTableViewCell")
        
        let leftContact = UINib(nibName: "LeftContactTableViewCell", bundle: nil)
        self.chatTableView.register(leftContact, forCellReuseIdentifier: "LeftContactTableViewCell")
        
        let rightContact = UINib(nibName: "RightContactTableViewCell", bundle: nil)
        self.chatTableView.register(rightContact, forCellReuseIdentifier: "RightContactTableViewCell")
        
        self.chatTableView.register( ChatSender_TableCell.nib,
                                     forCellReuseIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier)
        self.chatTableView.register( ReplyChatSenderTableItem.nib,
                                     forCellReuseIdentifier: ReplyChatSenderTableItem.identifier)
        self.chatTableView.register( replyReceiverTableItem.nib,
                                     forCellReuseIdentifier: replyReceiverTableItem.identifier)
        self.chatTableView.scrollToLastRow(animated: true)
        
    }
    
    //MARK: - All IBAction This ViewControlller
    @IBAction func cancleRecoding (_ sender: Any) {
        self.audioView.isHidden = true
        self.mpRecorder.stopAudioRecording()
        self.audioFileURL = nil
    }
    
    @IBAction func sendAudioRecoding (_ sender: Any) {
        self.mpRecorder.stopAudioRecording()
        self.audioView.isHidden = true
    }
    
    @IBAction func showMediaButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if isMedia == true {
            self.isMedia = false
        } else {
            self.isMedia = true
        }
        self.setmediaCollectionView()
    }
    
    @IBAction func cancelReplyPressed(_ sender: Any) {
        self.riplayhightConstraint.constant = 0
        self.cancelButton.isHidden = true
        self.userNAmeRiplayLAbel.isHidden = true
        self.riplayMessgaeLabel.isHidden = true
        self.messageRiplayView.isHidden = true
        self.subRiplyView.isHidden = true
        self.messageTextView.becomeFirstResponder()
        self.replyMessageID = ""
        self.isReplyStatus = false
        self.animateRepltyView()
    }
    
    @IBAction func sendButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if messageTextView.text != "" {
            self.sendMessage(lat: 0, lag: 0)
            self.messageTextView.text = ""
        } else {
            
        }
    }
    
    @IBAction func moreButtonClick(_ sender: UIControl) {
        let moreBottonVC = GroupBottomMoreVC.initialize(from: .group)
        moreBottonVC.delegate = self
        moreBottonVC.modalPresentationStyle = .overCurrentContext
        self.present(moreBottonVC, animated: true)
    }
    
    func setmediaCollectionView() {
        UIView.animate(withDuration: 3, delay: 3) {
            if self.isMedia == true {
                self.mediaImageView.image  = UIImage(named: "ic_Chat_cancel")
                self.collectionMediaView.isHidden = false
            } else {
                self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
                self.collectionMediaView.isHidden = true
            }
        }
    }
    
    @IBAction func photoButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
            self.collectionMediaView.isHidden = true
            self.isimagePicker.delegate = self
            self.isimagePicker.sourceType = .photoLibrary
            self.isimagePicker.allowsEditing = true
            self.isimagePicker.mediaTypes = ["public.image", "public.movie"]
            present(self.isimagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func documentButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
        let importMenu = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        importMenu.delegate = self
        self.present(importMenu, animated: true, completion: nil)
    }
    
    @IBAction func conectButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
        let vc = R.storyboard.dashboard.inviteFriendsVC()
        vc?.status = true
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func gifButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
        let vc = R.storyboard.chat.gifVC()
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func stickerButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
    }
    
    @IBAction func audioButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
    }
    
    @IBAction func locationButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
        let vc = R.storyboard.chat.locationVC()
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(named: "ic_Chat_Media")
        self.collectionMediaView.isHidden = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            isimagePicker = UIImagePickerController()
            isimagePicker.sourceType = .camera
            isimagePicker.allowsEditing = true
            isimagePicker.delegate = self
            self.present(isimagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - sendAPIRequestMessages
    private func sendAPIRequestMessages(limit: Int,
                                        afterMsgId: String? = nil,
                                        beforeMsgId: String? = nil,
                                        messageId: String? = nil, _ completion: @escaping ([MessageModel]) -> Void) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            ChatManager.instance.getUserMessages(user_id: userId,
                                                 session_Token: sessionID,
                                                 receipent_id: self.recipientID,
                                                 limit: limit,
                                                 afterMsgId: afterMsgId,
                                                 beforeMsgId: beforeMsgId,
                                                 messageId: messageId) { (result) in
                
                switch result {
                case .success(let model):
                    Async.main({
                        completion(model.messages ?? [])
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)}
                    })
                    break
                }
            }
        })
    }
    
    //MARK: - setSendBytton
    func setSendBytton() {
        if self.messageTextView.text == "" {
            self.sendBtn.isHidden = true
            self.voiceBtn.isHidden = false
        } else {
            self.sendBtn.isHidden = false
            self.voiceBtn.isHidden = true
        }
    }
    
    //MARK: - TableView longPressed Click
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let objSender = sender.location(in: self.chatTableView)
        let indexPath = self.chatTableView.indexPathForRow(at: objSender)
        let navigaction = GroupBottomSiteViewController.initialize(from: .chat)
        navigaction.modalPresentationStyle = .overCurrentContext
        navigaction.delegate = self
        navigaction.isBack = indexPath ?? IndexPath()
        present(navigaction, animated: true, completion: nil)
    }
    
    //MARK: - GroupChat fetchData
    private func fetchData() {
        let sessionID = AppInstance.instance.sessionId ?? ""
        let groupId = self.groupId
        log.verbose("group id = \(groupId)")
        self.showProgressDialog(text: "Loading..")
        Async.background({
            GroupChatManager.instance.getGroupChats(group_Id: groupId, session_Token: sessionID, type: "fetch_messages", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.messagesArray.removeAll()
                            log.debug("userList = \(success?.data?.messages?.count ?? nil)")
                            for item in stride(from: (success?.data?.messages!.count)! - 1, to: -1, by: -1){
                                self.messagesArray.append((success?.data?.messages![item])!)
                            }
                            self.chatTableView.reloadData()
                            self.chatTableView.scrollToLastRow(animated: true)
                            if self.scrollStatus!{
                                if self.messagesArray.count == 0{
                                    log.verbose("Will not scroll more")
                                }else{
                                    self.scrollStatus = false
                                    self.messageCount = self.messagesArray.count
                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                                }
                                
                            }else{
                                if self.messagesArray.count > self.messageCount{
                                    if self.toneStatus {
                                        //                                        self.playReceiveMessageSound()
                                    }else{
                                        log.verbose("To play sound please enable conversation tone from settings..")
                                    }
                                    self.messageCount = self.messagesArray.count
                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                                }else{
                                    log.verbose("Will not scroll more")
                                }
                                log.verbose("Will not scroll more")
                            }
                        }
                    })
                } else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            
                        }
                    })
                } else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                        
                    })
                    
                } else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            })
        })
    }
    
    //MARK: - AnimateReplty View
    fileprivate func animateRepltyView() {
        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.layoutSubviews, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
    
    //MARK: - playReceiveMessageSound
    func playReceiveMessageSound() {
        guard let url = Bundle.main.url(forResource: "Popup_GetMesseges", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            receiveMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            receiveMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let aPlayer = receiveMessageAudioPlayer else { return }
            aPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSendMessageSound() {
        var sendMessageAudioPlayer: AVAudioPlayer?
        guard let url = Bundle.main.url(forResource: "Popup_SendMesseges", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let aPlayer = sendMessageAudioPlayer else { return }
            aPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - getThumbnailImage
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
}

//MARK: - TableView Delegate & DataSource Method's
extension ChatGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objChatList = messagesArray[indexPath.row]
        
        guard let type = objChatList.type else { return UITableViewCell() }
        
        if objChatList.reply_id == "0" {
            switch type {
            case "left_text":
                let lat = Double(objChatList.lat ?? "0.0") ?? 0.0
                let long = Double(objChatList.lng ?? "0.0") ?? 0.0
                
                if lat > 0.0 || long > 0.0 {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightLocationTableViewCell", for: indexPath) as? RightLocationTableViewCell
                    cell?.mapview.isMyLocationEnabled = true
                    cell?.messageTim.text = objChatList.time
                    cell?.lat = lat
                    cell?.long = long
                    cell?.messageVIew.tag = indexPath.row
                    cell?.messageVIew.addTarget(self, action: #selector(setLocationNavigaction), for: .touchUpInside)
                    
                    cell?.callDelegateMethod()
                    return cell ?? UITableViewCell()
                } else {
                    
                    let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
                    let url = URL(string: messageString)
                    let extenion =  url?.pathExtension
                    if extenion == "gif" {
                        let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftGiftTableViewCell", for: indexPath) as? LeftGiftTableViewCell
                        cell?.starImageVIew.isHidden = true
                        self.setLeftGiftData(cell: cell, indexPathForCell: indexPath)
                        return cell ?? UITableViewCell()
                    } else {
                        let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftTextTableViewCell", for: indexPath) as? LeftTextTableViewCell
                        self.setLeftTextData(cell: cell, indexPathForCell: indexPath)
                        cell?.starImageVIew.isHidden = true
                        return cell ?? UITableViewCell()
                    }
                }
                
            case "right_text":
                let lat = Double(objChatList.lat ?? "0.0") ?? 0.0
                let long = Double(objChatList.lng ?? "0.0") ?? 0.0
                
                if lat > 0.0 || long > 0.0 {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightLocationTableViewCell", for: indexPath) as? RightLocationTableViewCell
                    cell?.mapview.isMyLocationEnabled = true
                    cell?.messageTim.text = objChatList.time
                    cell?.lat = lat
                    cell?.long = long
                    cell?.messageVIew.tag = indexPath.row
                    cell?.messageVIew.addTarget(self, action: #selector(setLocationNavigaction), for: .touchUpInside)
                    cell?.messageVIew.backgroundColor = UIColor(hex: "C83747")
                    cell?.callDelegateMethod()
                    return cell ?? UITableViewCell()
                } else {
                    
                    let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
                    let url = URL(string: messageString)
                    let extenion =  url?.pathExtension
                    if extenion == "gif" {
                        let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightGiftTableViewCell", for: indexPath) as? RightGiftTableViewCell
                        cell?.starImageVIew.isHidden = true
                        self.setRightGiftData(cell: cell, indexPathForCell: indexPath)
                        return cell ?? UITableViewCell()
                    } else {
                        let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as? RightTextTableViewCell
                        cell?.starImageVIew.isHidden = true
                        self.setRightTextData(cell: cell, indexPathForCell: indexPath)
                        return cell ?? UITableViewCell()
                    }
                    
                }
                
            case "right_image":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightImageTableViewCell", for: indexPath) as? RightImageTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setRightImageData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_Image":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftImageTableViewCell", for: indexPath) as? LeftImageTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setLeftImageData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_Video":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftVidoeTableViewCell", for: indexPath) as? LeftVidoeTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setLeftVidoeData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_video":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightVidoeTableViewCell", for: indexPath) as? RightVidoeTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setRightVidoeData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_Gif":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightGiftTableViewCell", for: indexPath) as? RightGiftTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setRightGiftData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_Gif":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftGiftTableViewCell", for: indexPath) as? LeftGiftTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setLeftGiftData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_contact":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftContactTableViewCell", for: indexPath) as? LeftContactTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setLeftContactCell(cell: cell, indexpathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_contact":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightContactTableViewCell", for: indexPath) as? RightContactTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setRightContactCell(cell: cell, indexpathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_file":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightDocumentTableViewCell", for: indexPath) as? RightDocumentTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setRightDocumnetData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_file":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftDocumentTableViewCell", for: indexPath) as? LeftDocumentTableViewCell
                cell?.starImageVIew.isHidden = true
                self.setLeftDocumnetData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_audio":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftAudioTableViewCell", for: indexPath) as? LeftAudioTableViewCell
                self.setLeftAudioData(cell: cell, indexPathForCell: indexPath)
                cell?.starImageVIew.isHidden = true
                return cell ?? UITableViewCell()
                
            case "right_audio":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightAudioTableViewCell", for: indexPath) as? RightAudioTableViewCell
                self.setrightAudioData(cell: cell, indexPathForCell: indexPath)
                cell?.starImageVIew.isHidden = true
                return cell ?? UITableViewCell()
                
            case "right_map":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightLocationTableViewCell", for: indexPath) as? RightLocationTableViewCell
                cell?.starImageVIew.isHidden = true
                cell?.mapview.isMyLocationEnabled = true
                cell?.messageTim.text = objChatList.time_text ?? ""
                cell?.callDelegateMethod()
                cell?.starImageVIew.isHidden = true
                cell?.messageVIew.tag = indexPath.row
                cell?.messageVIew.addTarget(self, action: #selector(setLocationNavigaction), for: .touchUpInside)
                cell?.messageVIew.backgroundColor = UIColor(hex: "C83747")
                return cell ?? UITableViewCell()
                
            case "left_map":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftLocationTableViewCell", for: indexPath) as? LeftLocationTableViewCell
                cell?.starImageVIew.isHidden = true
                cell?.googleMapView.isMyLocationEnabled = true
                cell?.messageTim.text = objChatList.time_text ?? ""
                cell?.callDelegateMethod()
                cell?.messageVIew.tag = indexPath.row
                cell?.messageVIew.addTarget(self, action: #selector(setLocationNavigaction), for: .touchUpInside)
                
                return cell ?? UITableViewCell()
            default:
                return UITableViewCell()
            }
        } else {
            switch type {
            case "left_Text":
                
                //show text on right
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.replyReceiverTableItem.identifier) as? replyReceiverTableItem
                cell?.selectionStyle = .none
                let paragraph = NSMutableParagraphStyle()
                paragraph.tabStops = [ NSTextTab(textAlignment: .right, location: 0, options: [:]), ]
                
                let str = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "" , key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
                
                if objChatList.from_id == AppInstance.instance._userId {
                    cell?.usernameLabel.text = "You"
                }else{
                    cell?.usernameLabel.text = self.userNamLabel.text ?? ""
                }
                
                if objChatList.type == "right_text" || objChatList.type == "left_text" {
                    cell?.userTextLabel.text = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
                    
                } else if objChatList.type == "right_image" || objChatList.type == "left_image" {
                    cell?.userTextLabel.text = "Image"
                    
                } else if objChatList.type == "right_Adioes" || objChatList.type == "left_audio" {
                    cell?.userTextLabel.text = "Adioes"
                    
                } else if objChatList.type == "right_video" || objChatList.type == "left_video" {
                    cell?.userTextLabel.text = "Video"
                    
                } else if objChatList.type == "right_file" || objChatList.type == "left_file" {
                    cell?.userTextLabel.text = "File"
                    
                } else if objChatList.type == "right_contact" || objChatList.type == "left_contact" {
                    cell?.userTextLabel.text = "Contact"
                }
                
                let attributed = NSAttributedString(
                    string: str,
                    attributes: [NSAttributedString.Key.paragraphStyle: paragraph,
                                 NSAttributedString.Key.foregroundColor: UIColor.black,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                )
                
                cell?.messageTextLabel.attributedText = attributed
                cell?.messageTextLabel.isEditable = false
                cell?.messageTimelabel.text = objChatList.time_text
                cell?.starBtn.isHidden = true
                return cell ?? UITableViewCell()
                
            case "right_text":
                
                //show text on right
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.replyChatSenderTableItem.identifier) as? ReplyChatSenderTableItem
                cell?.backView.backgroundColor = UIColor(hex: "C83747")
                cell?.selectionStyle = .none
                let paragraph = NSMutableParagraphStyle()
                paragraph.tabStops = [
                    NSTextTab(textAlignment: .right, location: 0, options: [:]),
                ]
                let str = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text?.htmlAttributedString ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
                
                if objChatList.from_id == AppInstance.instance._userId {
                    cell?.usernameLabel.text = "You"
                } else {
                    cell?.usernameLabel.text = self.userNamLabel.text ?? ""
                }
                
                if objChatList.type == "right_text" || objChatList.type == "left_text" {
                    cell?.userTextLabel.text = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
                    
                } else if objChatList.type == "right_image" || objChatList.type == "left_image" {
                    cell?.userTextLabel.text = "Image"
                    
                } else if objChatList.type == "right_Adioes" || objChatList.type == "left_audio" {
                    cell?.userTextLabel.text = "Adioes"
                    
                } else if objChatList.type == "right_video" || objChatList.type == "left_video" {
                    cell?.userTextLabel.text = "Video"
                    
                } else if objChatList.type == "right_file" || objChatList.type == "left_file" {
                    cell?.userTextLabel.text = "File"
                    
                } else if objChatList.type == "right_contact" || objChatList.type == "left_contact" {
                    cell?.userTextLabel.text = "Contact"
                }
                
                let attributed = NSAttributedString(
                    string: str,
                    attributes: [
                        NSAttributedString.Key.paragraphStyle: paragraph,
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
                    ]
                )
                cell?.messageTextLabel.attributedText = attributed
                cell?.messageTextLabel.isEditable = false
                cell?.messageTimeLabel.text = objChatList.time_text
                cell?.starBtn.isHidden = true
                
                cell?.backView.backgroundColor = UIColor(hex: "C83747")
                
                return cell ?? UITableViewCell()
                
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
    
    //MARK: - setLeftTextData
    private func setLeftTextData(cell: LeftTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let url = URL(string: objChatList.user_data?.avatar ?? "")
        cell?.userProfileImageView.kf.indicatorType = .activity
        cell?.userProfileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
        
        cell?.masageTextLabel.text = "\(messageString)"
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
    }
    
    private func setRightTextData(cell: RightTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
        cell?.messaageTextLabel.text = "\(messageString)"
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        cell?.messgaeView.backgroundColor = UIColor(hex: "C83747")
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        }
    }
    
    private func setRightImageData(cell: RightImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let Url = URL(string: objChatList.media ?? "")
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: Url,  placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
        cell?.messageVIew.backgroundColor = UIColor(hex: "C83747")
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        }
    }
    
    //MARK: - LeftImageData Set
    private func setLeftImageData(cell: LeftImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let Url = URL(string: objChatList.media ?? "")
        let userprofile = URL(string: objChatList.user_data?.avatar ?? "")
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: userprofile, placeholder: UIImage(named: ""))
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: Url,  placeholder: UIImage(named: ""))
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
    }
    
    //MARK: - Right Document
    private func setRightDocumnetData(cell: RightDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        cell?.docNameLabel.text = objChatList.mediaFileName
        let url = URL(string: objChatList.media ?? "")
        let extenion =  url?.pathExtension
//        cell?.docTypeLabel.text = "12 Kb"
                
        switch objChatList.file_size {
        case .string(let data):
            cell?.docTypeLabel.text = data

        case .integer(_):
            break
            
        case.none:
            break
        }
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
        cell?.messageMainView.backgroundColor = UIColor(hex: "C83747")
        cell?.documentImageview.image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
        cell?.documentImageview.tintColor = UIColor(hex: "C83747")
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        }
    }
    
    //MARK: - Left Document
    private func setLeftDocumnetData(cell: LeftDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let url = URL(string: objChatList.user_data?.avatar ?? "")
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        cell?.docNameLabel.text = objChatList.mediaFileName
        switch objChatList.file_size {
        case .string(let data):
            cell?.docTypeLabel.text = data

        case .integer(_):
            break
            
        case.none:
            break
        }
        cell?.docImageView.image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
        cell?.docImageView.tintColor = UIColor(hex: "C83747")
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
    }
    
    //MARK: - LeftVidoe
    private func setLeftVidoeData(cell: LeftVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let url = URL(string: objChatList.user_data?.avatar ?? "")
        cell?.ProfileImageVIew.kf.indicatorType = .activity
        cell?.ProfileImageVIew.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        let videoURL = URL(string: objChatList.media ?? "")
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
    }
    
    //MARK: - Right Vidoes
    private func setRightVidoeData(cell: RightVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        cell?.messageTimeLabel.text = objChatList.time_text
        let videoURL = URL(string: objChatList.media ?? "")
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
        cell?.mesaageView.backgroundColor = UIColor(hex: "C83747")
//        cell?.playvidoeButton.backgroundColor = UIColor(hex: "C83747")
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        }
    }
    
    //MARK: - Right Gift
    private func setRightGiftData(cell: RightGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
        
        cell?.vidoeImageVIew.image = UIImage.gif(url: messageString)
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        cell?.messageView.backgroundColor = UIColor(hex: "C83747")
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor(hex: "C83747")
        }
    }
    //MARK: - Left Gift
    private func setLeftGiftData(cell: LeftGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList.orginal_text ?? "", key: objChatList.time ?? "") ?? objChatList.orginal_text ?? "")"
        cell?.vidoeImageVIew.image = UIImage.gif(url: messageString)
        cell?.messageTimeLabel.text = objChatList.time_text ?? ""
        
    }
    
    //MARK: - Left Contact
    private func setLeftContactCell(cell: LeftContactTableViewCell?,  indexpathForCell: IndexPath) {
        let object = self.messagesArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (object.orginal_text?.htmlAttributedString!)!)
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key == "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        
        cell?.messageVIew.tag = indexpathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(openContact), for: .touchUpInside)
        
        let url = URL(string: object.user_data?.avatar ?? "")
        cell?.userprofileImageVIew.kf.indicatorType = .activity
        cell?.userprofileImageVIew.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
    }
    
    //MARK: - Right Contact
    private func setRightContactCell(cell: RightContactTableViewCell?,  indexpathForCell: IndexPath) {
        let object = self.messagesArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (object.orginal_text?.htmlAttributedString!)!)
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key == "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        cell?.messageTimeVIew.text = object.time_text ?? ""
        cell?.messageVIew.tag = indexpathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(openContact), for: .touchUpInside)
        cell?.messageVIew.backgroundColor = UIColor(hex: "C83747")
        
        
        if object.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = .white
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = .white
        }
    }
    
    @objc func setLocationNavigaction(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        let url = "http://maps.apple.com/maps?saddr=\(object.lat ?? ""),\(object.lng ?? "")"
        UIApplication.shared.openURL(URL(string:url)!)
        
    }
    
    private func setrightAudioData(cell: RightAudioTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        guard let url = URL(string: objChatList.media ?? "") else {
            print("Invalid URL")
            return
        }
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            soundPlay = try AVAudioPlayer(data: soundData)
            let minuteString = String(format: "%02d", (Int(soundPlay.duration) / 60))
            let secondString = String(format: "%02d", (Int(soundPlay.duration) % 60))
            
            cell?.playAudioView.tag = indexPathForCell.row
            cell?.playAudioView.addTarget(self, action: #selector(playAudioButtonClick), for: .touchUpInside)
        } catch {
            print(error)
        }
        
        let url1 = URL(string: objChatList.user_data?.avatar ?? "")
        cell?.profileImage.kf.indicatorType = .activity
        cell?.profileImage.kf.setImage(with: url1, placeholder: UIImage(named: ""))
        cell?.audioview.backgroundColor = UIColor(hex: "C83747")
    }
    
    private func setLeftAudioData(cell: LeftAudioTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        guard let url = URL(string: objChatList.media ?? "") else {
            print("Invalid URL")
            return
        }
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            soundPlay = try AVAudioPlayer(data: soundData)
            let minuteString = String(format: "%02d", (Int(soundPlay.duration) / 60))
            let secondString = String(format: "%02d", (Int(soundPlay.duration) % 60))
            print("TOTAL TIMER: \(minuteString):\(secondString)")
            
            cell?.audioSliderView.maximumValue = Float(soundPlay.duration)
            cell?.playAudioImageView.tag = indexPathForCell.row
            
            cell?.playAudioImageView.addTarget(self, action: #selector(playAudioButtonClick), for: .touchUpInside)
            
        } catch {
            print(error)
        }
        
        let Recurl = URL(string: AppInstance.instance.userProfile?.avatar ?? "")
        cell?.reciveprofileImage.kf.indicatorType = .activity
        cell?.reciveprofileImage.kf.setImage(with: Recurl, placeholder: UIImage(named: ""))
        
        
        let USPurl = URL(string: objChatList.user_data?.avatar ?? "")
        cell?.userProfileImage.kf.indicatorType = .activity
        cell?.userProfileImage.kf.setImage(with: USPurl, placeholder: UIImage(named: ""))
        
    }
    
    @objc func playAudioButtonClick(_ sender: UIControl) {
        if play == false {
            self.play = true
            self.soundPlay.play()
        } else {
            self.play = false
            self.soundPlay.pause()
        }
    }
    
    //MARK: - clickVidowButton
    @objc func clickVidowButton(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        let player = AVPlayer(url: URL(string: object.media ?? "")!)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //MARK: - clickImageClick
    @objc func clickImageClick(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
        vc.imageURL = object.media ?? ""
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - clickFile
    @objc func clickFile(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        if let url = URL(string: object.media ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func openContact(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        let dic = convertStringToDictionary(text: (object.orginal_text?.htmlAttributedString!)!)
        let phoneNumber = "\(dic?["value"] ?? "")"
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            let dic = convertStringToDictionary(text: (object.orginal_text?.htmlAttributedString!)!)
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let GetData = messagesArray[indexPath.row]
        print("GetData => \(GetData)")
    }
}

// MARK: - ImagePickerController & NavigationController Delegate Method's
extension ChatGroupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = image.jpegData(compressionQuality: 0.1)
            self.sendSelectedData(imageData: imageData,
                                  videoData: nil,
                                  imageMimeType: imageData?.mimeType,
                                  VideoMimeType: nil,
                                  Type: "image",
                                  fileData: nil,
                                  fileExtension: nil,
                                  FileMimeType: nil,
                                  audio: nil,
                                  audioMineType: nil,
                                  audioExtension: nil)
        }
        
        if let fileURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            let videoData = try? Data(contentsOf: fileURL)
            self.sendSelectedData(imageData: nil,
                                  videoData: videoData,
                                  imageMimeType: nil,
                                  VideoMimeType: videoData?.mimeType,
                                  Type: "video",
                                  fileData: nil,
                                  fileExtension: nil,
                                  FileMimeType: nil,
                                  audio: nil,
                                  audioMineType: nil,
                                  audioExtension: nil)
        }
    }
    
}

//MARK: - UIDocumentPicker & UIDocumentInteraction Delegate Method's
extension ChatGroupViewController: UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("didPickDocumentURL ==> \(url)")
        let fileData = try? Data(contentsOf: url)
        let fileExtension = String(url.lastPathComponent.split(separator: ".").last!)
        self.sendSelectedData(imageData: nil,
                              videoData: nil,
                              imageMimeType: nil,
                              VideoMimeType: nil,
                              Type: "file",
                              fileData: fileData,
                              fileExtension: fileExtension,
                              FileMimeType: fileData?.mimeType,
                              audio: nil,
                              audioMineType: nil,
                              audioExtension: nil)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    //MARK: - DeleteMessage Calling Api Call
    private func deleteMsssage(messageID: String, indexPath: Int) {
        
        let sessionID = AppInstance.instance._sessionId
        Async.background({
            ChatManager.instance.deleteChatMessage(messageId: messageID , session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.message ?? "")")
                            self.groupsArray.remove(at: indexPath)
                            self.chatTableView.reloadData()
                        }
                    })
                    
                } else if sessionError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                        }
                    })
                    
                } else if serverError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                        }
                    })
                    
                } else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                        }
                    })
                }
            })
        })
    }
}

// MARK: - TEXT VIEW DELEGATE

extension ChatGroupViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.setSendBytton()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            self.messageTextView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NSLocalizedString("Your message here...", comment: "Your message here...")
            textView.textColor = UIColor.lightGray
        }
    }
    
    func navigactionOnStoryboard(indexpath: Int, nameCell: String, isback: IndexPath) {
        let object = self.messagesArray[isback.row]
        if nameCell == "0" {
            let vc = MessageInfoViewController.initialize(from: .favorite)
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if nameCell == "1" {
            self.deleteMsssage(messageID: object.id ?? "", indexPath: isback.row)
            
        } else if nameCell == "2" {
            
            let text = "\(self.decryptionAESModeECB(messageData: object.orginal_text ?? "", key: object.time ?? "") ?? object.orginal_text ?? "")"
            
            if object.type == "right_text" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = text
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "left_text" {
                self.userNAmeRiplayLAbel.text = self.userNamLabel.text
                self.riplayMessgaeLabel.text = text
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "right_image" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "Image"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "left_image" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "Image"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "right_Adioes" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "Audio"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "left_audio" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "Audio"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "right_video" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "video"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "left_video" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "video"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "right_file" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "file"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "left_file" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "file"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "right_contact" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "Contact"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
                
            } else if object.type == "left_contact" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "Contact"
                self.isReplyStatus = true
                self.replyMessageID = object.id ?? ""
                self.swipeToReply(index: isback)
            }
            
        }
    }
    
    //MARK: - swipeToReply
    private func swipeToReply(index: IndexPath) {
        self.riplayhightConstraint.constant = 100
        self.cancelButton.isHidden = false
        self.userNAmeRiplayLAbel.isHidden = false
        self.riplayMessgaeLabel.isHidden = false
        self.messageRiplayView.isHidden = false
        self.subRiplyView.isHidden = false
        self.messageTextView.becomeFirstResponder()
        self.animateRepltyView()
    }
}

extension ChatGroupViewController: GroupBottomSiteDelegte {
    func passingdata(_ viewController: GroupBottomSiteViewController, indexpath: Int, nameof: String, isBack: IndexPath) {
        self.navigactionOnStoryboard(indexpath: indexpath, nameCell: nameof, isback: isBack)
    }
}


extension ChatGroupViewController {
    private func sendMessage(lat: Double, lag:Double){
        self.messagesArray.removeAll()
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        let messageText = messageTextView.text ?? ""
        let groupId = self.groupId
        let sessionID = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.sendMessageToGroup(message_hash_id: messageHashId,
                                                         GroupId: groupId,
                                                         text: messageText,
                                                         type: "send",
                                                         session_Token: sessionID,
                                                         lat: lat,
                                                         lag: lag,
                                                         replyID: self.replyMessageID) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            if self.messagesArray.count == 0{
                                log.verbose("Will not scroll more")
                                self.messageTextView.text = ""
                                self.view.resignFirstResponder()
                                self.fetchData()
                            } else {
                                if self.toneStatus{
                                    self.playSendMessageSound()
                                }else{
                                    log.verbose("To play sound please enable conversation tone from settings..")
                                }
                                self.messageTextView.text = ""
                                //                                self.textViewPlaceHolder()
                                log.debug("userList = \(success?.apiStatus ?? 0)")
                                let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
                                self.chatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                            }
                            
                            if self.isReplyStatus {
                                self.riplayhightConstraint.constant = 0
                                self.cancelButton.isHidden = true
                                self.userNAmeRiplayLAbel.isHidden = true
                                self.riplayMessgaeLabel.isHidden = true
                                self.messageRiplayView.isHidden = true
                                self.messageRiplayView.isHidden = true
                                self.subRiplyView.isHidden = true
                                self.messageTextView.becomeFirstResponder()
                                self.replyMessageID = ""
                                self.isReplyStatus = false
                            }
                        }
                    })
                } else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                        }
                    })
                } else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                    })
                    
                } else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            }
        })
    }
    
    //MARK: - sendSelectedData Me
    private func sendSelectedData(imageData:Data?,
                                  videoData:Data?,
                                  imageMimeType:String?,
                                  VideoMimeType:String?,
                                  Type:String?,
                                  fileData:Data?,
                                  fileExtension:String?,
                                  FileMimeType:String?,
                                  audio: Data?,
                                  audioMineType: String?,
                                  audioExtension: String?) {
        
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        let sessionId = AppInstance.instance.sessionId ?? ""
        let groupId = self.groupId
        let dataType = Type ?? ""
        
        if dataType == "image"{
            Async.background({
                //                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId, groupId: groupId, sendType: "send", session_Token: sessionId, type: dataType, image_data: imageData, video_data: nil, imageMimeType: imageMimeType, videoMimeType: nil, text: "", file_data: nil, file_Extension: nil, fileMimeType: nil, completionBlock: { (success, sessionError, serverError, error) in
                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
                                                            groupId: groupId,
                                                            sendType: "send",
                                                            session_Token: sessionId,
                                                            type: dataType,
                                                            image_data: imageData,
                                                            video_data: nil,
                                                            imageMimeType: imageMimeType,
                                                            videoMimeType: nil,
                                                            text: "",
                                                            file_data: nil,
                                                            file_Extension: nil,
                                                            fileMimeType: nil,
                                                            auido: nil,
                                                            auidoMimeType: nil,
                                                            auido_Extension: "",
                                                            completionBlock: { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                log.debug("userList = \(success?.apiStatus ?? 0)")
                                self.fetchData()
                                self.chatTableView.scrollToLastRow(animated: true)
                            }
                        })
                    }else if sessionError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                                log.error("sessionError = \(sessionError?.errors?.errorText)")
                            }
                        })
                    }else if serverError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                                log.error("serverError = \(serverError?.errors?.errorText)")
                            }
                        })
                    } else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                                log.error("error = \(error?.localizedDescription)")
                            }
                        })
                    }
                })
                
            })
        } else if dataType == "video"{
            
            Async.background({
                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
                                                            groupId: groupId,
                                                            sendType: "send",
                                                            session_Token: sessionId,
                                                            type: dataType,
                                                            image_data: nil,
                                                            video_data: videoData,
                                                            imageMimeType: nil,
                                                            videoMimeType: VideoMimeType,
                                                            text: "",
                                                            file_data: nil,
                                                            file_Extension: nil,
                                                            fileMimeType: nil,
                                                            auido: nil,
                                                            auidoMimeType: nil,
                                                            auido_Extension: "",
                                                            completionBlock: { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                log.debug("userList = \(success?.apiStatus ?? 0)")
                                self.fetchData()
                                self.chatTableView.scrollToLastRow(animated: true)
                            }
                        })
                    }else if sessionError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                                log.error("sessionError = \(sessionError?.errors?.errorText)")
                                
                                
                            }
                        })
                    }else if serverError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                                log.error("serverError = \(serverError?.errors?.errorText)")
                            }
                            
                        })
                        
                    }else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                                log.error("error = \(error?.localizedDescription)")
                            }
                        })
                    }
                })
            })
            
        } else if dataType == "audio" {
            Async.background({
                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
                                                            groupId: groupId,
                                                            sendType: "send",
                                                            session_Token: sessionId,
                                                            type: dataType,
                                                            image_data: nil,
                                                            video_data: nil,
                                                            imageMimeType: nil,
                                                            videoMimeType: nil,
                                                            text: "",
                                                            file_data: nil,
                                                            file_Extension: nil,
                                                            fileMimeType: nil,
                                                            auido: audio,
                                                            auidoMimeType: audioMineType,
                                                            auido_Extension: "wav",
                                                            completionBlock: { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                log.debug("userList = \(success?.apiStatus ?? 0)")
                                self.fetchData()
                                self.chatTableView.scrollToLastRow(animated: true)
                            }
                        })
                    }else if sessionError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                                log.error("sessionError = \(sessionError?.errors?.errorText)")
                            }
                        })
                    }else if serverError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                                log.error("serverError = \(serverError?.errors?.errorText)")
                            }
                        })
                    } else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                                log.error("error = \(error?.localizedDescription)")
                            }
                        })
                    }
                })
            })
            
        }else{
            Async.background({
                //                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId, groupId: groupId, sendType: "send", session_Token: sessionId, type: dataType, image_data: nil, video_data: nil, imageMimeType: nil, videoMimeType: nil, text: "", file_data: fileData, file_Extension: fileExtension, fileMimeType: FileMimeType, completionBlock: { (success, sessionError, serverError, error) in
                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
                                                            groupId: groupId,
                                                            sendType: "send",
                                                            session_Token: sessionId,
                                                            type: dataType,
                                                            image_data: nil,
                                                            video_data: nil,
                                                            imageMimeType: nil,
                                                            videoMimeType: nil,
                                                            text: "",
                                                            file_data: fileData,
                                                            file_Extension: fileExtension,
                                                            fileMimeType: FileMimeType,
                                                            auido: nil,
                                                            auidoMimeType: nil,
                                                            auido_Extension: nil,
                                                            completionBlock: { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                log.debug("userList = \(success?.apiStatus ?? 0)")
                                self.fetchData()
                                self.chatTableView.scrollToLastRow(animated: true)
                            }
                        })
                    }else if sessionError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                                log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            }
                        })
                    }else if serverError != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                                log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                            }
                        })
                    } else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                                log.error("error = \(error?.localizedDescription)")
                            }
                        })
                    }
                })
            })
        }
    }
    
    private func exitGroup(){
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupId = self.groupId
        Async.background({
            GroupChatManager.instance.leaveGroup(group_Id:groupId , session_Token: sessionToken, type: "leave", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("success = \(success?.apiStatus ?? 0)")
                            self.view.makeToast("you are successfully leaved this group")
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            self.view.makeToast(sessionError?.errors?.errorText ?? "")
                        }
                        
                    })
                    
                    
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                            self.view.makeToast(serverError?.errors?.errorText ?? "")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("error = \(error?.localizedDescription)")
                            self.view.makeToast(error?.localizedDescription ?? "")
                        }
                        
                    })
                    
                }
            })
        })
        
    }
}

//MARK: - SelectContactDetailDelegate
extension ChatGroupViewController: SelectContactDetailDelegate {
    func selectContact(caontectName:String, ContactNumber:String) {
        let extendedParam = ["key":caontectName,"value": ContactNumber] as? [String:String]
        
        if let theJSONData = try?  JSONSerialization.data(withJSONObject:extendedParam ?? [:], options: []) {
            let theJSONText = String(data: theJSONData,encoding: String.Encoding.utf8)
            log.verbose("JSON string = \(theJSONText ?? "")")
            self.sendContact(jsonPayload: theJSONText)
        }
    }
    
    private func sendContact(jsonPayload:String?){
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        let jsonPayloadString = jsonPayload ??  ""
        let groupId = self.groupId
        let sessionID = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.sendContactToGroup(message_hash_id: messageHashId, groupId: groupId, sendType: "send", jsonPayload: jsonPayloadString, session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.fetchData()
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                        }
                    })
                } else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            })
        })
    }
}

extension ChatGroupViewController: didSelectGIFDelegate {
    
    func didSelectGIF(GIFUrl: String, id: String) {
        self.sendGIF(url: GIFUrl)
    }
    
    private func sendGIF(url:String) {
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        let sessionID = AppInstance.instance.sessionId ?? ""
        
        GroupChatManager.instance.sendGIF(message_hash_id: messageHashId,
                                          groupId: self.groupId,
                                          URl: url,
                                          session_Token: sessionID,
                                          type: "send") { (success, sessionError, serverError, error) in
            if success != nil{
                Async.main({
                    self.dismissProgressDialog {
                        self.view.resignFirstResponder()
                        
                        if self.messagesArray.count == 0 {
                        } else {
                            self.fetchData()
                            self.chatTableView.reloadData()
                            self.chatTableView.scrollToLastRow(animated: true)
                        }
                    }
                })
                
            } else if sessionError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(sessionError?.errors?.errorText)
                    }
                })
                
            } else if serverError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(serverError?.errors?.errorText)
                    }
                })
            } else {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(error?.localizedDescription)
                    }
                })
            }
        }
    }
}

//MARK: - sendLocationProtocol
extension ChatGroupViewController: sendLocationProtocol {
    
    func sendLocation(lat: Double, long: Double) {
        self.sendMessage(lat: lat, lag: long)
    }
    
}

extension ChatGroupViewController: MPAudioRecorderDelegate {
    func audioRecorderFailed(errorMessage: String){
        print(errorMessage)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        print("\(recorder) \n /n \(flag)")
        audioFileURL = recorder.url
        let audioData = try? Data(contentsOf: audioFileURL ?? URL(fileURLWithPath: ""))
        let fileExtension = String(recorder.url.lastPathComponent.split(separator: ".").last!)
        
        self.sendSelectedData(imageData: nil,
                              videoData: nil,
                              imageMimeType: nil,
                              VideoMimeType: nil,
                              Type: "audio",
                              fileData: nil,
                              fileExtension: nil,
                              FileMimeType: nil,
                              audio: audioData,
                              audioMineType: audioData?.mimeType,
                              audioExtension: fileExtension)
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("\(recorder) \n /n \(String(describing: error?.localizedDescription))")
    }
    
    func audioRecorderBeginInterruption(_ recorder: AVAudioRecorder){
        print("\(recorder)")
    }
    
    func audioRecorderEndInterruption(_ recorder: AVAudioRecorder, withOptions flags: Int){
        print("\(recorder) \n /n \(flags)")
    }
    
    func audioSessionPermission(granted: Bool){
        print(granted)
    }
}

extension ChatGroupViewController: GroupBottomMoreData {
    func groupBottomClick(name: String) {
        if name == "Update" {
            let groupInfo = UpdateGroupVC.initialize(from: .group)
            groupInfo.groupName = self.isGroupName
            groupInfo.groupImageString = self.isProfileImage
            groupInfo.groupID = self.groupId
            for index in 0..<groupsArray.count {
                let obj = groupsArray[index]
                if isGroupName == obj.groupName {
                    groupInfo.partsArray = obj.parts ?? []
                }
            }
            self.navigationController?.pushViewController(groupInfo, animated: true)
            
        } else if name  == "GroupInfo" {
            let groupInfo = GroupInfoViewController.initialize(from: .group)
            groupInfo.partsArray  = parts
            groupInfo.groupImage = self.isProfileImage
            for index in 0..<groupsArray.count {
                let obj = groupsArray[index]
                if isGroupName == obj.groupName {
                    groupInfo.partsArray = obj.parts ?? []
                }
            }
            groupInfo.GroupName = self.isGroupName
            groupInfo.groupID = self.groupId
            self.navigationController?.pushViewController(groupInfo, animated: true)
            
            
        } else if name == "Exit" {
            
            let alert = UIAlertController(title: NSLocalizedString("Exit Group", comment: "Exit Group"), message: NSLocalizedString("Are you sure you want to Exit Group ?", comment: "Are you sure you want to Exit Group ?"), preferredStyle: .alert)
            let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
            let logout = UIAlertAction(title: NSLocalizedString("Exit Group", comment: "Exit Group"), style: .destructive) { (action) in
                self.exitGroup()
            }
            alert.addAction(cancel)
            alert.addAction(logout)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
