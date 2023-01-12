

import UIKit
import AgoraRtcKit
import Async
import WowonderMessengerSDK
import Kingfisher
import AVFAudio
import AVFoundation

class AgoraCallVC: BaseVC,StoryBoardVC {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var callControlActionStackView: UIStackView!
    @IBOutlet weak var callActionsStackView: UIStackView!
    
    var user: UserModel?
    var callType: CallType?
    var callDirection: CallDirection?
    var callProvider: CallProvider {
        get {
            return ControlSettings.agoraCall == true && ControlSettings.twilloCall == false ? .agora : .twillo
        }
    }
    
    var contactUserObject: SelectContactModel.User?
    var callLogUserObject: CallLogsModel?
    var searchUserObject: SearchModel.User?
    var followingUserObject: FollowingModel.Following?
    var delegate: CallReceiveDelegate?
    var isDialer = false
    
    var callId: Int = 0
    var roomName: String = ""
    var callToken: String = ""
    
    private var callTimer = Timer()
    private var callDeclinedTimer = Timer()
    private var callDeclinedCount = 0
    private var seconds = 0
    
    private var callingStatus: String? = ""
    private var checkCallTimer = Timer()
    private var accessTokenID = ""
    private var callAudioPlayer: AVAudioPlayer?
//    private var callingStyle: String = ""
    
    var agoraKit: AgoraRtcEngineKit!
    var roomID: String = ""
    
    var profileImageUrlString: String?
    var usernameString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        self.setupUI()
        self.initializeAgoraEngine()
        self.playCallSound()
        self.facthCalling()
       
    }
    
}

// MARK: - ACTIONS

extension AgoraCallVC {
    
    @IBAction func declineCallAction(_ sender: UIButton) {
        self.leaveChannel()
        let callIdConverted = "\(callId)"
        
        switch self.callProvider {
        case .agora:
            self.declineCall(callID: callIdConverted)
            break
            
        case .twillo:
            self.twilloDeclineCall(callID: callIdConverted)
            break
        }
    }
    
    @IBAction func endCallAction(_ sender: UIButton) {
        self.leaveChannel()
        self.closeCall(callID: "\(self.callId)")
    }
    
    @IBAction func answerCallAction(_ sender: UIButton) {
        let callIdConverted = "\(callId)"
        print(self.callId)
        switch self.callProvider {
        case .agora:
            self.answerCall(callID: callIdConverted)
            break
        case .twillo:
            self.twilloAnswerCall(callID: callIdConverted)
            break
        }
    }
    
    @IBAction func didClickMuteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.agoraKit.muteLocalAudioStream(sender.isSelected)
    }
    
    @IBAction func didClickSwitchSpeakerButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.agoraKit.setEnableSpeakerphone(sender.isSelected)
    }
}

// MARK: - CUSTOM FUNCTIONS

extension AgoraCallVC {
    
    func facthCalling() {
        switch self.callDirection {
        case .incoming:
            self.checkCallTimer = Timer.scheduledTimer(timeInterval: 0.6,
                                                       target: self,
                                                       selector: #selector(self.checkCall),
                                                       userInfo: nil,
                                                       repeats: true)
            break
            
        case .outgoing:
//            self.callUser()
            break
            
        case .none:
            break
        }
    }
    
