//
//  LeftContactTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 14/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class LeftContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageVIew: UIControl!
    @IBOutlet weak var messageTimeVIew: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userprofileImageVIew: UIImageView!
    @IBOutlet weak var starImageVIew: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageVIew.clipsToBounds = true
        self.messageVIew.layer.cornerRadius = 12
        self.messageVIew.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
