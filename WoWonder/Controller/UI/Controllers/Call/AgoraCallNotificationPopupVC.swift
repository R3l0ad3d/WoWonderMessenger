

import UIKit
import Async
import SwiftEventBus
import AVFoundation
import AVKit
import WowonderMessengerSDK

class AgoraCallNotificationPopupVC: BaseVC {
    
    @IBOutlet weak var callingLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var chatModel: Users?
    var callType: CallType?
    var callProvider: CallProvider?
    var contactUserObject: SelectContactModel.User?
    var callLogUserObject: CallLogsModel?
    var searchUserObject: SearchModel.User?
    var followingUserObject: FollowingModel.Following?
    var delegate: CallReceiveDelegate?
    var isDialer = false
    
    private var callingStatus: String? = ""
    private var callId: Int? = 0
    private var timer = Timer()
    private var accessTokenID = ""
    private var roomId: String = ""
    private var callAudioPlayer: AVAudioPlayer?
    private var callingStyle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        if isDialer {
            //change sound according to the project
            self.playCallSoundSound()
        }else {
            self.playCallSoundSound()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callUser()
    }
    
    deinit {
        timer.invalidate()
    }
    
    @IBAction func hangupPressed(_ sender: Any) {
        let convertedCallID = "\(self.callId!)"
        self.declineCall(callID: convertedCallID)
    }
    
    @IBAction func soundMutePressed(_ sender: Any) {
    }
    
    private func setupUI() {
        if let chat = self.chatModel {
            self.fullNameLabel.text = chat._name
            let url = URL(string: chat._avatar_url)
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
            
        } else if let contact = self.contactUserObject {
            self.fullNameLabel.text = contact.name ?? ""
            let url = URL(string: contact.avatar ?? "")
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
            
        } else if let callObject = callLogUserObject {
            self.fullNameLabel.text = callObject.name ?? ""
            let url = URL(string: callObject.profilePicture ?? "")
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
            
        } else if let searchUser = self.searchUserObject {
            
            self.fullNameLabel.text = searchUser.name ?? ""
            let url = URL(string: searchUser.avatar ?? "")
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
            
        } else {
            self.fullNameLabel.text = followingUserObject?.name ?? ""
            let url = URL(string:followingUserObject?.avatar ?? "")
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        
        self.callingLabel.text = self.callType?.title ?? ""
        
        profileImage.cornerRadiusV = (profileImage.frame.height) / 2
        let dismissView = UITapGestureRecognizer(target: self, action: #selector(dismissView(sender:)))
        self.view.addGestureRecognizer(dismissView)
    }
    
    @objc func dismissView(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func playCallSoundSound() {
        guard let url = Bundle.main.url(forResource: "mystic_call", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            callAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                        
            guard let aPlayer = callAudioPlayer else { return }
            aPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func callUser() {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        var recipientID = ""
        
        if let chat = self.chatModel {
            recipientID = chat._user_id
            
        }else if let contact = self.contactUserObject {
            recipientID = contact.userID ?? ""
            
        }else if let callObject = callLogUserObject {
            recipientID = callObject.userId ?? ""
            
        }else if let searchUser = self.searchUserObject {
            recipientID = searchUser.userID ?? ""
            
        }else {
            recipientID = followingUserObject?.userID ?? ""
        }
        
        self.callingStyle = ControlSettings.agoraCall == true && ControlSettings.twilloCall == false ? "agora" : "twillo"
        
        switch self.callType {
        case .audio:
            if ControlSettings.agoraCall == true && ControlSettings.twilloCall == false {
                
                Async.background({
                    CallManager.instance.agoraCall(recipient_id: recipientID,
                                                   access_token: sessionID,
                                                   type: "create",
                                                   call_Type: self.callType?.requestString ?? "", completionBlock: { (result) in
                        
                        switch result {
                        case .success(let model):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.callId = model._id
                                    self.roomId = model._room_name
                                    self.checkForCallAction(callID: self.callId!,
                                                            callingStatus: self.callingStyle,
                                                            accessToken: "")
                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                                                      target: self,
                                                                      selector: #selector(self.checkCall),
                                                                      userInfo: nil,
                                                                      repeats: true)
                                }
                            })
                            break
                            
                        case .failure(let error):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.view.makeToast(error.localizedDescription)
                                }
                            })
                            break
                        }
                        
//                        if success != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    //                                    log.debug("userList = \(success?.id ?? nil)")
//                                    self.callId = success?.id!
//                                    self.roomId = success?.roomName ?? ""
//
//                                    self.checkForCallAction(callID: self.callId!,
//                                                            callingStatus: self.callingStyle,
//                                                            accessToken: "")
//                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                                      target: self,
//                                                                      selector: #selector(self.update),
//                                                                      userInfo: nil,
//                                                                      repeats: true)
//                                }
//                            })
//
//                        }else if sessionError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(sessionError?.errors?.errorText)
//                                    //                                    log.error("sessionError = \(sessionError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else if serverError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(serverError?.errors?.errorText)
//                                    //                                    log.error("serverError = \(serverError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(error?.localizedDescription)
//                                    //                                    log.error("error = \(error?.localizedDescription)")
//                                }
//                            })
//                        }
                    })
                })
                
            } else {
                Async.background({
                    //This is for audio
                    TwilloCallmanager.instance.twilloCall(user_id: userId, session_Token: sessionID, recipient_Id: recipientID, completionBlock: { (result) in
                        
                        switch result {
                        case .success(let model):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.callId = model._id
                                    self.roomId = model._roomName
                                    self.accessTokenID = model._accessToken
                                    sleep(8)
                                    self.checkForCallAction(callID: self.callId!,
                                                            callingStatus: self.callingStyle,
                                                            accessToken: model._accessToken2)
                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                                                      target: self,
                                                                      selector: #selector(self.checkCall),
                                                                      userInfo: nil,
                                                                      repeats: true)
                                }
                            })
                            break
                            
                        case .failure(let error):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.view.makeToast(error.localizedDescription)
                                }
                            })
                            break
                        }
                        
