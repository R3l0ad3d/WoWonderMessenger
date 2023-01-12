//
//  ChatViewController.swift
//  WoWonder
//
//  Created by Mac on 09/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async
import SwiftEventBus
import DropDown
import AVFoundation
import AVKit
import GoogleMaps
import ActionSheetPicker_3_0
import WowonderMessengerSDK
import ISEmojiView
import MobileCoreServices

class ChatViewController: BaseVC {
    
    //MARK: - All IBOutlet This View Controller
    @IBOutlet weak var topVeiw: UIView!
    @IBOutlet weak var callButton: UIControl!
    @IBOutlet weak var collectionMediaView: UIView!
    @IBOutlet weak var userActiveImagView: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userActiveStutesLabel: UILabel!
    @IBOutlet weak var userNamLabel: UILabel!
    @IBOutlet weak var backButton: UIControl!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendBtn: UIControl!
    @IBOutlet weak var voiceBtn: UIControl!
    @IBOutlet weak var pinMassageMainView: UIControl!
    @IBOutlet weak var pinMessageButton: UIControl!
    @IBOutlet weak var lastMessaegePinLabel: UILabel!
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
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var lastMessageType: UILabel!
    @IBOutlet weak var pinMessageLabel: UILabel!
    @IBOutlet weak var pinVIewSide: UIView!
    @IBOutlet weak var moreImageVIew: UIImageView!
    @IBOutlet weak var vidoeImageVIew: UIImageView!
    @IBOutlet weak var callImageView: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var mediaVIew: UIControl!
    
    //Variable's
    var limit = 1000
    //    var chatModel: Chats?
    var recipientID = ""
    var searchUserObject: SearchModel.User?
    var followingUserObject: FollowingModel.Following?
    var toUserID = ""
    var isAgora = true
    private var DocUrl = ""
    private var player = AVPlayer()
    private var playerItem: AVPlayerItem!
    private var playerController = AVPlayerViewController()
    private var isimagePicker = UIImagePickerController()
    private var isMedia = false
    private var isFirstTime = true
    private var scrollStatus = true
    private var isReplyStatus = false
    private var sendMessageAudioPlayer: AVAudioPlayer?
    var MessageLast = ""
    //    private var messagesArray = [Messages]() {
    //        didSet {
    //            self.chatModel?.addToMessages(NSSet(array: self.messagesArray))
    //            self.chatModel?.save()
    //
    //            guard let lastMsg = self.messagesArray.last,
    //                  let user = self.chatModel?.getFirstChatUser()?.user else {
    //                return
    //            }
    //            user.last_message = lastMsg
    //            user.save()
    //        }
    //    }
    var play = false
    private var admin = ""
    private var isimageName = URL(string: "")
    private var isPintext = ""
    private var isfavorites = false
    private var toneStatus = false
    private var textType = ""
    private var ispintime = ""
    private var replyMessageID = ""
    private var isPagination = false
    var object_LatSeen = ""
    private var offset: Int = 50
    var recordSeconds = 0
    var recordMinutes = 0
    var timer:Timer!
    private var soundPlay = AVAudioPlayer()
    let mpRecorder: MPAudioRecorder = MPAudioRecorder()
    var audioFileURL: URL?
    var isColor = ""
    var chatModel: Chats?
    private var messagesArray = [Messages]() {
        didSet {
            self.chatModel?.addToMessages(NSSet(array: self.messagesArray))
            self.chatModel?.save()
            
            guard let lastMsg = self.messagesArray.last,
                  let user = self.chatModel?.getFirstChatUser()?.user else {
                return
            }
            user.last_message = lastMsg
            user.save()
        }
    }
    var UserList: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: chatModel?.getChatUsers().first?.user?._avatar_url ?? searchUserObject?.avatar ?? followingUserObject?.avatar ?? "")
        self.userProfileImageView.kf.indicatorType = .activity
        self.userProfileImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_No_images"))
        self.userNamLabel.text = chatModel?.name ?? searchUserObject?.name ?? followingUserObject?.name ?? ""
        self.userNamLabel.textColor = UIColor.black
      
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        self.isColor = objColor as? String ?? ""
        
        self.SetUpScreenUI()
        self.fetchData()
                        
        if isColor != "" {
            self.pinVIewSide.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            self.pinMessageLabel.textColor = UIColor.hexStringToUIColor(hex: isColor)
            self.voiceBtn.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            self.sendBtn.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            self.mediaVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.callImageView.image = UIImage(named: "ic_chat_call_df")?.withRenderingMode(.alwaysTemplate)
            self.callImageView.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            
            self.vidoeImageVIew.image = UIImage(named: "ic_chat_Video_df")?.withRenderingMode(.alwaysTemplate)
            self.vidoeImageVIew.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.moreImageVIew.image = UIImage(named: "ic_chat_More_df")?.withRenderingMode(.alwaysTemplate)
            self.moreImageVIew.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.backButtonImage.image = UIImage(named: "ic_Group_Back")?.withRenderingMode(.alwaysTemplate)
            self.backButtonImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.userProfileImageView.borderColorV = UIColor.hexStringToUIColor(hex: isColor)
            self.userProfileImageView.borderWidthV = 1
        }
        self.pinMassageMainView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        let UserDefa = UserDefaults.standard
        let colorWallpaper = UserDefa.value(forKey: "colorWallpaper")
        let imgWallpaper = UserDefa.value(forKey: "imgWallpaper")
        
        if colorWallpaper != nil {
            self.chatTableView.backgroundColor = UIColor.hexStringToUIColor(hex: colorWallpaper as! String)
        } else if imgWallpaper != nil {
            self.chatTableView.backgroundColor = UIColor.clear
            self.bgImage.image = UIImage(data: imgWallpaper as! Data)
        } else {
            self.chatTableView.backgroundColor = UIColor.white
            
        }
        
        self.mpRecorder.delegateMPAR  = self
        
        self.riplayhightConstraint.constant = 0
        self.cancelButton.isHidden = true
        self.userNAmeRiplayLAbel.isHidden = true
        self.riplayMessgaeLabel.isHidden = true
        self.messageRiplayView.isHidden = true
        self.subRiplyView.isHidden = true
        
        self.fetchUserProfile()
        self.setSendBytton()
//        self.getScoketResposeData()
//        self.requesendMessage()
        
    }
    
