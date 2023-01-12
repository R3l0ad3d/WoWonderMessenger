//
//  RightContactTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 14/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class RightContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageVIew: UIControl!
    @IBOutlet weak var messageTimeVIew: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starImageVIew: UIImageView!
    @IBOutlet weak var lastseenImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageVIew.clipsToBounds = true
        self.messageVIew.layer.cornerRadius = 12
        self.messageVIew.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        
//        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
//        if objColor as! String != "" {
//            self.messageVIew.backgroundColor = UIColor(hex: objColor as! String)
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
