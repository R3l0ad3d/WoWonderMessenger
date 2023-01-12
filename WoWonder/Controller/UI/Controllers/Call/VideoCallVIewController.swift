

import UIKit
import AgoraRtcKit
import Async
import WowonderMessengerSDK

class VideoCallVIewController: BaseVC,StoryBoardVC {
    
    @IBOutlet weak var localVideo: UIView!
    @IBOutlet weak var remoteVideo: UIView!
    @IBOutlet weak var controlButtons: UIView!
    @IBOutlet weak var remoteVideoMutedIndicator: UIImageView!
    @IBOutlet weak var localVideoMutedBg: UIImageView!
    @IBOutlet weak var localVideoMutedIndicator: UIImageView!
    
    var agoraKit: AgoraRtcEngineKit!
    
    var recipientId:String? = ""
    var callId:Int? = 0
    var roomID:String? = ""
    
    private var timer = Timer()
    private var callProvider: CallProvider {
        get {
            return ControlSettings.agoraCall == true && ControlSettings.twilloCall == false ? .agora : .twillo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        hideVideoMuted()
        initializeAgoraEngine()
        setupVideo()
        setupLocalVideo()
        joinChannel()
        self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                          target: self,
                                          selector: #selector(self.update),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func didClickMuteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        agoraKit.muteLocalAudioStream(sender.isSelected)
        resetHideButtonsTimer()
    }
    
    @IBAction func didClickVideoMuteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        agoraKit.muteLocalVideoStream(sender.isSelected)
        localVideo.isHidden = sender.isSelected
        localVideoMutedBg.isHidden = !sender.isSelected
        localVideoMutedIndicator.isHidden = !sender.isSelected
        resetHideButtonsTimer()
    }
    
    @IBAction func didClickSwitchCameraButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        agoraKit.switchCamera()
        resetHideButtonsTimer()
    }
}

// MARK: - AGORA ENGINE DELEGATE

extension VideoCallVIewController: AgoraRtcEngineDelegate {
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
        if (remoteVideo.isHidden) {
            remoteVideo.isHidden = false
        }
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteVideo
        videoCanvas.renderMode = .fit
        agoraKit.setupRemoteVideo(videoCanvas)
    }
    
    internal func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid:UInt, reason:AgoraUserOfflineReason) {
        self.remoteVideo.isHidden = true
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoMuted muted:Bool, byUid:UInt) {
        remoteVideo.isHidden = muted
        remoteVideoMutedIndicator.isHidden = !muted
    }
}

// MARK: - CUSTOM FUNCTIONS

extension VideoCallVIewController {
    
    //cea80c3b9a744f69ba90a68d07ca9167
    func initializeAgoraEngine() {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: ControlSettings.agoraCallingToken, delegate: self)
    }
    
    func setupVideo() {
        agoraKit.enableVideo()  // Default mode is disableVideo
    }
    
    func setupLocalVideo() {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localVideo
        videoCanvas.renderMode = .hidden
        agoraKit.setupLocalVideo(videoCanvas)
    }
    
    func joinChannel() {
        agoraKit.setDefaultAudioRouteToSpeakerphone(true)
        agoraKit.joinChannel(byToken: nil, channelId: "\(callId!)", info: nil, uid: 0) {[weak self] (sid, uid, elapsed) -> Void in
            // Join channel "demoChannel1"
            if let _ = self {
                UIApplication.shared.isIdleTimerDisabled = true
            }
        }
    }
    
    @IBAction func didClickHangUpButton(_ sender: UIButton) {
        leaveChannel()
    }
    
    private func leaveChannel() {
        agoraKit.leaveChannel(nil)
        hideControlButtons()
        UIApplication.shared.isIdleTimerDisabled = false
        remoteVideo.removeFromSuperview()
        localVideo.removeFromSuperview()
        let callIdConverted = "\(callId!)"
        
        switch self.callProvider {
        case .agora:
            self.declineCall(callID: callIdConverted)
            break
            
        case .twillo:
            self.twilloDeclineCall(callID: callIdConverted)
            break
        }
    }
    
    private func setupButtons() {
        perform(#selector(hideControlButtons), with: nil, afterDelay: 8)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.ViewTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    @objc func hideControlButtons() {
        self.controlButtons.isHidden = true
    }
    
    @objc func ViewTapped() {
        if (self.controlButtons.isHidden) {
            self.controlButtons.isHidden = false;
            perform(#selector(hideControlButtons), with: nil, afterDelay: 8)
        }
    }
    
    private func resetHideButtonsTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(hideControlButtons), with: nil, afterDelay: 8)
    }
    
    func hideVideoMuted() {
        self.remoteVideoMutedIndicator.isHidden = true
        self.localVideoMutedBg.isHidden = true
        self.localVideoMutedIndicator.isHidden = true
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
            TwilloCallmanager.instance.twilloVideoCallAction(user_id: userId,
                                                             session_Token: sessionID,
                                                             call_id: callID,
                                                             answer_type: "decline", completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main {
                        self.dismissProgressDialog {
                            
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
    
    @objc func update() {
        self.checkForCallAction(callID: self.callId!)
    }
    
    private func checkForCallAction(callID: Int) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        switch self.callProvider {
        case .agora:
            Async.background({
                CallManager.instance.checkForAgoraCall(access_token: sessionID, call_id: callID, completionBlock: { (result) in
                    
                    switch result {
                    case .success(let model):
                        Async.main({
                            self.dismissProgressDialog {
                                
                                switch model._callStatusObject {
                                case .answered:
                                    break
                                    
                                case .declined, .no_answer:
                                    self.navigationController?.popViewController(animated: true)
                                    self.leaveChannel()
                                    self.timer.invalidate()
                                    break
                                    
                                case .unknown:
                                    break
                                case .calling:
                                    break
                                }
                            }
                        })
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
            
        case .twillo:
            Async.background({
                TwilloCallmanager.instance.checkForTwilloCall(user_id: userId,
                                                              session_Token: sessionID,
                                                              call_id: callID,
                                                              call_Type: "video", completionBlock: { (result) in
                    switch result {
                    case .success(let model):
                        Async.main({
                            self.dismissProgressDialog {
                                switch model._callStatusObject {
                                case .answered:
                                    break
                                case .calling:
                                    break
                                case .declined, .no_answer:
                                    self.navigationController?.popViewController(animated: true)
                                    self.leaveChannel()
                                    self.timer.invalidate()
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
        }
    }
}