//    func fecthDataChatList() {
//        ChatManager.instance.getUserMessages(user_id: AppInstance.instance._userId,
//                                             session_Token: AppInstance.instance.sessionId ?? "",
//                                             receipent_id: self.recipientID) { result in
//            switch result {
//            case.success(let data):
//                Async.main({
//                    self.dismissProgressDialog {
//                        self.messageArray = data.messages ?? []
//
////                        do {
////
////                            let encoder = JSONEncoder()
////
////                            // Encode Note
////                            let data = try encoder.encode(self.messageArray)
////                            // Write/Set Data
////                            UserDefaults.standard.set(self.messageArray, forKey: self.recipientID)
////                        } catch {
////                            print("Unable to Encode Note (\(error))")
////                        }
//
//                        self.chatTableView.reloadData()
//                        self.chatTableView.scrollToLastRow(animated: true)
//                        let indexPath = NSIndexPath(item: ((self.messageArray.count) - 1), section: 0)
//                        self.chatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//
//                        }
//                    })
//            case .failure(let error):
//                self.dismissProgressDialog {}
//                self.view.makeToast(error.localizedDescription)
//            }
//        }
//    }
    
    //MARK: - fetchData
    private func fetchData() {
        guard let localChat = self.chatModel else { return }
        let localMessages = Messages.getLastMessagesByChatID(localChat.my_id, limit: self.limit, ascending: false)
        
        if !localMessages.isEmpty {
            if self.messagesArray.isEmpty {
                self.messagesArray = localMessages.reversed()
                self.chatTableView.reloadData()
                self.chatTableView.scrollToLastRow(animated: true)
                self.isFirstTime = false
                
            } else {
                if let message = self.messagesArray.last {
                    self.sendAPIRequestMessages(limit: 35, afterMsgId: message._message_id) { [weak self] (list) in
                        guard let self = self else { return }
                        guard !list.isEmpty else { return }
                        
                        Messages.saveMessages(chatID: localChat.my_id, list)
                        let array = Messages.getLastMessagesByChatID(localChat.my_id, limit: self.limit, ascending: false)
                        self.messagesArray = array.reversed()
                        self.chatTableView.reloadData()
                        self.isFirstTime = false
                    }
                }
            }
            
        } else {
            self.sendAPIRequestMessages(limit: self.limit) { [weak self] (list) in
                guard let self = self else { return }
                
                Messages.saveMessages(chatID: localChat.my_id, list)
                self.messagesArray = Messages.getLastMessagesByChatID(localChat.my_id, limit: self.limit)
                self.chatTableView.reloadData()
            }
        }
    }

    func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        var keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        tableViewBottom.constant = keyboardSize - bottomLayoutGuide.length
        
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        tableViewBottom.constant = 0
        
        UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
    }
    
    
    func SetUpScreenUI() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.chatTableView.addGestureRecognizer(longPressRecognizer)
                        
        self.allregisterXIB()
        self.setmediaCollectionView()
        self.chatTableView.clipsToBounds = true
        self.chatTableView.layer.cornerRadius = 20
        self.chatTableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.collectionMediaView.isHidden = true
        
        var setTimer = ""
        setTimer = UserList?.lastseenUnixTime ?? ""
        
        if UserList?.lastseenStatus == "on" {
            self.userActiveStutesLabel.textColor = .green
            self.userActiveStutesLabel.text = "Online"
            self.userActiveStutesLabel.textColor = .green
        } else {
            self.userActiveStutesLabel.textColor = .lightGray
            self.userActiveStutesLabel.text = setTimestamp(epochTime: setTimer)
            
            self.userActiveImagView.isHidden = true
            self.userActiveStutesLabel.isHidden = false

        }
        
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
        
        self.chatTableView.register(ChatSender_TableCell.nib,
                                    forCellReuseIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier)
        self.chatTableView.register(ReplyChatSenderTableItem.nib,
                                    forCellReuseIdentifier: R.reuseIdentifier.replyChatSenderTableItem.identifier)
        self.chatTableView.register(replyReceiverTableItem.nib,
                                    forCellReuseIdentifier: R.reuseIdentifier.replyReceiverTableItem.identifier)
        self.chatTableView.scrollToLastRow(animated: true)
        
    }
    
    //MARK: - All
    @IBAction func cancleRecoding (_ sender: Any) {
        self.audioView.isHidden = true
        self.mpRecorder.stopAudioRecording()
        self.audioFileURL = nil
    }
    
    @IBAction func sendAudioRecoding (_ sender: Any) {
        self.mpRecorder.stopAudioRecording()
        self.audioView.isHidden = true
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
    
    @IBAction func pinMessageButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let pinVC = PinnedMessageVC.initialize(from: .chat)
//        pinVC.messagesArray = self.messageArray
        pinVC.profileImage = UserList?.avatar ?? ""
        self.navigationController?.pushViewController(pinVC, animated: true)
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
    
    @IBAction func moreButtonClick(_ sender: UIControl) {
        let moreBottonVC = MoreBottonViewController.initialize(from: .chat)
        moreBottonVC.delegate = self
        if #available(iOS 15.0, *) {
            if let sheet = moreBottonVC.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.detents = [
                        .custom { _ in
                            return 300
                        },
                    ]
                }
                self.present(moreBottonVC, animated: true)
            }
        }
    }
    
    @IBAction func sendButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if messageTextView.text != "" {
            print("Connection")
            //            if SocketHelper.shared.checkConnection() {
            //                let typingDone = [API.SOCKET_PARAMS.recipient_id: self.recipientID,
            //                                  API.SOCKET_PARAMS.user_id: AppInstance.instance.sessionId ?? ""]
            //                SocketHelper.shared.emit(emitName: "typing_done", params: typingDone)
            //
            //                let data = [API.SOCKET_PARAMS.to_id: toUserID,
            //                            API.SOCKET_PARAMS.from_id: AppInstance.instance._sessionId,
            //                            API.SOCKET_PARAMS.username: self.userNamLabel.text ?? "",
            //                            API.SOCKET_PARAMS.msg: messageTextView.text,
            //                            API.SOCKET_PARAMS.color: "",
            //                            API.SOCKET_PARAMS.isSticker: false] as [String : Any]
            //                SocketHelper.shared.emit(emitName: "private_message", params: data)
            //                print("It's call on private_message Socket")
            //
            //                self.messageTextView.text = ""
            //            } else {
            //                print("No Connection")
            //            }
            //        } else {
            //            print("messageTextView is empty")
            //        }
            
            if messageTextView.text != "" {
                //                self.sendMessage(messageText: messageTextView.text,
                //                                 lat: 0,
                //                                 long: 0,
                //                                 socketCheck: false)
                self.SendMessage(Text: messageTextView.text,
                                 lat: 0,
                                 lng: 0)
                self.messageTextView.text = ""
            } else {
                
            }
        }
    }
    
    func setmediaCollectionView() {
        UIView.animate(withDuration: 3, delay: 3) {
            if self.isMedia == true {
                self.mediaImageView.image  = UIImage(named: "close")
                self.collectionMediaView.isHidden = false
            } else {
                self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
                self.mediaImageView.tintColor = .white
                self.collectionMediaView.isHidden = true
            }
        }
    }
    
    private func fetchUserProfile() {
        let status = AppInstance.instance.getUserSession()
        
        if status {
            let sessionId = AppInstance.instance._sessionId
            
            Async.background({
                GetUserDataManager.instance.getUserData(user_id: self.recipientID, session_Token: sessionId, fetch_type: API.Params.User_data) { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.admin = success?.userData?.admin ?? ""
                        })
                    }else if sessionError != nil{
                        Async.main({
                        })
                    }else if serverError != nil{
                        Async.main({
                        })
                        
                    }else {
                        Async.main({
                        })
                    }
                }
            })
            
        }else {
            log.error(InterNetError)
        }
    }
    
    @IBAction func vidoeCallButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if isAgora == true {
            CallManager.instance.agoraCall(recipient_id: self.recipientID,
                                           access_token: AppInstance.instance.sessionId ?? "",
                                           type: "create",
                                           call_Type: "video") { response in
                switch response {
                    
                case .success(let data):
                    
//                    let vidoeCallVC = AgoraCallVC.initialize(from: .call)
//                    vidoeCallVC.callId = data._id
//                    vidoeCallVC.roomName = data.room_name ?? ""
//                    vidoeCallVC.profileImage.image = self.userProfileImageView.image
//                    self.navigationController?.pushViewController(vidoeCallVC, animated: true)
//
                    let vidoeCallVC = VideoCallVIewController.initialize(from: .call)
                    vidoeCallVC.callId = data.id
                    vidoeCallVC.roomID = data._room_name
                    self.navigationController?.pushViewController(vidoeCallVC, animated: true)
                case .failure(let error):
                    print("error Call Api => \(error)")
                    
                }
            }
        } else {
            
        }
    }
    
    @IBAction func callButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if isAgora == true {
            CallManager.instance.agoraCall(recipient_id: self.recipientID,
                                           access_token: AppInstance.instance.sessionId ?? "",
                                           type: "create",
                                           call_Type: "audio") { response in
                switch response {
                    
                case .success(let data):
                    let vidoeCallVC = AgoraCallVC.initialize(from: .call)
                    vidoeCallVC.callId = data._id
                    vidoeCallVC.roomName = data.room_name ?? ""
                    vidoeCallVC.user = self.UserList
                    self.navigationController?.pushViewController(vidoeCallVC, animated: true)
                    
                case .failure(let error):
                    print("error Call Api => \(error)")
                }
            }
        } else {
            
        }
    }
    
    @IBAction func photoButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button photoButtonClick")
            self.isimagePicker.delegate = self
            self.isimagePicker.sourceType = .photoLibrary
            self.isimagePicker.allowsEditing = true
            self.isimagePicker.mediaTypes = ["public.image", "public.movie"]
            present(self.isimagePicker, animated: true, completion: nil)
            self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
            self.mediaImageView.tintColor = .white
            self.collectionMediaView.isHidden = true
        }
    }
    
    @IBAction func documentButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
        self.collectionMediaView.isHidden = true
        let importMenu = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        importMenu.delegate = self
        self.present(importMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func conectButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
        self.collectionMediaView.isHidden = true
        let vc = R.storyboard.dashboard.inviteFriendsVC()
        vc?.status = true
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func gifButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
        self.collectionMediaView.isHidden = true
        let gifVC = GifVC.initialize(from: .chat)
        gifVC.delegate = self
        self.navigationController?.pushViewController(gifVC, animated: true)
    }
    
    @IBAction func stickerButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
        self.collectionMediaView.isHidden = true
    }
    
    @IBAction func audioButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
        self.collectionMediaView.isHidden = true
    }
    
    @IBAction func locationButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
        self.collectionMediaView.isHidden = true
        let vc = R.storyboard.chat.locationVC()
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.soundPlay.pause()
        self.play = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.mediaImageView.image  = UIImage(systemName: "circle.grid.2x2.fill")
        self.mediaImageView.tintColor = .white
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
    
