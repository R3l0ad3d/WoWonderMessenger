//
//  LeftTextTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 09/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class LeftTextTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var masageTextLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var cellVIew: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageView.clipsToBounds = true
        self.messageView.layer.cornerRadius = 12
        self.messageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
