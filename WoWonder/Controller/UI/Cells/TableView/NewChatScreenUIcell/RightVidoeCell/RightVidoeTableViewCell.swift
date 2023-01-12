//
//  RightVidoeTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 10/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class RightVidoeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var mesaageView: UIView!
    @IBOutlet weak var mesaageVidoeView: UIView!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var playvidoeButton: UIControl!
    @IBOutlet weak var vidoeImageVIew: UIImageView!
    @IBOutlet weak var starImageVIew: UIImageView!
    @IBOutlet weak var lastseenImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mesaageView.clipsToBounds = true
        self.mesaageView.layer.cornerRadius = 12
        self.mesaageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        
        if objColor as? String != "" {
            self.mesaageView.backgroundColor = UIColor(hex: objColor as! String)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