//    private func requesendMessage() {
//        let message = self.messageArray.last
//    }
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
    
    private func blockUser() {
        let alert = UIAlertController(title: "", message: NSLocalizedString("You cannot block this user because it is administrator", comment: "You cannot block this user because it is administrator"), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
        let Block = UIAlertAction(title: NSLocalizedString("Block", comment: "Block"), style: .destructive) { (action) in
            self.UserBlock()
            
        }
        alert.addAction(cancel)
        alert.addAction(Block)
        self.present(alert, animated: true, completion:nil)
        
    }
        
    func UserBlock() {
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            BotttomSiteUserList.instance.blockUnblockUser(session_Token: sessionToken,
                                                         blockTo_userId: self.recipientID,
                                                         block_Action: "block",
                                                         completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(NSLocalizedString("User has been unblocked!!", comment: "User has been unblocked!!"))
                            self.dismiss(animated: true)
                        }
                    })
                    
                }else if sessionError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            self.dismiss(animated: true)
                        }
                    })
                    
                }else if serverError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            self.dismiss(animated: true)
                        }
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            self.dismiss(animated: true)
                        }
                    })
                }
            })
        })
    }
    
    //MARK: - setSendBytton
    func setSendBytton() {
        if self.messageTextView.text == "" {
            self.sendBtn.isHidden = true
            self.voiceBtn.isHidden = false
        } else {
//                        if SocketHelper.shared.checkConnection() {
//                            self.sendBtn.isHidden = false
//                            self.voiceBtn.isHidden = true
//                            let data = ["recipient_id": self.recipientID,
//                                        "user_id": AppInstance.instance.sessionId ?? ""]
//                            SocketHelper.shared.emit(emitName: "typing", params: data)
//                            print("It's call on private_message Socket")
//                        } else {
//                            SocketHelper.shared.connectSocket { (ConnectSocket) in
//                                print("connectSocket => \(ConnectSocket)")
//                            }
//                        }
            self.sendBtn.isHidden = false
            self.voiceBtn.isHidden = true
        }
    }
    
    
    //MARK: - TableView longPressed Click
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let objSender = sender.location(in: self.chatTableView)
        let indexPath = self.chatTableView.indexPathForRow(at: objSender)
        
        let navigaction = ChatBottomSiteViewController.initialize(from: .chat)
//        if #available(iOS 15.0, *) {
//            if let chatBottom = navigaction.sheetPresentationController {
//                chatBottom.detents = [.medium(),.large()]
//                chatBottom.prefersScrollingExpandsWhenScrolledToEdge = false
//                chatBottom.prefersGrabberVisible = true
//            }
//        } else {
//        }
        
        navigaction.modalPresentationStyle = .overCurrentContext
        navigaction.delegate = self
        navigaction.isBack = indexPath ?? IndexPath()
        present(navigaction, animated: true, completion: nil)
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
    
    //MARK: - DeleteMessage Calling Api Call
    private func deleteMsssage(messageID: String, indexPath: Int) {
        
        let sessionID = AppInstance.instance._sessionId
        Async.background({
            ChatManager.instance.deleteChatMessage(messageId: messageID , session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            //                            log.debug("userList = \(success?.message ?? "")")
                            self.messagesArray.remove(at: indexPath)
                            var favoriteAll =  UserDefaults.standard.getFavorite(Key: Local.FAVORITE.favorite)
                            var message = favoriteAll[self.recipientID] ?? []
                            
                            for (item,value) in message.enumerated() {
                                let favoriteMessage = try? PropertyListDecoder().decode(MessageModel.self ,from: value)
                                if favoriteMessage?.id == messageID{
                                    message.remove(at: item)
                                    break
                                }
                            }
                            favoriteAll[self.recipientID] = message
                            UserDefaults.standard.setFavorite(value: favoriteAll , ForKey: Local.FAVORITE.favorite)
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
    
//    func getScoketResposeData() {
//
//        SocketHelper.shared.responseSocket(socketType: "typing") { Data in
//            print("Data = \(Data)")
//        }
//
//        SocketHelper.shared.responseSocket(socketType: "private_message") { Data in
//            print("Data = \(Data)")
//        }
//    }
    
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
    
    //MARK: - AnimateReplty View
    fileprivate func animateRepltyView() {
        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.layoutSubviews, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
    
    func changeChatColor(receipentId: String, colorHexString: String ) {
        ColorManager.instanc.changeChatColor(session_Token: AppInstance.instance._sessionId,
                                             receipentId: receipentId,
                                             colorHexString: colorHexString) { Success, AuthError, ServerKeyError, error in
            
            if Success != nil {
                
                Async.main({
                    self.dismissProgressDialog {
                        //                        self.requesendMessage()
                        //                        self.chatTableView.reloadData()
                        //                        self.chatTableView.scrollToLastRow(animated: true)
                        self.view.makeToast("chager Color")
                    }
                })
                
            }else if AuthError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(AuthError?.errors?.errorText)
                    }
                })
                
            }else if ServerKeyError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(ServerKeyError?.errors?.errorText)
                    }
                })
                
            }else {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(error?.localizedDescription)
                    }
                })
            }
            
        }
    }
}

