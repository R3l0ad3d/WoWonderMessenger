//
//  LeftAudioTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 12/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import AVFAudio

class LeftAudioTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var audioSliderView: UISlider!
    @IBOutlet weak var playAudioImageView: UIControl!
    @IBOutlet weak var microImageVIew: UIImageView!
    @IBOutlet weak var reciveprofileImage: UIImageView!
    @IBOutlet weak var audioview: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var timeMassageLabel: UILabel!
    @IBOutlet weak var starImageVIew: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    
    
    var play = false
    var player : AVAudioPlayer?
    var updater : CADisplayLink! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.audioview.clipsToBounds = true
        self.audioview.layer.cornerRadius = 12
        self.audioview.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                              .layerMinXMaxYCorner,
                                              .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playButtonClick(_ sender: UIControl) {
        if play == false {
            self.playImageView.image = UIImage(named: "play")
            self.play = true
            updater = CADisplayLink(target: self, selector: #selector(trackAudio))
            updater.frameInterval = 1
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
            player?.numberOfLoops = -1 // play indefinitely
            player?.prepareToPlay()
            player?.play()
            audioSliderView.minimumValue = 0
            audioSliderView.maximumValue = 100

        } else {
            self.playImageView.image = UIImage(systemName: "pause")
            self.playImageView.tintColor = .black
            self.play = false
            self.player?.stop()

        }
    }
    
    @objc func trackAudio() {
        let normalizedTime = Float((player?.currentTime ?? 0.0) * 100.0 / (player?.duration ?? 0.0))
        audioSliderView.value = normalizedTime
    }
}
