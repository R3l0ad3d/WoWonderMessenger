//
//  VideoCallViewController.swift
//  WoWonder
//
//  Created by Mac on 30/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import AgoraRtcKit
import AgoraUIKit

class VideoCallViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var localVideoView: UIView!
    @IBOutlet weak var muteButton: UIControl!
    @IBOutlet weak var hangUpButton: UIControl!
    @IBOutlet weak var cancleCallImagevIew: UIImageView!
    @IBOutlet weak var muteImageVIew: UIImageView!
    
    //varible's
    var getArrayAgora: AgoraCallSuccessModel?
    var agoraKit: AgoraRtcEngineKit?
    let tempToken: String? = nil //If you have a token, put it here.
    var userID: UInt = 0
    var channelName = ""
    var remoteUserIDs: [UInt] = []
    var muted = false {
        didSet {
            if muted {
                self.muteImageVIew.image = UIImage(named: "muteButtonSelected")
            } else {
                self.muteImageVIew.image = UIImage(named: "muteButton")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let XIB = UINib(nibName: "CallCollectionViewCell", bundle: nil)
        self.collectionView.register(XIB, forCellWithReuseIdentifier: "CallCollectionViewCell")
        
        self.muteButton.addTarget(self, action: #selector(muteButtonClick), for: .touchUpInside)
        self.channelName = getArrayAgora?._room_name ?? ""
        
        
        self.setUpVideo()
    }
    
    @objc func muteButtonClick() {
        if muted {
            getAgoraEngine().muteLocalAudioStream(false)
        } else {
            getAgoraEngine().muteLocalAudioStream(true)
        }
        muted = !muted
    }
    
    private func getAgoraEngine() -> AgoraRtcEngineKit {
        if agoraKit == nil {
            agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "220", delegate: self)
        }
        return agoraKit!
    }
    
    func setUpVideo() {
        getAgoraEngine().enableVideo()
        
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = userID
        videoCanvas.view = localVideoView
        videoCanvas.renderMode = .fit
        getAgoraEngine().setupLocalVideo(videoCanvas)
    }
    
    func joinChannel() {
        localVideoView.isHidden = false

        getAgoraEngine().joinChannel(byToken: tempToken, channelId: channelName, info: nil, uid: userID) { [weak self] (sid, uid, elapsed) in
            self?.userID = uid
        }
    }
    
    func leaveChannel() {
        getAgoraEngine().leaveChannel(nil)
        localVideoView.isHidden = true
        remoteUserIDs.removeAll()
        collectionView.reloadData()
    }
}

extension VideoCallViewController: AgoraRtcEngineDelegate {
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        self.remoteUserIDs.append(uid)
        self.collectionView.reloadData()
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        if let index = self.remoteUserIDs.firstIndex(where: { $0 == uid }) {
            self.remoteUserIDs.remove(at: index)
            self.collectionView.reloadData()
        }
    }
}

extension VideoCallViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return remoteUserIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallCollectionViewCell", for: indexPath) as? CallCollectionViewCell
        
        let remoteID = remoteUserIDs[indexPath.row]
        if let videoCell = cell {
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = remoteID
            videoCanvas.view = videoCell.videoView
            videoCanvas.renderMode = .fit
            getAgoraEngine().setupRemoteVideo(videoCanvas)
        }
        
        return cell ?? UICollectionViewCell()
    }
}