//MARK: - TableView Delegate & DataSource Method's
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objChatList = messagesArray[indexPath.row]
        guard let type = objChatList.type else { return UITableViewCell() }
                
        if objChatList.reply_id != "0" {
            switch type {
            case "left_text":
                
                //show text on right
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.replyReceiverTableItem.identifier) as? replyReceiverTableItem
                cell?.selectionStyle = .none
                let paragraph = NSMutableParagraphStyle()
                paragraph.tabStops = [ NSTextTab(textAlignment: .right, location: 0, options: [:]), ]
                
                let str = "\(self.decryptionAESModeECB(messageData: objChatList._text , key: objChatList._time) ?? objChatList._text)"
                
                if objChatList.from_id == AppInstance.instance._userId {
                    cell?.usernameLabel.text = "You"
                }else{
                    cell?.usernameLabel.text = self.userNamLabel.text ?? ""
                }
                
                if objChatList._type == "right_text" || objChatList._type == "left_text" {
                    cell?.userTextLabel.text = "\(self.decryptionAESModeECB(messageData: objChatList._text.htmlAttributedString ?? "", key: objChatList._time) ?? objChatList._text)"
                    
                } else if objChatList._type == "right_image" || objChatList._type == "left_image" {
                    cell?.userTextLabel.text = "Image"
                    
                } else if objChatList._type == "right_Adioes" || objChatList._type == "left_audio" {
                    cell?.userTextLabel.text = "Adioes"
                    
                } else if objChatList._type == "right_video" || objChatList._type == "left_video" {
                    cell?.userTextLabel.text = "Video"
                    
                } else if objChatList._type == "right_file" || objChatList._type == "left_file" {
                    cell?.userTextLabel.text = "File"
                    
                } else if objChatList._type == "right_contact" || objChatList._type == "left_contact" {
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
                cell?.messageTimelabel.text = objChatList._time_text
                
                if objChatList.fav == "on" {
                    cell?.starBtn.isHidden = false
                } else {
                    cell?.starBtn.isHidden = true
                }
                
                return cell ?? UITableViewCell()
                
            case "right_text":
                
                //show text on right
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.replyChatSenderTableItem.identifier) as? ReplyChatSenderTableItem
                cell?.selectionStyle = .none
                let paragraph = NSMutableParagraphStyle()
                paragraph.tabStops = [
                    NSTextTab(textAlignment: .right, location: 0, options: [:]),
                ]
                let str = "\(self.decryptionAESModeECB(messageData: objChatList._text.htmlAttributedString ?? "", key: objChatList._time) ?? objChatList._text)"
                
                if objChatList.from_id == AppInstance.instance._userId {
                    cell?.usernameLabel.text = "You"
                } else {
                    cell?.usernameLabel.text = self.userNamLabel.text ?? ""
                }
                
                if objChatList._type == "right_text" || objChatList._type == "left_text" {
                    cell?.userTextLabel.text = "\(self.decryptionAESModeECB(messageData: objChatList._text.htmlAttributedString ?? "", key: objChatList._time) ?? objChatList._text)"
                    
                } else if objChatList._type == "right_image" || objChatList._type == "left_image" {
                    cell?.userTextLabel.text = "Image"
                    
                } else if objChatList._type == "right_Adioes" || objChatList._type == "left_audio" {
                    cell?.userTextLabel.text = "Adioes"
                    
                } else if objChatList._type == "right_video" || objChatList._type == "left_video" {
                    cell?.userTextLabel.text = "Video"
                    
                } else if objChatList._type == "right_file" || objChatList._type == "left_file" {
                    cell?.userTextLabel.text = "File"
                    
                } else if objChatList._type == "right_contact" || objChatList._type == "left_contact" {
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
                if objChatList.fav == "on" {
                    cell?.starBtn.isHidden = false
                } else {
                    cell?.starBtn.isHidden = true
                }
                
                if isColor != "" {
                    cell?.backView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
                } else {
                    
                }
                
                return cell ?? UITableViewCell()
                
            default:
                break
            }
            
        } else {
            switch type {
            case "left_text":
                let lat = Double(objChatList.lat ?? "0.0") ?? 0.0
                let long = Double(objChatList.lng ?? "0.0") ?? 0.0
                
                if lat > 0.0 || long > 0.0 {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftLocationTableViewCell", for: indexPath) as? LeftLocationTableViewCell
                    cell?.googleMapView.isMyLocationEnabled = true
                    cell?.messageTim.text = objChatList.time_text
                    cell?.lat = lat
                    cell?.long = long
                    cell?.callDelegateMethod()
                    cell?.messageVIew.tag = indexPath.row
                    cell?.messageVIew.addTarget(self, action: #selector(setLocationNavigaction), for: .touchUpInside)
                    if objChatList.fav == "on" {
                        cell?.starImageVIew.isHidden = false
                    } else {
                        cell?.starImageVIew.isHidden = true
                    }
                    return cell ?? UITableViewCell()
                } else {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftTextTableViewCell", for: indexPath) as? LeftTextTableViewCell
                    self.setLeftTextData(cell: cell, indexPathForCell: indexPath)
                    return cell ?? UITableViewCell()
                }
                
            case "right_text":
                let lat = Double(objChatList.lat ?? "0.0") ?? 0.0
                let long = Double(objChatList.lng ?? "0.0") ?? 0.0
                
                if lat > 0.0 || long > 0.0 {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightLocationTableViewCell", for: indexPath) as? RightLocationTableViewCell
                    cell?.mapview.isMyLocationEnabled = true
                    cell?.messageTim.text = objChatList.time_text
                    cell?.lat = lat
                    cell?.long = long
                    cell?.callDelegateMethod()
                    cell?.messageVIew.tag = indexPath.row
                    cell?.messageVIew.addTarget(self, action: #selector(setLocationNavigaction), for: .touchUpInside)
                    if objChatList.fav == "on" {
                        cell?.starImageVIew.isHidden = false
                        
                    } else {
                        cell?.starImageVIew.isHidden = true
                    }
                    
                    if isColor != "" {
                        cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
                    } else {
                        cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
                    }
                    
                    return cell ?? UITableViewCell()
                } else {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as? RightTextTableViewCell
                    self.setRightTextData(cell: cell, indexPathForCell: indexPath)
                    return cell ?? UITableViewCell()
                }
                
            case "right_image":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightImageTableViewCell", for: indexPath) as? RightImageTableViewCell
                self.setRightImageData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_image":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftImageTableViewCell", for: indexPath) as? LeftImageTableViewCell
                self.setLeftImageData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_video":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftVidoeTableViewCell", for: indexPath) as? LeftVidoeTableViewCell
                self.setLeftVidoeData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_video":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightVidoeTableViewCell", for: indexPath) as? RightVidoeTableViewCell
                self.setRightVidoeData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_gif":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightGiftTableViewCell", for: indexPath) as? RightGiftTableViewCell
                self.setRightGiftData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_gif":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftGiftTableViewCell", for: indexPath) as? LeftGiftTableViewCell
                self.setLeftGiftData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_contact":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftContactTableViewCell", for: indexPath) as? LeftContactTableViewCell
                self.setLeftContactCell(cell: cell, indexpathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_contact":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightContactTableViewCell", for: indexPath) as? RightContactTableViewCell
                self.setRightContactCell(cell: cell, indexpathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_file":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightDocumentTableViewCell", for: indexPath) as? RightDocumentTableViewCell
                self.setRightDocumnetData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_file":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftDocumentTableViewCell", for: indexPath) as? LeftDocumentTableViewCell
                self.setLeftDocumnetData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "left_audio":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "LeftAudioTableViewCell", for: indexPath) as? LeftAudioTableViewCell
                self.setLeftAudioData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            case "right_audio":
                let cell = chatTableView.dequeueReusableCell(withIdentifier: "RightAudioTableViewCell", for: indexPath) as? RightAudioTableViewCell
                self.setrightAudioData(cell: cell, indexPathForCell: indexPath)
                return cell ?? UITableViewCell()
                
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    //    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    //        self.chatTableView.indexPathsForVisibleRows![0]
    //        chatTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
    //    }
    
    //MARK: - setLeftTextData
    private func setLeftTextData(cell: LeftTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let url = URL(string: UserList?.avatar ?? "")
        cell?.userProfileImageView.kf.indicatorType = .activity
        cell?.userProfileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList._text, key: objChatList._time) ?? objChatList._text)"
        
        cell?.masageTextLabel.text = "\(messageString)"
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeLabel.text = dateTime
        
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
    }

    func getFormattedDateFromUTC(RFC3339: String) -> String? {

        guard let date = getDateFromUTC(RFC3339: RFC3339),
            let timeZone = getTimeZoneFromUTC(RFC3339: RFC3339) else {
                return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma EEE, MMM d yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = timeZone // preserve local time zone
        return formatter.string(from: date)

    }
    
    func getDateFromUTC(RFC3339: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: RFC3339)
    }
    
    func getTimeZoneFromUTC(RFC3339: String) -> TimeZone? {

        switch RFC3339.suffix(6) {

        case "+05:30":
            return TimeZone(identifier: "Asia/Kolkata")

        case "+05:45":
            return TimeZone(identifier: "Asia/Kathmandu")

        default:
            return nil

        }

    }
    
    private func setRightTextData(cell: RightTextTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let messageString = "\(self.decryptionAESModeECB(messageData: objChatList._text, key: objChatList._time) ?? objChatList._text)"
        cell?.messaageTextLabel.text = "\(messageString)"
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeLabel.text = dateTime
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
        if isColor != "" {
            cell?.messgaeView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messgaeView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        }
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
    }
    
    private func setRightImageData(cell: RightImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let Url = URL(string: objChatList.media ?? "")
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: Url,  placeholder: UIImage(named: ""))
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
                
        cell?.messageTimeLabel.text = dateTime
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
        if isColor != "" {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")

            }
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")

            }
        }
    }
    
    //MARK: - LeftImageData Set
    private func setLeftImageData(cell: LeftImageTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let Url = URL(string: objChatList.media ?? "")
        let url = URL(string: objChatList.user?.avatar_url ?? "")
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        cell?.sendImageView.kf.indicatorType = .activity
        cell?.sendImageView.kf.setImage(with: Url,  placeholder: UIImage(named: ""))
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeLabel.text = dateTime
        
        cell?.messageVIew.tag = indexPathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
    }
    
    //MARK: - Right Document
    private func setRightDocumnetData(cell: RightDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeLabel.text = dateTime
        
        cell?.docNameLabel.text = objChatList.media_file_name
        let url = URL(string: objChatList.media ?? "")
        
        cell?.docTypeLabel.text = objChatList.file_size
        
        
        
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
        if isColor != "" {
            cell?.messageMainView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            cell?.documentImageview.image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
            cell?.documentImageview.tintColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageMainView.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
            cell?.documentImageview.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")

            }
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
            }
        }
        
        
        
    }
    
    //MARK: - Left Document
    private func setLeftDocumnetData(cell: LeftDocumentTableViewCell?, indexPathForCell: IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        let url = URL(string: objChatList.user?.avatar_url ?? "")
        cell?.profileImageView.kf.indicatorType = .activity
        cell?.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = dateTime
        cell?.docNameLabel.text = objChatList.media_file_name
        let urlDoc = URL(string: objChatList.media ?? "")
        let extenion =  urlDoc?.pathExtension
        cell?.docTypeLabel.text = objChatList.file_size
        cell?.messageMainView.tag = indexPathForCell.row
        cell?.messageMainView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
    }
    
    //MARK: - LeftVidoe
    private func setLeftVidoeData(cell: LeftVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let url = URL(string: objChatList.user?.avatar_url ?? "")
        cell?.ProfileImageVIew.kf.indicatorType = .activity
        cell?.ProfileImageVIew.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.messageTimeLabel.text = setTimestamp(epochTime: (objChatList.time ?? ""))
        let videoURL = URL(string: objChatList.media ?? "")
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
    }
    
    //MARK: - Right Vidoes
    private func setRightVidoeData(cell: RightVidoeTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let videoURL = URL(string: objChatList.media ?? "")
        if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
            cell?.vidoeImageVIew.image = thumbnailImage
        }
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        cell?.messageTimeLabel.text = dateTime

        
        cell?.playvidoeButton.tag = indexPathForCell.row
        cell?.playvidoeButton.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
        if isColor != "" {
            cell?.mesaageView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.mesaageView.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")

            }
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
            }
        }
    }
    
    //MARK: - Right Gift
    private func setRightGiftData(cell: RightGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeLabel.text = dateTime
        cell?.vidoeImageVIew.image = UIImage.gif(url: objChatList.stickers ?? "")
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
        if isColor != "" {
            cell?.messageView.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageView.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")

            }
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
            }
        }
    }
    //MARK: - Left Gift
    private func setLeftGiftData(cell: LeftGiftTableViewCell?, indexPathForCell:IndexPath) {
        let objChatList = messagesArray[indexPathForCell.row]
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeLabel.text = dateTime
        
        cell?.vidoeImageVIew.image = UIImage.gif(url: objChatList.stickers ?? "")
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        let url = URL(string: objChatList.user?.avatar_url ?? "")
        cell?.profileImge.kf.indicatorType = .activity
        cell?.profileImge.kf.setImage(with: url, placeholder: UIImage(named: ""))
    }
    
    private func setDateChatTableVIewData(cell: MessageDateTableViewCell?, indexpathForCell: IndexPath) {
    }
    
    //MARK: - Left Contact
    private func setLeftContactCell(cell: LeftContactTableViewCell?,  indexpathForCell: IndexPath) {
        let objChatList = self.messagesArray[indexpathForCell.row]
        
        let dic = convertStringToDictionary(text: (objChatList._text.htmlAttributedString!))
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key != "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        cell?.messageVIew.tag = indexpathForCell.row
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        
        cell?.messageTimeVIew.text = dateTime
        
        cell?.messageVIew.addTarget(self, action: #selector(openContact), for: .touchUpInside)
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
    }
    
    //MARK: - Right Contact
    private func setRightContactCell(cell: RightContactTableViewCell?,  indexpathForCell: IndexPath) {
        let objChatList = self.messagesArray[indexpathForCell.row]
        let dic = convertStringToDictionary(text: (objChatList._text.htmlAttributedString!))
        let key = "\(dic?["key"] ?? "")"
        let value = "\(dic?["value"] ?? "")"
        if key != "" {
            cell?.userNameLabel.text = key
        } else {
            cell?.userNameLabel.text = value
        }
        
        let time = Int(objChatList.time_text ?? "") ?? 0
        let dateTime = dataatual(time)
        cell?.messageTimeVIew.text = dateTime
        
        cell?.messageVIew.tag = indexpathForCell.row
        cell?.messageVIew.addTarget(self, action: #selector(openContact), for: .touchUpInside)
        
        if isColor != "" {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.messageVIew.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
        
        if objChatList.seen == "0" {
            cell?.lastseenImage.image = UIImage(named: "ic_seenCheck")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")

            }
        } else {
            cell?.lastseenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            if isColor != "" {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            } else {
                cell?.lastseenImage.tintColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
            }
        }
        
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
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
            print("TOTAL TIMER: \(minuteString):\(secondString)")
            
            cell?.playAudioView.tag = indexPathForCell.row
            cell?.playAudioView.addTarget(self, action: #selector(playAudioButtonClick), for: .touchUpInside)
        } catch {
            print(error)
        }
        
        let url1 = URL(string: objChatList.user?.avatar_url ?? "")
        cell?.profileImage.kf.indicatorType = .activity
        cell?.profileImage.kf.setImage(with: url1, placeholder: UIImage(named: ""))
        
        if isColor != "" {
            cell?.audioview.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
        } else {
            cell?.audioview.backgroundColor = UIColor.hexStringToUIColor(hex: "#8B4CFC")
        }
            
        
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
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
        
        
        let url1 = URL(string: objChatList.user?.avatar_url ?? "")
        cell?.userProfileImage.kf.indicatorType = .activity
        cell?.userProfileImage.kf.setImage(with: url1, placeholder: UIImage(named: ""))
        
        if objChatList.fav == "on" {
            cell?.starImageVIew.isHidden = false
        } else {
            cell?.starImageVIew.isHidden = true
        }
        
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
        let dic = convertStringToDictionary(text: (object._text.htmlAttributedString!))
        let phoneNumber = "\(dic?["value"] ?? "")"
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func setLocationNavigaction(_ sender: UIControl) {
        let object = self.messagesArray[sender.tag]
        let url = "http://maps.apple.com/maps?saddr=\(object.lat ?? ""),\(object.lng ?? "")"
        UIApplication.shared.openURL(URL(string:url)!)
        
    }
    
    
    func navigactionOnStoryboard(indexpath: Int, nameCell: String, isback: IndexPath) {
        var object = self.messagesArray[isback.row]
        if nameCell == "0" {
            let vc = MessageInfoViewController.initialize(from: .favorite)
            //            vc.object = object
            vc.recipientID = self.recipientID
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if nameCell == "1" {
            self.deleteMsssage(messageID: object.message_id ?? "", indexPath: isback.row)
            
        } else if nameCell == "2" {
            let cellClass = self.chatTableView.cellForRow(at: isback)
            let message = self.messagesArray[isback.row]
            
            let text = "\(self.decryptionAESModeECB(messageData: "\(object._text.htmlAttributedString ?? "")", key: object._time) ?? "")"
            
            if message._type == "right_text" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = text
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "left_text" {
                self.userNAmeRiplayLAbel.text = self.userNamLabel.text
                self.riplayMessgaeLabel.text = text
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if  message._type == "right_image" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "Image"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "left_image" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "Image"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "right_Adioes" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "Audio"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "left_audio" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "Audio"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "right_video" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "video"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "left_video" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "video"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "right_file" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "file"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "left_file" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "file"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "right_contact" {
                self.userNAmeRiplayLAbel.text = "You"
                self.riplayMessgaeLabel.text = "Contact"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
                
            } else if message._type == "left_contact" {
                self.userNAmeRiplayLAbel.text = userNamLabel.text
                self.riplayMessgaeLabel.text = "Contact"
                self.isReplyStatus = true
                self.replyMessageID = message._message_id
                self.swipeToReply(index: isback)
            }
            
        } else if nameCell == "3" {
            let vc = R.storyboard.favorite.getFriendVC()
            vc?.messageString = object._text
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else if nameCell == "4" {
            if object._pin == "" {
                
                if lastMessaegePinLabel.text == "" {
                } else {
                }
                
                let text = "\(self.decryptionAESModeECB(messageData: "\(object._text.htmlAttributedString ?? "")", key: object._time) ?? "")"
                object.pin = text
                //                self.isfavorites = object.is_favourite
                if object._type == "right_text" || object._type == "left_text" {
                    self.lastMessaegePinLabel.text = "Last Pin Message type: Text"
                    
                } else if object._type == "right_image" || object._type == "left_image" {
                    let url = URL(string: object.media ?? "")
                    let extenion =  url?.pathExtension
                    self.lastMessaegePinLabel.text = "Last Pin Message Type: Image.\(extenion ?? "")"
                    
                } else if object._type == "right_Adioes" || object._type == "left_audio" {
                    self.lastMessaegePinLabel.text = "Last Pin Message Type: Adioes"
                    
                } else if object._type == "right_video" || object._type == "left_video" {
                    self.lastMessaegePinLabel.text = "Last Pin Message Type: Video"
                    
                } else if object._type == "right_file" || object._type == "left_file" {
                    let url = URL(string: object.media ?? "")
                    let extenion =  url?.pathExtension
                    self.lastMessaegePinLabel.text = "Last Pin Message Type: File.\(extenion ?? "")"
                    
                } else if object._type == "right_contact" || object._type == "left_contact" {
                    self.lastMessaegePinLabel.text = "Last Pin Message Type: Contact"
                }
                
                let imageUrl = URL(string: object._media)
                self.isimageName = imageUrl
                self.textType = object.type ?? ""
                self.ispintime = object.time_text ?? ""
                self.isPintext = object._text
                self.pinMassageMainView.isHidden = false
//                self.userPinMassageLabel.text = text
                object.save()
            } else {
                self.pinMassageMainView.isHidden = true
                object.pin = ""
                object.save()
            }
        } else if nameCell == "5" {
            if (object.fav != nil) {
                object.is_favourite = false
                object.save()
                self.chatTableView.reloadData()
            } else {
                object.is_favourite = true
                object.save()
                self.chatTableView.reloadData()
            }
        }
    }
}

// MARK: - IMAGE PICKER DELEGATE
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = image.jpegData(compressionQuality: 0.1)
            self.sendSelectedData(audioData: nil,
                                  imageData: imageData,
                                  videoData: nil,
                                  imageMimeType: imageData?.mimeType,
                                  VideoMimeType: nil,
                                  audioMimeType: nil,
                                  Type: "image",
                                  fileData: nil,
                                  fileExtension: nil,
                                  FileMimeType: nil)
        }
        
        if let fileURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            let videoData = try? Data(contentsOf: fileURL)
            self.sendSelectedData(audioData: nil,
                                  imageData: nil,
                                  videoData: videoData,
                                  imageMimeType: nil,
                                  VideoMimeType: videoData?.mimeType,
                                  audioMimeType: nil,
                                  Type: "video",
                                  fileData: nil,
                                  fileExtension: nil,
                                  FileMimeType: nil)
        }
    }
}

// MARK: - DOCUMENT PICKER DELEGATE
extension ChatViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        controller.dismiss(animated: true)
        let fileData = try? Data(contentsOf: url)
        let fileExtension = String(url.lastPathComponent.split(separator: ".").last!)
        self.sendSelectedData(audioData: nil,
                              imageData: nil,
                              videoData: nil,
                              imageMimeType: nil,
                              VideoMimeType: nil,
                              audioMimeType: nil,
                              Type: "file",
                              fileData: fileData,
                              fileExtension: fileExtension,
                              FileMimeType: fileData?.mimeType)
    }
}

