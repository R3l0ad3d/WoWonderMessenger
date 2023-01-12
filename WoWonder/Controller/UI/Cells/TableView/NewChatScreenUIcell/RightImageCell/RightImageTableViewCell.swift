//
//  RightImageTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 09/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class RightImageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageVIew: UIControl!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var lastseenImage: UIImageView!
    @IBOutlet weak var sendImageView: UIImageView!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var cellVIew: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageVIew.clipsToBounds = true
        self.messageVIew.layer.cornerRadius = 12
        self.messageVIew.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
//        if objColor as! String != "" {
//            self.messageVIew.backgroundColor = UIColor(hex: objColor as! String)
//        }
        
    }
    
}
