//
//  ChatUserListBottomVC.swift
//  WoWonder
//
//  Created by UnikApp on 09/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async


protocol UserListDelegate {
    func chatList(IndexCllick: String?,
                  recipientID: String,
                  ChatUsers: UserModel?,
                  Indexpath: IndexPath)
}

class ChatUserListBottomVC: BaseVC {
    
    @IBOutlet weak var archiveImgeView: UIImageView!
    @IBOutlet weak var deleteImageview: UIImageView!
    @IBOutlet weak var pinImageview: UIImageView!
    @IBOutlet weak var muteImagview: UIImageView!
    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var blockImagview: UIImageView!
    @IBOutlet weak var callImageview: UIImageView!
    @IBOutlet weak var ViewProfile: UIImageView!
    
    var ChatBottomSiteArray: [ChatBottomSite] = []
    var recipientID = ""
    var chatUser: UserModel?
    var delegate: UserListDelegate?
    var indexpath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.deleteImageview.image = UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate)
        self.deleteImageview.tintColor = UIColor.mainColor
        
        self.pinImageview.image = UIImage(systemName: "pin.fill")?.withRenderingMode(.alwaysTemplate)
        self.pinImageview.tintColor = UIColor.mainColor
        
        self.muteImagview.image = UIImage(named: "ic_Mute_chat")?.withRenderingMode(.alwaysTemplate)
        self.muteImagview.tintColor = UIColor.mainColor
        
        self.archiveImgeView.image = UIImage(named: "ic_Archive")?.withRenderingMode(.alwaysTemplate)
        self.archiveImgeView.tintColor = UIColor.mainColor
        
        self.blockImagview.image = UIImage(named: "block-user_setting")?.withRenderingMode(.alwaysTemplate)
        self.blockImagview.tintColor = UIColor.mainColor
        
        self.callImageview.image = UIImage(named: "ic_profile_Call")?.withRenderingMode(.alwaysTemplate)
        self.callImageview.tintColor = UIColor.mainColor
        
        self.ViewProfile.image = UIImage(named: "user_setting")?.withRenderingMode(.alwaysTemplate)
        self.ViewProfile.tintColor = UIColor.mainColor
        
        self.markImageView.image = UIImage(named: "ic_read_chat")?.withRenderingMode(.alwaysTemplate)
        self.markImageView.tintColor = UIColor.mainColor
        
    }
    
    @IBAction func downButtonClick(_ sender: Any) {
        self.dismiss(animated: true)

    }
    @IBAction func archiveButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.chatList(IndexCllick: "Archive",
                                recipientID: self.recipientID,
                                ChatUsers: chatUser,
                                Indexpath: indexpath)

        let notify = chatUser?.mute?.archive
        if notify == "yes" {
            self.addArchive(isArchive: "no", chatId: self.recipientID)
        } else if notify == "no" {
            self.addArchive(isArchive: "yes", chatId: self.recipientID)
        } else {
            self.addArchive(isArchive: "yes", chatId: self.recipientID)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {        
        BotttomSiteUserList.instance.deleteChat(user_id: self.recipientID,
                                                session_Token: AppInstance.instance._sessionId) { Success, AuthError, ServerKeyError, error in
            if Success != nil{
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(NSLocalizedString("User has been unblocked!!", comment: "User has been unblocked!!"))
                        self.dismiss(animated: true)
                        self.delegate?.chatList(IndexCllick: "Delete",
                                                recipientID: self.recipientID,
                                                ChatUsers: self.chatUser,
                                                Indexpath: self.indexpath)
                    }
                })
                
            }else if AuthError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(AuthError?.errors?.errorText)
                        self.dismiss(animated: true)
                    }
                })
                
            }else if ServerKeyError != nil {
                Async.main({
                    self.dismissProgressDialog {
                        self.view.makeToast(ServerKeyError?.errors?.errorText)
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
        }
    }
    
    @IBAction func pinButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        let notify = chatUser?.mute?.pin
        if notify == "yes" {
            self.muteChatApicall(isNotify: "no", chat_id: self.recipientID)
        } else if notify == "no" {
            self.muteChatApicall(isNotify: "yes", chat_id: self.recipientID)
        } else {
            self.muteChatApicall(isNotify: "yes", chat_id: self.recipientID)
        }
    }
    
    @IBAction func muteButtonButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.chatList(IndexCllick: "Mute",
                                recipientID: self.recipientID,
                                ChatUsers: chatUser,
                                Indexpath: indexpath)
        let notify = chatUser?.mute?.notify
        if notify == "yes" {
            self.muteChatApicall(isNotify: "no", chat_id: self.recipientID)
        } else if notify == "no" {
            self.muteChatApicall(isNotify: "yes", chat_id: self.recipientID)
        } else {
            self.muteChatApicall(isNotify: "yes", chat_id: self.recipientID)
        }
    }
    
    @IBAction func markChatReadButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func infoButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.blockUser()
    }
    
    @IBAction func exitButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.chatList(IndexCllick: "call",
                                recipientID: self.recipientID,
                                ChatUsers: chatUser,
                                Indexpath: indexpath)
    }
    
    @IBAction func addmembersButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.chatList(IndexCllick: "View Profile",
                                recipientID: self.recipientID,
                                ChatUsers: chatUser,
                                Indexpath: indexpath)
    }
    
    func muteChatApicall(isNotify: String, chat_id: String) {
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            BotttomSiteUserList.instance.addNotifyMute(session_Token: sessionToken,
                                                       notify: isNotify,
                                                       chat_id: chat_id)
        })
    }
    
    func addArchive(isArchive: String, chatId: String) {
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            BotttomSiteUserList.instance.archiveAdd(session_Token: sessionToken,
                                                    archive: isArchive,
                                                    chat_id: chatId)
        })

    }
    
    //MARK: - BlockUser Api call
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
}


extension ChatUserLIstViewController: UserListDelegate {
    func chatList(IndexCllick: String?, recipientID: String, ChatUsers: UserModel?, Indexpath: IndexPath) {
        if IndexCllick == "call" {
            CallManager.instance.agoraCall(recipient_id: recipientID,
                                           access_token: AppInstance.instance.sessionId ?? "",
                                           type: "create",
                                           call_Type: "audio") { response in
                switch response {
                case .success(let data):
                    let vidoeCallVC = AgoraCallVC.initialize(from: .call)
                    vidoeCallVC.callId = data._id
                    vidoeCallVC.roomName = data.room_name ?? ""
                    vidoeCallVC.user = ChatUsers
                    self.navigationController?.pushViewController(vidoeCallVC, animated: true)
                    
                case .failure(let error):
                    self.dismiss(animated: true)
                    print("error Call Api => \(error)")
                }
            }
        } else if IndexCllick == "View Profile" {
            let vc = R.storyboard.dashboard.userProfileVC()
            vc?.isFollowing = 0
            vc?.user_id = ChatUsers?.userID ?? ""
            vc?.isfind = true
            vc?.getUserData(user_ID: ChatUsers?.userID ?? "")
            let seconds = 2.0            
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        } else if IndexCllick == "Delete" {
            self.userListArray.remove(at: Indexpath.row)            
        }
    }
}