// MARK: - TEXT VIEW DELEGATE

extension ChatViewController: UITextViewDelegate {
    
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
}

//MARK: - passiBottomArrayDelegate's
extension ChatViewController: passiBottomArrayDelegate {
    func passingdata(_ viewController: ChatBottomSiteViewController, indexpath: Int, nameof: String, isBack: IndexPath) {
        self.navigactionOnStoryboard(indexpath: indexpath, nameCell: nameof, isback: isBack)
    }
}

//MARK: - MoreBottonDelegate
extension ChatViewController: MoreBottonDelegate {
    func clickIndex(IndexCllick: String?) {
        if IndexCllick == "0" {
            let vc = R.storyboard.dashboard.userProfileVC()
            vc?.isFollowing = 0
            vc?.getUserData(user_ID: UserList?._userID ?? "")
            vc?.isfind = false
//            vc?.messageArray = self.messageArray
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }
            
        } else if IndexCllick == "1" {
            self.blockUser()
            
        } else if IndexCllick == "2" {
            let ChangeColorVC = ChangerColorViewController.initialize(from: .chat)
            ChangeColorVC.modalPresentationStyle = .overCurrentContext
            ChangeColorVC.delagete = self
            self.present(ChangeColorVC, animated: true)
            
        } else if IndexCllick == "3" {
            let WallpaperVC = WallpaperViewController.initialize(from: .settings)
            self.navigationController?.pushViewController(WallpaperVC, animated: true)
            
        } else if IndexCllick == "4" {
            
            
        } else if IndexCllick == "5" {
            let vc = self.getStoryboardView(MediaViewController.self)
//            vc.messageArray = self.messageArray
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Api call on send Media Controller
extension ChatViewController {
    private func sendSelectedData(audioData: Data?,
                                  imageData: Data?,
                                  videoData: Data?,
                                  imageMimeType: String?,
                                  VideoMimeType: String?,
                                  audioMimeType: String?,
                                  Type: String?,
                                  fileData: Data?,
                                  fileExtension: String?,
                                  FileMimeType: String?) {
        
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        let sessionId = AppInstance.instance._sessionId
        let dataType = Type ?? ""
        
        if dataType == "image" {
            Async.background({
                ChatManager.instance.sendChatData(message_hash_id: messageHashId, receipent_id: self.recipientID, session_Token: sessionId, type: dataType, audio_data: nil, image_data: imageData, video_data: nil, imageMimeType: imageMimeType, videoMimeType: nil, audioMimeType: nil, text: "", file_data: nil, file_Extension: nil, fileMimeType: nil) { (success, sessionError, serverError, error) in
                    
                    if success != nil {
                        
                        Async.main({
                            self.dismissProgressDialog {
                                self.fetchData()
                                self.chatTableView.reloadData()
                                self.chatTableView.scrollToLastRow(animated: true)
                            }
                        })
                        
                    }else if sessionError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                            }
                        })
                        
                    }else if serverError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                            }
                        })
                        
                    }else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                            }
                        })
                    }
                }
            })
        }
        //To send an audio message
        else if dataType == "audio" {
            Async.background({
                ChatManager.instance.sendChatData(message_hash_id: messageHashId, receipent_id: self.recipientID, session_Token: sessionId, type: dataType, audio_data: audioData, image_data: nil, video_data: nil, imageMimeType: nil, videoMimeType: nil,audioMimeType: audioMimeType, text: "", file_data: nil, file_Extension: "wav", fileMimeType: nil) { (success, sessionError, serverError, error) in
                    
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.fetchData()
                                self.chatTableView.reloadData()
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
                }
            })
        }
        
        else if dataType == "video" {
            
            Async.background({
                ChatManager.instance.sendChatData(message_hash_id: messageHashId,
                                                  receipent_id: self.recipientID,
                                                  session_Token: sessionId,
                                                  type: dataType,
                                                  audio_data: nil,
                                                  image_data: nil,
                                                  video_data: videoData,
                                                  imageMimeType: nil,
                                                  videoMimeType: VideoMimeType,
                                                  audioMimeType: nil,
                                                  text: "",
                                                  file_data: nil,
                                                  file_Extension: nil,
                                                  fileMimeType: nil) { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                self.fetchData()
                                self.chatTableView.reloadData()
                                self.chatTableView.scrollToLastRow(animated: true)
                                
                            }
                        })
                    }else if sessionError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                            }
                        })
                    }else if serverError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                            }
                        })
                        
                    }else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                            }
                        })
                    }
                }
            })
            
        } else {
            Async.background({
                ChatManager.instance.sendChatData(message_hash_id: messageHashId,
                                                  receipent_id: self.recipientID,
                                                  session_Token: sessionId,
                                                  type: dataType,
                                                  audio_data: nil,
                                                  image_data: nil,
                                                  video_data: nil,
                                                  imageMimeType: nil,
                                                  videoMimeType: nil,
                                                  audioMimeType: nil,
                                                  text: "",
                                                  file_data: fileData,
                                                  file_Extension: fileExtension,
                                                  fileMimeType: FileMimeType) { (success, sessionError, serverError, error) in
                    
                    if success != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.fetchData()
                                self.chatTableView.reloadData()
                                self.chatTableView.scrollToLastRow(animated: true)
                            }
                        })
                        
                    }else if sessionError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                            }
                        })
                    }else if serverError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                            }
                        })
                        
                    }else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                            }
                        })
                    }
                }
            })
        }
    }
}