//                        if success != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    //                                    log.debug("userList = \(success?.id ?? nil)")
//                                    self.callId = success?.id!
//                                    self.roomId = success?.roomName ?? ""
//                                    self.accessTokenID = (success?.accessToken)!
//                                    sleep(8)
//                                    self.checkForCallAction(callID: self.callId!,
//                                                            callingStatus: self.callingStyle,
//                                                            accessToken: (success?.accessToken2)!)
//                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                                      target: self,
//                                                                      selector: #selector(self.update),
//                                                                      userInfo: nil,
//                                                                      repeats: true)
//                                }
//                            })
//
//                        }else if sessionError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(sessionError?.errors?.errorText)
//                                    //                                    log.error("sessionError = \(sessionError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else if serverError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(serverError?.errors?.errorText)
//                                    //                                    log.error("serverError = \(serverError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(error?.localizedDescription)
//                                    //                                    log.error("error = \(error?.localizedDescription)")
//                                }
//                            })
//                        }
                    })
                })
            }
            break
            
        case .video:
            if ControlSettings.agoraCall == true && ControlSettings.twilloCall == false {
                
                Async.background({
                    CallManager.instance.agoraCall(recipient_id: recipientID,
                                                   access_token: sessionID,
                                                   type: "create",
                                                   call_Type: self.callType?.requestString ?? "", completionBlock: { (result) in
                        
                        switch result {
                        case .success(let model):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.callId = model._id
                                    self.roomId = model._room_name
                                    self.checkForCallAction(callID: self.callId!,
                                                            callingStatus: self.callingStyle,
                                                            accessToken: "")
                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                                                      target: self,
                                                                      selector: #selector(self.checkCall),
                                                                      userInfo: nil,
                                                                      repeats: true)
                                }
                            })
                            break
                            
                        case .failure(let error):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.view.makeToast(error.localizedDescription)
                                }
                            })
                            break
                        }
                        