    private func initializeAgoraEngine() {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: ControlSettings.agoraCallingToken, delegate: self)
    }
    
    private func joinChannel() {
        print("Token \(self.callToken) => \(self.roomName)")
//        agoraKit.joinChannel(byToken: self.callToken,
//                             channelId: "\(self.roomName)",
//                             info: nil,
//                             uid: 0) { [unowned self] (sid, uid, elapsed) -> Void in
//            print("Join \(sid) => \(uid)")
//            self.agoraKit.setEnableSpeakerphone(true)
//            UIApplication.shared.isIdleTimerDisabled = true
//        }
        agoraKit?.joinChannel(byToken: callToken,
                              channelId: roomName,
                              info: nil,
                              uid: 0)

    }
    
    private func leaveChannel() {
        self.agoraKit.leaveChannel(nil)
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    private func invalidateCallTimers() {
        self.checkCallTimer.invalidate()
        self.callDeclinedTimer.invalidate()
    }
    
    private func onAnswerCall() {
        self.invalidateCallTimers()
        self.callControlActionStackView.isHidden = false
        self.callActionsStackView.isHidden = true
        self.stopCallSound()
        self.callTimer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(self.setCallTimerToLabel(_:)),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    private func setupUI() {
        
        self.usernameLabel.text = user?.name ?? ""
        let url = URL(string: user?.avatar ?? "")
        self.profileImage.kf.indicatorType = .activity
        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        self.profileImage.cornerRadiusV = self.profileImage.frame.height / 2
    }
    
    @objc
    private func checkCall() {
        self.checkForCallAction(callID: self.callId)
    }
    
    private func closeScreen(_ completion: VoidCompletion? = nil) {
        self.checkCallTimer.invalidate()
        self.callTimer.invalidate()
        self.callDeclinedTimer.invalidate()
        self.stopCallSound()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func checkForCallAction(callID: Int) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        guard self.callDeclinedCount < 8 else {
            self.closeCall(callID: "\(callID)")
            return
        }
        
        switch self.callProvider {
        case .agora:
            Async.background({
                CallManager.instance.checkForAgoraCall(access_token: sessionID,
                                                       call_id: callID,
                                                       completionBlock: { (success) in
                    switch success {
                    case .success(let model):
                        Async.main({
                            self.dismissProgressDialog {
                                self.callStatusLabel.text = model._call_status
                                switch model._callStatusObject {
                                case .declined:
                                    self.leaveChannel()
                                    self.closeScreen()
                                    break
                                    
                                case .answered:
                                    self.invalidateCallTimers()
                                    self.joinChannel()
                                    break
                                    
                                case .calling:
                                    if !self.callDeclinedTimer.isValid {
                                        self.callDeclinedTimer = Timer.scheduledTimer(timeInterval: 5,
                                                                                      target: self,
                                                                                      selector: #selector(self.incrementCallDeclinedCount(_:)),
                                                                                      userInfo: nil,
                                                                                      repeats: true)
                                    }
                                    break
                                    
                                case .no_answer:
                                    self.closeScreen()
                                    break
                                    
                                case .unknown:
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
            break
            
        case .twillo:
            Async.background({
                TwilloCallmanager.instance.checkForTwilloCall(user_id: userId,
                                                              session_Token: sessionID,
                                                              call_id: callID,
                                                              call_Type: "audio", completionBlock: { (result) in
                    
                    switch result {
                    case .success(let model):
                        switch model._callStatusObject {
                        case .calling:
                            break
                            
                        case .answered:
                            break
                            
                        case .declined, .no_answer:
                            self.leaveChannel()
                            self.closeScreen()
                            break
                        }
                        break
                        
                    case .failure(let error):
                        Async.main {
                            self.dismissProgressDialog {
                                self.view.makeToast(error.localizedDescription)
                            }
                        }
                        break
                    }
                })
            })
            break
        }
    }
    
    @objc
    private func incrementCallDeclinedCount(_ timer: Timer) {
        self.callDeclinedCount += 1
    }
    
    @objc
    private func setCallTimerToLabel(_ timer: Timer) {
        self.seconds += 1
        self.callStatusLabel.text = self.getSecondsString()
    }
    
    private func getSecondsString() -> String {
        let hours = self.seconds / 3600
        let minutes = self.seconds / 60 % 60
        let seconds = self.seconds % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func declineCall(callID: String) {
        
        //        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            CallManager.instance.agoraCallAction(access_token: sessionID,
                                                 call_id: callID,
                                                 action: "decline", completionBlock: { (result) in
                switch result {
                case .success(_):
                    Async.main {
                        self.dismissProgressDialog {
                            self.closeScreen()
                        }
                    }
                    break
                    
                case .failure(let error):
                    Async.main {
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    }
                    break
                }
            })
        })
    }
    
    private func closeCall(callID: String) {
        
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            CallManager.instance.agoraCallAction(access_token: sessionID,
                                                 call_id: callID,
                                                 action: "close", completionBlock: { (result) in
                switch result {
                case .success(_):
                    Async.main {
                        self.dismissProgressDialog {
                            self.closeScreen()
                        }
                    }
                    break
                    
                case .failure(let error):
                    Async.main {
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    }
                    break
                }
            })
        })
    }
    
    private func answerCall(callID: String) {        
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            CallManager.instance.agoraCallAction(access_token: sessionID,
                                                 call_id: callID,
                                                 action: "answer", completionBlock: { (result) in
                switch result {
                case .success(let model):
                    Async.main {
                        self.dismissProgressDialog {
                            print("Answer Status \(model._status)")

                            if model._status == 200 {
                                self.joinChannel()
                            }
                        }
                    }
                    break
                    
                case .failure(let error):
                    Async.main {
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    }
                    break
                }
            })
        })
    }
    
    private func twilloDeclineCall(callID: String) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.twilloAudioCallAction(user_id: userId,
                                                             session_Token: sessionID,
                                                             call_id: callID,
                                                             answer_type: "decline",
                                                             completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main({
                        self.dismissProgressDialog {
                            self.closeScreen()
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
    
    private func twilloAnswerCall(callID: String) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.twilloAudioCallAction(user_id: userId, session_Token: sessionID, call_id: callID, answer_type: "answer", completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main({
                        self.dismissProgressDialog {
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
    
    private func playCallSound() {
        guard let url = Bundle.main.url(forResource: "mystic_call", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.callAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let aPlayer = callAudioPlayer else { return }
            aPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func stopCallSound() {
        self.callAudioPlayer?.stop()
    }
}

// MARK: - AGORA ENGINE DELEGATE

extension AgoraCallVC: AgoraRtcEngineDelegate {
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        print("Join channel \(channel)")
        self.onAnswerCall()
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        print("Join UID \(uid)")
    }
}