// MARK: - DID SELECT GIF
extension  ChatViewController: didSelectGIFDelegate {
    
    func didSelectGIF(GIFUrl: String, id: String) {
        self.sendGIF(url: GIFUrl)
    }
    
    private func sendGIF(url:String) {
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        let recipientId = self.recipientID
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            ChatManager.instance.sendGIF(message_hash_id: messageHashId, receipent_id: recipientId, URl:url , session_Token: sessionID) { (success, sessionError, serverError, error) in
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
        })
    }
    
    private func playSendMessageSound() {
        guard let url = Bundle.main.url(forResource: "Popup_SendMesseges", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            self.sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            self.sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let aPlayer = sendMessageAudioPlayer else { return }
            aPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - SELECT CONTACT DEELGATE
extension ChatViewController: SelectContactDetailDelegate {
    func selectContact(caontectName:String, ContactNumber:String) {
        let extendedParam = ["key":caontectName,"value": ContactNumber] as? [String:String]
        
        if let theJSONData = try?  JSONSerialization.data(withJSONObject:extendedParam ?? [:], options: []) {
            let theJSONText = String(data: theJSONData,encoding: String.Encoding.utf8)
            log.verbose("JSON string = \(theJSONText ?? "")")
            self.sendContact(jsonPayload: theJSONText)
        }
    }
    
    private func sendContact(jsonPayload:String?) {
        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
        
        ChatManager.instance.sendContactApiCall(message_hash_id: messageHashId,
                                                receipent_id: self.recipientID,
                                                sendType: "send",
                                                jsonPayload: jsonPayload ?? "",
                                                session_Token: AppInstance.instance.sessionId ?? "") { (success, sessionError, serverError, error) in
            if success != nil {
                Async.main({
                    self.dismissProgressDialog {
//                        self.requesendMessage()
                        let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
                        self.chatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                        
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

// MARK: - SEND LOCATION PROTOCOL
extension ChatViewController: sendLocationProtocol {
    
    func sendLocation(lat: Double, long: Double) {
        self.SendMessage(Text: "",
                         lat: lat,
                         lng: long)
    }
        
    func SendMessage(Text: String, lat: Double, lng: Double) {
        let replyID = self.replyMessageID
        let sessionToken = AppInstance.instance._sessionId
        
        ChatManager.instance.sendMessage(message: Text,
                                         session_token: sessionToken,
                                         ReceipientId: self.recipientID,
                                         lat: lat,
                                         lng: lng,
                                         reply_id: replyID) { Success, AuthError, ServerKeyError, error in
            if Success != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.resignFirstResponder()
                        
                        
                        guard self.messagesArray.count != 0 else { return }
                        if self.toneStatus {
                            self.playSendMessageSound()
                        } else {
                        }
                        
                        if self.isReplyStatus {
                            self.riplayhightConstraint.constant = 0
                            self.cancelButton.isHidden = true
                            self.userNAmeRiplayLAbel.isHidden = true
                            self.riplayMessgaeLabel.isHidden = true
                            self.messageRiplayView.isHidden = true
                            self.subRiplyView.isHidden = true
                            self.messageTextView.becomeFirstResponder()
                            self.replyMessageID = ""
                            self.isReplyStatus = false
                        }
                        self.fetchData()
                        
                    }
                })
                
            } else if AuthError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(AuthError?.errors?.errorText)
                    }
                })
                
            } else if ServerKeyError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(ServerKeyError?.errors?.errorText)
                    }
                })
                
            }else {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(error?.localizedDescription)
                    }
                })
            }
        }
    }
}