//                        if success != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    //                                    log.debug("userList = \(success?.roomName ?? nil)")
//                                    self.callId = success?.id!
//                                    self.roomId = success?.roomName ?? ""
//                                    //                                    log.verbose("self.callId = \(self.callId)")
//                                    self.checkForCallAction(callID: self.callId!,
//                                                            callingStatus: self.callingStyle,
//                                                            accessToken: "")
//                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                                      target: self,
//                                                                      selector: #selector(self.update),
//                                                                      userInfo: nil,
//                                                                      repeats: true)
//                                }
//                            })
//
//                        }else if sessionError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(sessionError?.errors?.errorText)
//                                    //                                    log.error("sessionError = \(sessionError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else if serverError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(serverError?.errors?.errorText)
//                                    //                                    log.error("serverError = \(serverError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(error?.localizedDescription)
//                                    //                                    log.error("error = \(error?.localizedDescription)")
//                                }
//                            })
//                        }
                    })
                })
                
            } else {
                Async.background({
                    //This is for video
                    TwilloCallmanager.instance.twilloVideoCall(user_id: userId, session_Token: sessionID, recipient_Id: recipientID, completionBlock: { (result) in
                        
                        switch result {
                        case .success(let model):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.callId = model._id
                                    self.roomId = model._roomName
                                    self.accessTokenID = model._accessToken
                                    
                                    //Yahn dosra kea hai
                                    sleep(8)
                                    self.checkForCallAction(callID: self.callId!,
                                                            callingStatus: self.callingStyle,
                                                            accessToken: model._accessToken2)
                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                                                      target: self,
                                                                      selector: #selector(self.checkCall),
                                                                      userInfo: nil,
                                                                      repeats: true)
                                }
                            })
                            break
                            
                        case .failure(let error):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.view.makeToast(error.localizedDescription)
                                }
                            })
                            break
                        }
                        
