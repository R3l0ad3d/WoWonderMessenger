//
//  RightAudioTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 12/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import AVFAudio

class RightAudioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var audioSliderView: UIProgressView!
    @IBOutlet weak var playAudioView: UIControl!
    @IBOutlet weak var microImageVIew: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
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
        self.audioview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        guard let url = URL(string: AppInstance.instance.userProfile?.avatar ?? "") else { return }        
        self.profileImage.kf.indicatorType = .activity
        self.profileImage.kf.setImage(with: url)
        
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        if objColor as? String != "" {
            self.audioview.backgroundColor = UIColor(hex: objColor as! String)
        }
        
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
            audioSliderView.progress = 0
            audioSliderView.progress = 100
            
        } else {
            self.playImageView.image = UIImage(systemName: "pause")
            self.playImageView.tintColor = .black
            self.play = false
            self.player?.stop()
            
        }
    }
    
    @objc func trackAudio() {
        let normalizedTime = Float((player?.currentTime ?? 0.0) * 100.0 / (player?.duration ?? 0.0))
        audioSliderView.progress = normalizedTime
    }
}
