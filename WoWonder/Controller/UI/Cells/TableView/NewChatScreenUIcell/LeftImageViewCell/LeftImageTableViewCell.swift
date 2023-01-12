//
//  LeftImageTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 10/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class LeftImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var messageVIew: UIControl!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var sendImageView: UIImageView!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var cellVIew: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageVIew.clipsToBounds = true
        self.messageVIew.layer.cornerRadius = 12
        self.messageVIew.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
