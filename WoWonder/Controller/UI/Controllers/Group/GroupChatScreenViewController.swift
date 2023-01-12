////
////  GroupChatScreenViewController.swift
////  WoWonder
////
////  Created by UnikaApp on 15/10/22.
////  Copyright © 2022 ScriptSun. All rights reserved.
////
//
//import UIKit
////import SDWebImage
//import DropDown
//import ISEmojiView
//import Async
//import SwiftEventBus
//import DropDown
//import AVFoundation
//import AVKit
//import GoogleMaps
//import ActionSheetPicker_3_0
//import WowonderMessengerSDK
//import ISEmojiView
//import MobileCoreServices
//import Kingfisher
//

import UIKit
class GroupChatScreenViewController: UIViewController {
    
}
//    
//    //MARK: - All IBOutlet This ViewController
//    @IBOutlet private weak var emojiButton: UIButton!
//    @IBOutlet private weak var userAddTextView: UITextView!
//    @IBOutlet private weak var sendButton: UIButton!
//    @IBOutlet private weak var voiceButton: UIButton!
//    @IBOutlet private weak var mediaButton: UIButton!
//    @IBOutlet private weak var userStatusLabel: UILabel!
//    @IBOutlet private weak var RiplayUserName: UILabel!
//    @IBOutlet private weak var profileImage: UIImageView!
//    @IBOutlet private weak var backButton: UIButton!
//    @IBOutlet private weak var userNameLabel: UILabel!
//    @IBOutlet private weak var riplayTextLabel: UILabel!
//    @IBOutlet private weak var riplayMessageView: UIView!
//    @IBOutlet private weak var lineRiplayview: UIView!
//    @IBOutlet private weak var cancleRiplayButtonClick: UIButton!
//    @IBOutlet private weak var palyAdioButton: UIButton!
//    @IBOutlet private weak var cancleButton: UIButton!
//    @IBOutlet private weak var adioaView: UIView!
//    @IBOutlet private weak var riplaymainView: UIView!
//    @IBOutlet private weak var groupChatTableView: UITableView!
//    @IBOutlet private weak var pinMainView: UIControl!
//    @IBOutlet private weak var topView: UIView!
//    @IBOutlet private weak var moreButton: UIButton!
//    @IBOutlet weak var pinMessageHightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var audioMessageHightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var riplayHightConstraint: NSLayoutConstraint!
//    
//    //Variable's
//    var isProfileImage = ""
//    var isGroupName = ""
//    var recipientID = ""
//    var chatModel: Chats?
//    var messagesArray = [GroupChatModel.Message]()
//    var groupId = ""
//    var groupOBject: FetchGroupModel.Datum?
//    var parts = [FetchGroupModel.UserData]()
//    var DocUrl = ""
//    var audioDuration = ""
//    var isFistTry = true
//    private var isMedia = false
//    private var scrollStatus:Bool? = true
//    private var messageCount = 0
//    private var toneStatus = false
//    private var receiveMessageAudioPlayer: AVAudioPlayer?
//    private var player = AVPlayer()
//    private var sendMessageAudioPlayer: AVAudioPlayer?
//    private var playerItem: AVPlayerItem?
//    private var isReplyStatus = false
//    private var replyMessageID = ""
//    
//    //Let
//    private let moreDropdown = DropDown()
//    private let imagePickerController = UIImagePickerController()
//    private let MKColorPicker = ColorPickerViewController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        self.setUpScreen()
//    }
//    
//    private func setUpScreen() {
//        self.riplaymainView.isHidden = true
//        self.adioaView.isHidden = true
//        self.pinMainView.isHidden = true
//        
//        self.userNameLabel.text = ""
//        
//        let URL = URL(string: isProfileImage)
//        self.profileImage.kf.indicatorType = .activity
//        self.profileImage.kf.setImage(with: URL, placeholder: UIImage(named: ""))
//        self.userNameLabel.text = isGroupName
//        
//        self.topView.clipsToBounds = true
//        self.topView.layer.cornerRadius = 20
//        self.topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        
//        //Shadow in Top View
//        self.topView.layer.shadowColor = UIColor.darkGray.cgColor
//        self.topView.layer.masksToBounds = false
//        self.topView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.topView.layer.shadowRadius = 2
//        self.topView.layer.shadowOpacity = 0.5
//        
//        self.customizeDropdown()
//        self.fetchData()
//        
//        self.riplayHightConstraint.constant = 0
//        self.pinMessageHightConstraint.constant = 0
//        self.pinMessageHightConstraint.constant = 0
//        
//        self.groupChatTableView.separatorStyle = .none
//        groupChatTableView.register( R.nib.chatSenderTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatReceiverTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatReceiver_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatSenderImageTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatReceiverImageTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatSenderContactTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatSenderContact_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatReceiverContactTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatReceiverContact_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatSenderStickerTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatSenderSticker_TableCel.identifier)
//        groupChatTableView.register( R.nib.chatReceiverStrickerTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatReceiverStricker_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatSenderAudioTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatSenderAudio_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatReceiverAudioTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatReceiverAudio_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatSenderDocumentTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatSenderDocument_TableCell.identifier)
//        groupChatTableView.register( R.nib.chatReceiverDocumentTableCell(), forCellReuseIdentifier: R.reuseIdentifier.chatReceiverDocument_TableCell.identifier)
//        
//    }
//    
//    @IBAction func cancleRiplaymainView(_ sender: Any) {
//        self.view.endEditing(true)
//    }
//    
//    @IBAction func emojiButtonClick(_ sender: Any) {
//        self.view.endEditing(true)
//    }
//    
//    @IBAction func sendButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//        if self.userAddTextView.text == NSLocalizedString("Your message here...", comment: "Your message here...") {
//        }else {
//            if !userAddTextView.text!.isEmpty {
////                self.sendMessage()
//                self.userAddTextView.text.removeAll()
//                              
//
//            }
//        }
//    }
//    
//    @IBAction func palyAdioButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//    }
//    
//    @IBAction func voiceButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//    }
//    @IBAction func mediaButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//        self.mediaControl()
//    }
//    
//    @IBAction func moreButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//        self.moreDropdown.show()
//    }
//    
//    @IBAction func vidoeButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//    }
//    
//    @IBAction func callButtonClick(_ sender: Any) {
//        self.view.endEditing(true)
//    }
//    
//    @IBAction func backButtonClick(_ sender: UIButton) {
//        self.view.endEditing(true)
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    private func customizeDropdown() {
//        self.moreDropdown.dataSource = [NSLocalizedString("Add Members", comment: "Add Members"),
//                                        NSLocalizedString("Group Info", comment: "Group Info"),
//                                        NSLocalizedString("Exit Group", comment: "Exit Group")]
//        self.moreDropdown.backgroundColor = UIColor.hexStringToUIColor(hex: "454345")
//        self.moreDropdown.textColor = UIColor.white
//        moreDropdown.anchorView = self.moreButton
//        self.moreDropdown.width = 200
//        self.moreDropdown.direction = .any
//        self.moreDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
//            if index == 0 {
//                
//            } else if index == 1 {
//                
//            } else if index == 2 {
//                
//            }
//        }
//    }
//    
//    func mediaControl() {
//        let alert = UIAlertController(title:NSLocalizedString("Select what you want", comment: "Select what you want"), message: "", preferredStyle: .actionSheet)
//        
//        let gallery = UIAlertAction(title: NSLocalizedString("Image Gallery", comment: "Image Gallery"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            
//            self.imagePickerController.delegate = self
//            self.imagePickerController.allowsEditing = true
//            self.imagePickerController.sourceType = .photoLibrary
//            self.present(self.imagePickerController, animated: true, completion: nil)
//        }
//        
//        let camera = UIAlertAction(title: NSLocalizedString("Take a picture from the camera", comment: "Take a picture from the camera"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            
//            self.imagePickerController.delegate = self
//            self.imagePickerController.allowsEditing = true
//            self.imagePickerController.sourceType = .camera
//            self.present(self.imagePickerController, animated: true, completion: nil)
//        }
//        
//        let video = UIAlertAction(title: NSLocalizedString("Video Gallery", comment: "Video Gallery"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            self.openVideoGallery()
//        }
//        
//        let location = UIAlertAction(title: NSLocalizedString("Location", comment: "Location"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            let vc = R.storyboard.chat.locationVC()
//            vc?.delegate = self
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
//        
//        let contact = UIAlertAction(title: NSLocalizedString("Contact", comment: "Contact"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            let vc = R.storyboard.dashboard.inviteFriendsVC()
//            vc?.status = true
//            vc?.delegate = self
//            self.present(vc!, animated: true, completion: nil)
//        }
//        
//        let file = UIAlertAction(title: NSLocalizedString("File", comment: "File"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            
//            //            log.verbose("File")
//            let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
//            documentPicker.delegate = self
//            self.present(documentPicker, animated: true, completion: nil)
//        }
//        
//        let gif = UIAlertAction(title: NSLocalizedString("Gif", comment: "Gif"), style: .default) { [weak self] (action) in
//            guard let self = self else { return }
//            
//            //            log.verbose("Gif")
//            let vc = R.storyboard.chat.gifVC()
//            vc?.delegate = self
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
//        
//        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
//        alert.addAction(gallery)
//        alert.addAction(camera)
//        alert.addAction(video)
//        alert.addAction(location)
//        alert.addAction(file)
//        alert.addAction(gif)
//        alert.addAction(contact)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    private func openVideoGallery() {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
//        picker.mediaTypes = ["public.movie"]
//        
//        picker.allowsEditing = false
//        present(picker, animated: true, completion: nil)
//    }
//    
//    //MARK: - ButtonSet Send
//    func setSendButton() {
//        if self.userAddTextView.text == "" {
//            self.sendButton.isHidden = true
//            self.voiceButton.isHidden = false
//        } else {
//            self.sendButton.isHidden = false
//            self.voiceButton.isHidden = true
//        }
//    }
//    
//    //MARK: - send Text Message's
////    private func sendMessage(){
////        self.messagesArray.removeAll()
////        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
////        let messageText = userAddTextView.text ?? ""
////        let groupId = self.groupId
////        let sessionID = AppInstance.instance.sessionId ?? ""
////
////        Async.background({
////            GroupChatManager.instance.sendMessageToGroup(message_hash_id: messageHashId, GroupId: groupId, text: messageText, type: "send", session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
////                if success != nil{
////                    Async.main({
////                        self.dismissProgressDialog {
////                            if self.messagesArray.count == 0{
////                                log.verbose("Will not scroll more")
////                                self.userAddTextView.text = ""
////                                self.view.resignFirstResponder()
////                            }else{
////                                if self.toneStatus{
////                                    self.playSendMessageSound()
////                                }else{
////                                    log.verbose("To play sound please enable conversation tone from settings..")
////                                }
////                                self.userAddTextView.text = ""
////                                //                                self.textViewPlaceHolder()
////                                self.view.resignFirstResponder()
////                                log.debug("userList = \(success?.apiStatus ?? 0)")
////                                let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
////                                self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
////                                self.groupChatTableView.reloadData()
////                            }
////
////
////                        }
////                    })
////                }else if sessionError != nil{
////                    Async.main({
////                        self.dismissProgressDialog {
////                            self.view.makeToast(sessionError?.errors?.errorText)
////                            log.error("sessionError = \(sessionError?.errors?.errorText)")
////
////
////                        }
////                    })
////                }else if serverError != nil{
////                    Async.main({
////                        self.dismissProgressDialog {
////                            self.view.makeToast(serverError?.errors?.errorText)
////                            log.error("serverError = \(serverError?.errors?.errorText)")
////                        }
////
////                    })
////
////                }else {
////                    Async.main({
////                        self.dismissProgressDialog {
////                            self.view.makeToast(error?.localizedDescription)
////                            log.error("error = \(error?.localizedDescription)")
////                        }
////                    })
////                }
////            })
////        })
////    }
//}
//
////MARK: - UIImagePickerControllerDelegate & NavigationController
//extension GroupChatScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true)
//        
//        if  let image:UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            
//            log.verbose("image = \(image ?? nil ?? UIImage(named: "") ?? UIImage())")
//            let imageData = image.jpegData(compressionQuality: 0.1)
//            log.verbose("MimeType = \(imageData?.mimeType ?? "")")
//            sendSelectedData(imageData: imageData, videoData: nil, imageMimeType: imageData?.mimeType, VideoMimeType: nil, Type: "image", fileData: nil, fileExtension: nil, FileMimeType: nil)
//        }
//        
//        if let fileURL:URL? = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
//            
//            if let url = fileURL {
//                let videoData = try? Data(contentsOf: url)
//                log.verbose("MimeType = \(videoData?.mimeType ?? "")")
//                print(videoData?.mimeType as Any)
//                sendSelectedData(imageData: nil, videoData: videoData, imageMimeType: nil, VideoMimeType: videoData?.mimeType, Type: "video", fileData: nil, fileExtension: nil, FileMimeType: nil)
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//}
//
//// MARK: - DOCUMENT PICKER DELEGATE
//extension GroupChatScreenViewController: UIDocumentPickerDelegate {
//    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL?) {
//        let cico = url as? URL
//        print(cico)
//        print(url)
//        print(url!.lastPathComponent.split(separator: ".").last)
//        print(url!.pathExtension)
//        if let urlfile = url {
//            let fileData = try? Data(contentsOf: urlfile)
//            log.verbose("File Data = \(fileData)")
//            log.verbose("MimeType = \(fileData?.mimeType)")
//            
//            let fileExtension = String(url!.lastPathComponent.split(separator: ".").last!)
//            sendSelectedData(imageData: nil, videoData: nil, imageMimeType: nil, VideoMimeType: nil, Type: "file", fileData: fileData, fileExtension: fileExtension, FileMimeType: fileData?.mimeType)
//        }
//    }
//}
//
//// MARK: - DID SELECT GIF
//extension  GroupChatScreenViewController: didSelectGIFDelegate {
//    func didSelectGIF(GIFUrl: String, id: String) {
//        self.sendGIF(url: GIFUrl)
//    }
//    
//    private func sendGIF(url:String) {
//        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
//        //        let messageText = messageTxtView.text ?? ""
//        let recipientId = self.recipientID
//        let sessionID = AppInstance.instance._sessionId
//        
//        Async.background({
//            ChatManager.instance.sendGIF(message_hash_id: messageHashId, receipent_id: recipientId, URl:url , session_Token: sessionID) { (success, sessionError, serverError, error) in
//                if success != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.resignFirstResponder()
//                            
//                            if self.messagesArray.count == 0 {
//                                //                                log.verbose("Will not scroll more")
//                            }else {
//                                if self.toneStatus {
//                                    self.playSendMessageSound()
//                                } else {
//                                }
//                                self.userAddTextView.text.removeAll()
//                                
//                                self.groupChatTableView.scrollToLastRow(animated: true)
//                            }
//                        }
//                    })
//                    
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                        }
//                    })
//                    
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                        }
//                    })
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                        }
//                    })
//                }
//            }
//        })
//    }
//}
//// MARK: - SEND LOCATION PROTOCOL
//extension GroupChatScreenViewController: sendLocationProtocol {
//    
//    func sendLocation(lat: Double, long: Double) {
//        //        self.sendMessage(messageText: "", lat: lat, long: long, socketCheck: ControlSettings.socketChat)
//        print("Lat ==> \(lat)")
//        print("long ==> \(long)")
//    }
//}
//
//extension GroupChatScreenViewController: SelectContactDetailDelegate {
//    func selectContact(caontectName:String, ContactNumber:String) {
//        var extendedParam = ["key":caontectName,"value": ContactNumber] as? [String:String]
//        
//        if let theJSONData = try?  JSONSerialization.data(withJSONObject:extendedParam ?? [:], options: []) {
//            let theJSONText = String(data: theJSONData,encoding: String.Encoding.utf8)
//            log.verbose("JSON string = \(theJSONText ?? "")")
//            self.sendContact(jsonPayload: theJSONText)
//        }
//    }
//    
//    
//    private func sendContact(jsonPayload:String?){
//        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
//        let jsonPayloadString = jsonPayload ??  ""
//        let groupId = self.groupId
//        let sessionID = AppInstance.instance.sessionId ?? ""
//        Async.background({
//            GroupChatManager.instance.sendContactToGroup(message_hash_id: messageHashId, groupId: groupId, sendType: "send", jsonPayload: jsonPayloadString, session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
//                if success != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            if self.messagesArray.count == 0{
//                                log.verbose("Will not scroll more")
//                                
//                            }else{
//                                if self.toneStatus {
//                                    self.playSendMessageSound()
//                                }else{
//                                    log.verbose("To play sound please enable conversation tone from settings..")
//                                }
//                                log.debug("userList = \(success?.apiStatus ?? 0)")
//                                let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                                self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                            }
//                            
//                            
//                        }
//                    })
//                }else if sessionError != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
//                            
//                            
//                        }
//                    })
//                }else if serverError != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
//                        }
//                        
//                    })
//                    
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                            log.error("error = \(error?.localizedDescription ?? "")")
//                        }
//                    })
//                }
//            })
//        })
//    }
//}
//
////MARK: - UITextViewDelegate method's
//extension GroupChatScreenViewController: UITextViewDelegate {
//    
//    func textViewDidChange(_ textView: UITextView) {
//        self.setSendButton()
//    }
//    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == .lightGray {
//            textView.text = nil
//            self.userAddTextView.text = ""
//            textView.textColor = UIColor.black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = NSLocalizedString("Your message here...", comment: "Your message here...")
//            textView.textColor = UIColor.lightGray
//        }
//    }
//    
//}
//
////MARK: - Massage Chat List Fecth Data
//extension GroupChatScreenViewController {
//    private func fetchData() {
//        _ = AppInstance.instance.userId ?? ""
//        let sessionID = AppInstance.instance.sessionId ?? ""
//        let groupId = self.groupId
//        log.verbose("group id = \(groupId)")
//        Async.background({
//            GroupChatManager.instance.getGroupChats(group_Id: groupId, session_Token: sessionID, type: "fetch_messages", completionBlock: { (success, sessionError, serverError, error) in
//                if success != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.messagesArray.removeAll()
//                            log.debug("userList = \(success?.data?.messages?.count ?? nil)")
//                            for item in stride(from: (success?.data?.messages!.count)! - 1, to: -1, by: -1){
//                                self.messagesArray.append((success?.data?.messages![item])!)
//                            }
//                            self.groupChatTableView.reloadData()
//                            if self.scrollStatus!{
//                                if self.messagesArray.count == 0{
//                                    log.verbose("Will not scroll more")
//                                }else{
//                                    self.scrollStatus = false
//                                    self.messageCount = self.messagesArray.count
//                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                                    self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                                }
//                                
//                            }else{
//                                if self.messagesArray.count > self.messageCount{
//                                    if self.toneStatus {
//                                        self.playReceiveMessageSound()
//                                    }else{
//                                        log.verbose("To play sound please enable conversation tone from settings..")
//                                    }
//                                    self.messageCount = self.messagesArray.count
//                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                                    self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                                }else{
//                                    log.verbose("Will not scroll more")
//                                }
//                                log.verbose("Will not scroll more")
//                            }
//                        }
//                    })
//                } else if sessionError != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
//                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
//                            
//                        }
//                    })
//                } else if serverError != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
//                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
//                        }
//                        
//                    })
//                    
//                } else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
//                            log.error("error = \(error?.localizedDescription ?? "")")
//                        }
//                    })
//                }
//            })
//        })
//    }
//    
//    //MARK: - playReceiveMessageSound
//    func playReceiveMessageSound() {
//        guard let url = Bundle.main.url(forResource: "Popup_GetMesseges", withExtension: "mp3") else { return }
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            receiveMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            
//            receiveMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            
//            guard let aPlayer = receiveMessageAudioPlayer else { return }
//            aPlayer.play()
//            
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
//    //ADD Messages Selected Data
//    private func sendSelectedData(imageData:Data?,videoData:Data?, imageMimeType:String?,VideoMimeType:String?,Type:String?,fileData:Data?,fileExtension:String?,FileMimeType:String?){
//        let messageHashId = Int(arc4random_uniform(UInt32(100000)))
//        let sessionId = AppInstance.instance.sessionId ?? ""
//        let groupId = self.groupId
//        let dataType = Type ?? ""
//        
//        if dataType == "image"{
//            Async.background({
//                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
//                                                            groupId: groupId,
//                                                            sendType: "send",
//                                                            session_Token: sessionId,
//                                                            type: dataType,
//                                                            image_data: imageData,
//                                                            video_data: nil,
//                                                            imageMimeType: imageMimeType,
//                                                            videoMimeType: nil,
//                                                            text: "",
//                                                            file_data: nil,
//                                                            file_Extension: nil,
//                                                            fileMimeType: nil, auido: <#T##Data?#>,
//                                                            auidoMimeType: <#T##String?#>,
//                                                            auido_Extension: <#T##String#>,
//                                                            completionBlock: { (success, sessionError, serverError, error) in
//                    if success != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                log.debug("userList = \(success?.apiStatus ?? 0)")
//                                if self.messagesArray.count == 0{
//                                    log.verbose("Will not scroll more")
//                                    
//                                }else{
//                                    if self.toneStatus{
//                                        self.playSendMessageSound()
//                                    }else{
//                                        log.verbose("To play sound please enable conversation tone from settings..")
//                                    }
//                                    log.debug("userList = \(success?.apiStatus ?? 0)")
//                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                                    self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
//                                }
//                                
//                            }
//                        })
//                    }else if sessionError != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                                log.error("sessionError = \(sessionError?.errors?.errorText)")
//                                
//                                
//                            }
//                        })
//                    }else if serverError != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                                log.error("serverError = \(serverError?.errors?.errorText)")
//                            }
//                            
//                        })
//                        
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                                log.error("error = \(error?.localizedDescription)")
//                            }
//                        })
//                    }
//                })
//                
//            })
//        }else if dataType == "video"{
//            
//            Async.background({
//                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
//                                                            groupId: groupId,
//                                                            sendType: "send",
//                                                            session_Token: sessionId,
//                                                            type: dataType,
//                                                            image_data: imageData,
//                                                            video_data: nil,
//                                                            imageMimeType: imageMimeType,
//                                                            videoMimeType: nil,
//                                                            text: "",
//                                                            file_data: nil,
//                                                            file_Extension: nil,
//                                                            fileMimeType: nil,
//                                                            auido: <#T##Data?#>,
//                                                            auidoMimeType: <#T##String?#>,
//                                                            auido_Extension: <#T##String#>,
//                                                            completionBlock: { (success, sessionError, serverError, error) in
//                    if success != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                log.debug("userList = \(success?.apiStatus ?? 0)")
//                                if self.messagesArray.count == 0{
//                                    log.verbose("Will not scroll more")
//                                    
//                                }else{
//                                    if self.toneStatus {
//                                        self.playSendMessageSound()
//                                    }else{
//                                        log.verbose("To play sound please enable conversation tone from settings..")
//                                    }
//                                    log.debug("userList = \(success?.apiStatus ?? 0)")
//                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                                    self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                                }
//                                
//                            }
//                        })
//                    }else if sessionError != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                                log.error("sessionError = \(sessionError?.errors?.errorText)")
//                                
//                                
//                            }
//                        })
//                    }else if serverError != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                                log.error("serverError = \(serverError?.errors?.errorText)")
//                            }
//                            
//                        })
//                        
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                                log.error("error = \(error?.localizedDescription)")
//                            }
//                        })
//                    }
//                })
//            })
//            
//        }else{
//            Async.background({
//                GroupChatManager.instance.sendGroupChatData(message_hash_id: messageHashId,
//                                                            groupId: groupId,
//                                                            sendType: "send",
//                                                            session_Token: sessionId,
//                                                            type: dataType,
//                                                            image_data: imageData,
//                                                            video_data: nil,
//                                                            imageMimeType: imageMimeType,
//                                                            videoMimeType: nil,
//                                                            text: "",
//                                                            file_data: nil,
//                                                            file_Extension: nil,
//                                                            fileMimeType: nil, auido: <#T##Data?#>,
//                                                            auidoMimeType: <#T##String?#>,
//                                                            auido_Extension: <#T##String#>,
//                                                            completionBlock: { (success, sessionError, serverError, error) in
//                    if success != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                log.debug("userList = \(success?.apiStatus ?? 0)")
//                                if self.messagesArray.count == 0{
//                                    log.verbose("Will not scroll more")
//                                    
//                                }else{
//                                    if self.toneStatus {
//                                        self.playSendMessageSound()
//                                    }else{
//                                        log.verbose("To play sound please enable conversation tone from settings..")
//                                    }
//                                    log.debug("userList = \(success?.apiStatus ?? 0)")
//                                    let indexPath = NSIndexPath(item: ((self.messagesArray.count) - 1), section: 0)
//                                    self.groupChatTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                                }
//                                
//                            }
//                        })
//                    }else if sessionError != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(sessionError?.errors?.errorText)
//                                log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
//                                
//                                
//                            }
//                        })
//                    }else if serverError != nil{
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(serverError?.errors?.errorText)
//                                log.error("serverError = \(serverError?.errors?.errorText ?? "")")
//                            }
//                            
//                        })
//                        
//                    }else {
//                        Async.main({
//                            self.dismissProgressDialog {
//                                self.view.makeToast(error?.localizedDescription)
//                                log.error("error = \(error?.localizedDescription ?? "")")
//                            }
//                        })
//                    }
//                })
//            })
//        }
//    }
//    
//    //MARK: - playSendMessageSound
//    func playSendMessageSound() {
//        guard let url = Bundle.main.url(forResource: "Popup_SendMesseges", withExtension: "mp3") else { return }
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            
//            sendMessageAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            
//            guard let aPlayer = sendMessageAudioPlayer else { return }
//            aPlayer.play()
//            
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//extension GroupChatScreenViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.messagesArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if self.messagesArray.count == 0 {
//            return UITableViewCell()
//        }
//        
//        let object = self.messagesArray[indexPath.row]
//        guard let type = object.type else { return UITableViewCell() }
//        print("Type => \(type)")
//        print("Type => \(object.orginalText ?? "")")
//        switch object.type {
//        case "left_Gif":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverStricker_TableCell.identifier) as? ChatReceiverStricker_TableCell
//            cell?.selectionStyle = .none
//            //            let url = URL(string:object.stickers ?? "")
//            //            cell?.stickerImage.sd_setImage(with: url , placeholderImage:nil)
//            
//            let url = URL(string:object.stickers ?? "")
//            cell?.stickerImage.kf.indicatorType = .activity
//            cell?.stickerImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//            
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            cell?.backVIewControl.tag = indexPath.row
//            cell?.backVIewControl.addTarget(self, action: #selector(clickGiftView), for: .touchUpInside)
//            
//            return cell ?? UITableViewCell()
//            
//        case "right_gif":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderSticker_TableCel.identifier) as? ChatSenderSticker_TableCell
//            cell?.selectionStyle = .none
//            let url = URL(string:object.stickers ?? "")
//            cell?.stickerImage.kf.indicatorType = .activity
//            cell?.stickerImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//            
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            cell?.backView.tag = indexPath.row
//            cell?.backView.addTarget(self, action: #selector(clickGiftView), for: .touchUpInside)
//            
//            return cell ?? UITableViewCell()
//            
//        case "right_text":
//            
//            //show text on Left
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiver_TableCell.identifier) as? ChatReceiver_TableCell
//            cell?.selectionStyle = .none
//            let htmlText = object.orginalText
//            let encodedData = htmlText?.data(using: String.Encoding.utf8)!
//            var attributedString: NSAttributedString
//            do {
//                attributedString = try NSAttributedString(data: encodedData ?? Data(), options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
//                cell?.messageTxtView.attributedText = attributedString
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            } catch {
//                print("error")
//            }
//            
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "left_text":
//            //show text on right
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSender_TableCell.identifier) as? ChatSender_TableCell
//            cell?.selectionStyle = .none
//            let paragraph = NSMutableParagraphStyle()
//            paragraph.tabStops = [
//                NSTextTab(textAlignment: .right, location: 0, options: [:]),
//            ]
//            let htmlText = object.orginalText
//            let encodedData = htmlText?.data(using: String.Encoding.utf8)!
//            var attributedString: NSAttributedString
//            do {
//                attributedString = try NSAttributedString(data: encodedData ?? Data(), options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
//                cell?.messageTxtView.attributedText = attributedString
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            } catch {
//                print("error")
//            }
//            cell?.dateLabel.isHidden = false
//            cell?.dateLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            
//            return cell ?? UITableViewCell()
//            
//        case "right_contact":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderContact_TableCell.identifier) as? ChatSenderContact_TableCell
//            cell?.selectionStyle = .none
//            let dic =  convertStringToDictionary(text: (object.orginalText?.htmlAttributedString!)!)
//            cell?.nameLabel.text = "\(dic?["key"] ?? "")"
//            cell?.contactLabel.text  =  "\(dic?["value"] ?? "")"
//            cell?.timeLabel.text = object.timeText
//            cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
//            cell?.starBtn.isHidden = true
//            cell?.backView.tag = indexPath.row
//            cell?.backView.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
//            return cell ?? UITableViewCell()
//            
//        case "left_contact":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverContact_TableCell.identifier) as? ChatReceiverContact_TableCell
//            cell?.selectionStyle = .none
//            let dic =  convertStringToDictionary(text: (object.orginalText?.htmlAttributedString!)!)
//            cell?.nameLabel.text = "\(dic?["key"] ?? "")"
//            cell?.contactLabel.text  =  "\(dic?["value"] ?? "")"
//            cell?.timeLabel.text = object.time
//            cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            cell?.backViewControl.tag = indexPath.row
//            cell?.backViewControl.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
//            return cell ?? UITableViewCell()
//            
//        case "left_audio":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverAudio_TableCell.identifier) as? ChatReceiverAudio_TableCell
//            cell?.selectionStyle = .none
//            cell?.index = indexPath.row
//            cell?.url = object.media
//            cell?.durationLabel.text = NSLocalizedString("Loading...", comment: "Loading...")
//            
//            if isFistTry == true {
//                Async.background({
//                    let audioURL = URL(string: object.media ?? "")
//                    self.player = AVPlayer(url: audioURL! as URL)
//                    let currentItem = self.player.currentItem
//                    let duration = currentItem!.asset.duration
//                    self.isFistTry = false
//                    Async.main({
//                        self.audioDuration = duration.durationText
//                        cell?.durationLabel.text = duration.durationText
//                    })
//                })
//            }else {
//            }
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "right_audio":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderAudio_TableCell.identifier) as? ChatSenderAudio_TableCell
//            cell?.selectionStyle = .none
//            cell?.delegate = self
//            cell?.index = indexPath.row
//            cell?.url = object.media
//            cell?.durationLabel.text = NSLocalizedString("Loading...", comment: "Loading...")
//            Async.background({
//                let audioURL = URL(string: object.media ?? "")
//                self.player = AVPlayer(url: audioURL! as URL)
//                let currentItem = self.player.currentItem
//                let duration = currentItem!.asset.duration
//                Async.main({
//                    cell?.durationLabel.text = duration.durationText
//                })
//            })
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "left_Video":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier) as? ChatReceiverImage_TableCell
//            cell?.selectionStyle = .none
//            cell?.playBtn.tag = indexPath.row
//            cell?.playBtn.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
//            cell?.fileImage.isHidden = true
//            cell?.videoView.isHidden = false
//            cell?.playBtn.isHidden = false
//            cell?.index = indexPath.row
//            let videoURL = URL(string: object.media ?? "")
//            player = AVPlayer(url: videoURL! as URL)
//            let playerController = AVPlayerViewController()
//            playerController.player = player
//            self.addChild(playerController)
//            playerController.view.frame = self.view.frame
//            cell?.videoView.addSubview(playerController.view)
//            player.pause()
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "right_video":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier) as? ChatSenderImage_TableCell
//            
//            cell?.playBtn.tag = indexPath.row
//            cell?.playBtn.addTarget(self, action: #selector(clickVidowButton), for: .touchUpInside)
//            
//            cell?.selectionStyle = .none
//            cell?.fileImage.isHidden = true
//            cell?.videoView.isHidden = false
//            cell?.playBtn.isHidden = false
//            cell?.delegate = self
//            cell?.index  = indexPath.row
//            let videoURL = URL(string: object.media ?? "")
//            player = AVPlayer(url: videoURL! as URL)
//            let playerController = AVPlayerViewController()
//            playerController.player = player
//            self.addChild(playerController)
//            playerController.view.frame = self.view.frame
//            cell?.videoView.addSubview(playerController.view)
//            player.pause()
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "left_image":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatReceiverImage_TableCell.identifier) as? ChatReceiverImage_TableCell
//            cell?.selectionStyle = .none
//            cell?.fileImage.isHidden = false
//            cell?.videoView.isHidden = true
//            cell?.playBtn.isHidden = true
//            cell?.starBtn.isHidden = true
//            
//            let url = URL(string: object.media ?? "")
//            cell?.fileImage.kf.indicatorType = .activity
//            cell?.fileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//            
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.backGroundView.tag = indexPath.row
//            cell?.backGroundView.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
//            return cell ?? UITableViewCell()
//            
//        case "right_image":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderImage_TableCell.identifier) as? ChatSenderImage_TableCell
//            cell?.selectionStyle = .none
//            cell?.fileImage.isHidden = false
//            cell?.fileImage.isHidden = false
//            cell?.videoView.isHidden = true
//            cell?.playBtn.isHidden = true
//            cell?.starBtn.isHidden = true
//            
//            let url = URL(string: object.media ?? "")
//            cell?.fileImage.kf.indicatorType = .activity
//            cell?.fileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
//            
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.backView.tag = indexPath.row
//            cell?.backView.addTarget(self, action: #selector(clickImageClick), for: .touchUpInside)
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "right_file":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderDocument_TableCell.identifier) as? ChatSenderDocument_TableCell
//            cell?.selectionStyle = .none
//            cell?.fileNameLabel.text = object.mediaFileName
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.backView.tag = indexPath.row
//            cell?.backView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
//            cell?.starBtn.isHidden = true
//            return cell ?? UITableViewCell()
//            
//        case "left_file":
//            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatSenderDocument_TableCell.identifier) as? ChatSenderDocument_TableCell
//            cell?.selectionStyle = .none
//            cell?.fileNameLabel.text = object.mediaFileName
//            cell?.timeLabel.text = "\(object.timeText ?? "")"
//            cell?.starBtn.isHidden = true
//            cell?.backView.tag = indexPath.row
//            cell?.backView.addTarget(self, action: #selector(clickFile), for: .touchUpInside)
//            return cell ?? UITableViewCell()
//        default:
//            break
//        }
//        return UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    //MARK: - clickVidowButton
//    @objc func clickVidowButton(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let player = AVPlayer(url: URL(string: object.media ?? "")!)
//        let vc = AVPlayerViewController()
//        vc.player = player
//        self.present(vc, animated: true) {
//            vc.player?.play()
//        }
//    }
//    
//    //MARK: - clickImageClick
//    @objc func clickImageClick(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
//        vc.imageURL = object.media ?? ""
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true, completion: nil)
//    }
//    
//    //MARK: - clickFile
//    @objc func clickFile(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
////        documentInteractionController = UIDocumentInteractionController()
////        let fileURL = URL(string: object.media ?? "")
////        documentInteractionController?.url = fileURL
////        documentInteractionController?.delegate = self
////        documentInteractionController?.presentPreview(animated: true)
//        
//        guard let url = URL(string: object.media ?? "") else { return }
//        UIApplication.shared.openURL(url)
//
//    }
//    
//    //MARK: - clickGiftView
//    @objc func clickGiftView(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
//        vc.imageURL = object.stickers ?? ""
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true, completion: nil)
//    }
//    //MARK: - callNumber Click
//    @objc func callNumber(_ sender: UIControl) {
//        let object = self.messagesArray[sender.tag]
//        let dic =  convertStringToDictionary(text: (object.orginalText?.htmlAttributedString!)!)
//        let phoneNumber = "\(dic?["value"] ?? "")"
//        
//        if let phoneCallURL = URL(string: phoneNumber) {
//            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(phoneCallURL)) {
//                if #available(iOS 10.0, *) {
//                    application.open(phoneCallURL, options: [:], completionHandler: nil)
//                } else {
//                    // Fallback on earlier versions
//                    application.openURL(phoneCallURL as URL)
//                    
//                }
//            }
//        }
//    }
//}
//
////MARK: - extension OF PlayVideoDelegate
//extension GroupChatScreenViewController: PlayVideoDelegate {
//    func playVideo(index: Int, status: Bool) {
//        if status {
//            log.verbose("self.player.play")
//        } else {
//            log.verbose("self.player.pause")
//        }
//    }
//}
//
////MARK: - UIDocumentInteractionController Delegate's
//extension GroupChatScreenViewController: UIDocumentInteractionControllerDelegate {
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//        return self
//    }
//    
//    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
//        return self.view
//    }
//    
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension URL {
//    
//    var uti: String {
//        return (try? self.resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier ?? "public.data"
//    }
//    
//}
//
//extension GroupChatScreenViewController: PlayAudioDelegate {
//    func playAudio(index: Int, status: Bool, url: URL, button: UIButton) {
//        if status {
//            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!//since it sys
//            let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
//            
//            self.playerItem = AVPlayerItem(url: destinationUrl)
//            self.player = AVPlayer(playerItem: self.playerItem)
//            self.player.play()
//            button.setImage(R.image.ic_pauseBtn(), for: .normal)
//        } else {
//            self.player.pause()
//            button.setImage(R.image.ic_playBtn(), for: .normal)
//        }
//    }
//}