//                        if success != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    //                                    log.debug("userList = \(success?.roomName ?? nil)")
//                                    self.callId = success?.id!
//                                    self.roomId = success?.roomName ?? ""
//                                    self.accessTokenID = (success?.accessToken)!
//                                    //                                    log.verbose("self.callId = \(self.callId)")
//                                    //                                    log.verbose("AccessToken = \(success?.accessToken ?? "")")
//                                    //                                    log.verbose("AccessToken = \(success?.accessToken2 ?? "")")
//
//                                    //Yahn dosra kea hai
//                                    sleep(8)
//                                    self.checkForCallAction(callID: self.callId!,
//                                                            callingStatus: self.callingStyle,
//                                                            accessToken: (success?.accessToken2)!)
//                                    self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                                      target: self,
//                                                                      selector: #selector(self.update),
//                                                                      userInfo: nil,
//                                                                      repeats: true)
//                                }
//                            })
//
//                        }else if sessionError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(sessionError?.errors?.errorText)
//                                    //                                    log.error("sessionError = \(sessionError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else if serverError != nil {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(serverError?.errors?.errorText)
//                                    //                                    log.error("serverError = \(serverError?.errors?.errorText)")
//                                }
//                            })
//
//                        }else {
//                            Async.main({
//                                self.dismissProgressDialog {
//                                    self.view.makeToast(error?.localizedDescription)
//                                    //                                    log.error("error = \(error?.localizedDescription)")
//                                }
//                            })
//                        }
                    })
                })
            }
            break
            
        case .none:
            break
        }
    }
    
    private func checkForCallAction(callID: Int, callingStatus: String, accessToken: String) {
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
         var recipientID  = ""
        
        if let chat = self.chatModel {
            recipientID = chat._user_id
            
        }else if contactUserObject != nil {
            recipientID = contactUserObject?.userID ?? ""
            
        }else if callLogUserObject != nil {
            recipientID = callLogUserObject?.userId ?? ""
            
        }else if searchUserObject != nil {
            recipientID = searchUserObject?.userID ?? ""
            
        }else {
            recipientID = followingUserObject?.userID ?? ""
        }
        
        if callingStatus == "agora" {
            Async.background({
                CallManager.instance.checkForAgoraCall(access_token: sessionID,
                                                       call_id: callID, completionBlock: { (result) in
                    
                    switch result {
                    case .success(let model):
                        Async.main {
                            self.dismissProgressDialog {
                                
                                switch model._callStatusObject {
                                case .answered:
                                    
                                    switch self.callType {
                                    case .video:
                                        self.dismiss(animated: true, completion: {
                                            var username = ""
                                            var profilePicture = ""
                                            
                                            if self.chatModel != nil {
                                                username = self.chatModel?._username ?? ""
                                                profilePicture = self.chatModel?._avatar_url ?? ""
                                                
                                            }else if self.contactUserObject != nil {
                                                username = self.contactUserObject?.username ?? ""
                                                profilePicture = self.contactUserObject?.avatar ??  ""
                                                
                                            }else if self.callLogUserObject != nil {
                                                username =  self.callLogUserObject?.name ?? ""
                                                profilePicture = self.callLogUserObject?.profilePicture ?? ""
                                                
                                            }else if self.searchUserObject != nil {
                                                username = self.searchUserObject?.username ?? ""
                                                profilePicture =  self.searchUserObject?.avatar ?? ""
                                                
                                            }else{
                                                username = self.followingUserObject?.username ?? ""
                                                profilePicture = self.followingUserObject?.avatar ?? ""
                                            }
                                            
                                            self.delegate?.receiveCall(callId: callID,
                                                                       RoomId: self.roomId,
                                                                       callingType: self.callingStatus ?? "",
                                                                       username: username,
                                                                       profileImage: profilePicture,
                                                                       accessToken: "")
                                            self.setCallLogs(callActionMessage: "video call answered")
                                            
                                            self.timer.invalidate()
                                        })
                                        break
                                        
                                    case .audio:
                                        self.dismiss(animated: true, completion: {
                                            var username = ""
                                            var profilePicture = ""
                                            if self.chatModel != nil {
                                                username = self.chatModel?.username ?? ""
                                                profilePicture = self.chatModel?._avatar_url ?? ""
                                                
                                            }else if self.contactUserObject != nil {
                                                username = self.contactUserObject?.username ?? ""
                                                profilePicture = self.contactUserObject?.avatar ??  ""
                                                
                                            }else if self.callLogUserObject != nil {
                                                username =  self.callLogUserObject?.name ?? ""
                                                profilePicture = self.callLogUserObject?.profilePicture ?? ""
                                                
                                            }else if self.searchUserObject != nil {
                                                username = self.searchUserObject?.username ?? ""
                                                profilePicture =  self.searchUserObject?.avatar ?? ""
                                                
                                            }else {
                                                username = self.followingUserObject?.username ?? ""
                                                profilePicture = self.followingUserObject?.avatar ?? ""
                                            }
                                            
                                            self.delegate?.receiveCall(callId: callID,
                                                                       RoomId: self.roomId,
                                                                       callingType: self.callingStatus ?? "",
                                                                       username: username,
                                                                       profileImage: profilePicture,
                                                                       accessToken: accessToken)
                                            self.setCallLogs(callActionMessage: "audio call answered")
                                            
                                            self.timer.invalidate()
                                        })
                                        break
                                        
                                    case .none:
                                        break
                                    }
                                    break
                                    
                                case .declined:
                                    self.dismiss(animated: true, completion: nil)
                                    self.timer.invalidate()
                                    self.setCallLogs(callActionMessage: "cancelled")
                                    break
                                    
                                case .no_answer:
                                    self.dismiss(animated: true, completion: nil)
                                    self.timer.invalidate()
                                    self.setCallLogs(callActionMessage: "No answer")
                                    break
                                    
                                case .unknown:
                                    break
                                case .calling:
                                    break
                                }
                            }
                        }
                        break
                        
                    case .failure(let error):
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error.localizedDescription)
                            }
                        })
                        break
                    }
                })
            })
            
        }else {
            Async.background({
                TwilloCallmanager.instance.checkForTwilloCall(user_id: userId,
                                                              session_Token: sessionID,
                                                              call_id: callID,
                                                              call_Type: self.callingStatus ?? "", completionBlock: { (result) in
                    
                    switch result {
                    case .success(let model):
                        Async.main({
                            self.dismissProgressDialog {
                                
                                switch model._callStatusObject {
                                case .answered:
                                    switch self.callType {
                                    case .video:
                                        self.dismiss(animated: true, completion: {
                                            var username = ""
                                            var profilePicture = ""
                                            
                                            if let chat = self.chatModel {
                                                username = chat._username
                                                profilePicture = chat._avatar_url
                                                
                                            }else if let contact = self.contactUserObject {
                                                username = contact.username ?? ""
                                                profilePicture = contact.avatar ??  ""
                                                
                                            }else if let callUser = self.callLogUserObject {
                                                username =  callUser.name ?? ""
                                                profilePicture = callUser.profilePicture ?? ""
                                                
                                            }else if let searchUser = self.searchUserObject {
                                                username = searchUser.username ?? ""
                                                profilePicture =  searchUser.avatar ?? ""
                                                
                                            }else {
                                                username = self.followingUserObject?.username ?? ""
                                                profilePicture = self.followingUserObject?.avatar ?? ""
                                            }
                                            
                                            self.delegate?.receiveCall(callId: callID,
                                                                       RoomId: self.roomId,
                                                                       callingType: self.callingStatus ?? "",
                                                                       username: username,
                                                                       profileImage: profilePicture, accessToken: accessToken)
                                            self.setCallLogs(callActionMessage: "video call answered")
                                            
                                            self.timer.invalidate()
                                        })
                                        break
                                        
                                    case .audio:
                                        self.dismiss(animated: true, completion: {
                                            var username = ""
                                            var profilePicture = ""
                                            
                                            if let chat = self.chatModel {
                                                username = chat._username
                                                profilePicture = chat._avatar_url
                                                
                                            }else if let contact = self.contactUserObject {
                                                username = contact.username ?? ""
                                                profilePicture = contact.avatar ??  ""
                                                
                                            }else if let callUser = self.callLogUserObject {
                                                username =  callUser.name ?? ""
                                                profilePicture = callUser.profilePicture ?? ""
                                                
                                            }else if let searchUser = self.searchUserObject {
                                                username = searchUser.username ?? ""
                                                profilePicture =  searchUser.avatar ?? ""
                                                
                                            }else {
                                                username = self.followingUserObject?.username ?? ""
                                                profilePicture = self.followingUserObject?.avatar ?? ""
                                            }
                                            
                                            self.delegate?.receiveCall(callId: callID,
                                                                       RoomId: self.roomId,
                                                                       callingType: self.callingStatus ?? "",
                                                                       username: username,
                                                                       profileImage: profilePicture,
                                                                       accessToken: accessToken)
                                            self.setCallLogs(callActionMessage: "audio call answered")
                                            
                                            self.timer.invalidate()
                                        })
                                        break
                                        
                                    case .none:
                                        break
                                    }
                                    break
                                    
                                case .calling:
                                    break
                                    
                                case .declined:
                                    self.dismiss(animated: true, completion: nil)
                                    self.timer.invalidate()
                                    self.setCallLogs(callActionMessage: "cancelled")
                                    break
                                    
                                case .no_answer:
                                    break
                                }
                            }
                        })
                        break
                        
                    case .failure(let error):
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error.localizedDescription)
                           }
                        })
                        break
                    }
                })
            })
        }
    }
    
    @objc func checkCall() {
        self.checkForCallAction(callID: self.callId!,
                                callingStatus: callingStyle,
                                accessToken: self.accessTokenID)
    }
    
    private func declineCall(callID: String) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        if self.callingStyle == "agora" {
            Async.background({
                CallManager.instance.agoraCallAction(access_token: sessionID,
                                                     call_id: callID,
                                                     action: "decline", completionBlock: { (result) in
                    switch result {
                    case .success(_):
                        Async.main({
                            self.dismissProgressDialog {
                                self.dismiss(animated: true, completion: {
                                    self.timer.invalidate()
                                })
                            }
                        })
                        break
                        
                    case .failure(let error):
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error.localizedDescription)
                            }
                        })
                        break
                    }
                })
            })
            
        }else {
            switch self.callType {
            case .audio:
                Async.background({
                    TwilloCallmanager.instance.twilloAudioCallAction(user_id: userId, session_Token: sessionID, call_id: callID, answer_type: "decline", completionBlock: { (result) in
                        
                        switch result {
                        case .success(_):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.dismiss(animated: true, completion: {
                                        self.timer.invalidate()
                                    })
                                }
                            })
                            break
                            
                        case .failure(let error):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.view.makeToast(error.localizedDescription)
                                }
                            })
                            break
                        }
                    })
                })
                break
                
            case .video:
                Async.background({
                    TwilloCallmanager.instance.twilloVideoCallAction(user_id: userId, session_Token: sessionID, call_id: callID, answer_type: "decline", completionBlock: { (result) in
                        
                        switch result {
                        case .success(_):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.dismiss(animated: true, completion: {
                                        self.timer.invalidate()
                                    })
                                }
                            })
                            break
                            
                        case .failure(let error):
                            Async.main({
                                self.dismissProgressDialog {
                                    self.view.makeToast(error.localizedDescription)
                                }
                            })
                            break
                        }
                    })
                })
                break
            case .none:
                break
            }
        }
    }
    
    private func setCallLogs(callActionMessage: String?) {
        //        log.verbose("Check = \(UserDefaults.standard.getCallsLogs(Key: Local.CALL_LOGS.CallLogs))")
        
        var name = ""
        var profilePicture = ""
        var userId = ""
        var username = ""
        
        if let chat = self.chatModel {
            name = chat._name
            profilePicture = chat._avatar_url
            userId = chat._user_id
            username = chat._username
            
        }else if let contact = contactUserObject {
            name = contact.name ?? ""
            profilePicture = contact.avatar ?? ""
            userId = contact.userID ?? ""
            username = contact.username ?? ""
            
        }else if let callUser = callLogUserObject {
            name =  self.callLogUserObject?.name ?? ""
            profilePicture = self.callLogUserObject?.profilePicture ?? ""
            userId =  self.callLogUserObject?.userId ?? ""
            username = self.callLogUserObject?.name  ?? ""
            
        }else if let searchUser = searchUserObject {
            name = self.searchUserObject?.name ?? ""
            profilePicture = self.searchUserObject?.avatar ?? ""
            userId = searchUserObject?.userID ?? ""
            username = self.searchUserObject?.username  ?? ""
            
        }else {
            name = followingUserObject?.name ?? ""
            profilePicture = followingUserObject?.avatar ?? ""
            userId = followingUserObject?.userID ?? ""
            username = self.followingUserObject?.username  ?? ""
        }
        
        let callLogsObject = CallLogsModel(userId: userId,
                                           name: name,
                                           profilePicture: profilePicture,
                                           logText: callActionMessage ?? "",
                                           type: callingStatus)
        let objectToEncode = callLogsObject
        let data = try? PropertyListEncoder().encode(objectToEncode)
        var getCallLogsData = UserDefaults.standard.getCallsLogs(Key: Local.CALL_LOGS.CallLogs)
        getCallLogsData.append(data!)
        UserDefaults.standard.setCallLogs(value: getCallLogsData, ForKey: Local.CALL_LOGS.CallLogs)
    }
}