//MARK: - UIDocumentInteractionController Delegate Method's
extension ChatViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    
}

//MARK: - AudioRecoding and sending
extension ChatViewController: MPAudioRecorderDelegate {
    
    func audioRecorderFailed(errorMessage: String){
        print(errorMessage)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        print("\(recorder) \n /n \(flag)")
        audioFileURL = recorder.url
        let audioData = try? Data(contentsOf: audioFileURL ?? URL(fileURLWithPath: ""))
        self.sendSelectedData(audioData: audioData,
                              imageData: nil,
                              videoData: nil,
                              imageMimeType: nil,
                              VideoMimeType: nil,
                              audioMimeType: audioData?.mimeType,
                              Type: "audio",
                              fileData: nil,
                              fileExtension: nil,
                              FileMimeType: nil)
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

extension ChatViewController: changeColor {
    func chagerColor(hex: String) {
        
        UserDefaults.standard.setChatColorHex(value: "\(hex)", ForKey: "ColorTheme")
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        self.isColor = objColor as? String ?? ""
                
        self.viewWillAppear(true)
        
        self.userProfileImageView.borderColorV = UIColor.hexStringToUIColor(hex: isColor)
        self.userProfileImageView.borderWidthV = 1
        self.chatTableView.reloadData()
        
        if isColor != "" {
            self.pinVIewSide.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            self.pinMessageLabel.textColor = UIColor.hexStringToUIColor(hex: isColor)
            self.voiceBtn.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            self.sendBtn.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            self.mediaVIew.backgroundColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.callImageView.image = UIImage(named: "ic_chat_call_df")?.withRenderingMode(.alwaysTemplate)
            self.callImageView.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            
            self.vidoeImageVIew.image = UIImage(named: "ic_chat_Video_df")?.withRenderingMode(.alwaysTemplate)
            self.vidoeImageVIew.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.moreImageVIew.image = UIImage(named: "ic_chat_More_df")?.withRenderingMode(.alwaysTemplate)
            self.moreImageVIew.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.backButtonImage.image = UIImage(named: "ic_Group_Back")?.withRenderingMode(.alwaysTemplate)
            self.backButtonImage.tintColor = UIColor.hexStringToUIColor(hex: isColor)
            
            self.userProfileImageView.borderColorV = UIColor.hexStringToUIColor(hex: isColor)
            self.userProfileImageView.borderWidthV = 1
        }
        
//        ColorManager.instanc.changeChatColor(session_Token: AppInstance.instance._sessionId,
//                                             receipentId: self.recipientID,
//                                             colorHexString: objColor as! String) { Success, AuthError, ServerKeyError, error in
//            if Success != nil{
//                Async.main({
//                    if Success != nil {
//                        print("Success => \(Success?.color)")
//                    }
//                })
//            }else if AuthError != nil{
//                Async.main({
//                    self.view.makeToast(AuthError?.errors?.errorText)
//                })
//            }else if ServerKeyError != nil{
//                Async.main({
//                    self.view.makeToast(ServerKeyError?.errors?.errorText)
//                })
//                
//            }else {
//                Async.main({
//                    self.view.makeToast(error?.localizedDescription)
//                })
//            }
//        }
    }
}
