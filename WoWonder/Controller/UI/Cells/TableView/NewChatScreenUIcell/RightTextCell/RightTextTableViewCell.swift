//
//  RightTextTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 09/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class RightTextTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var lastseenImage: UIImageView!
    @IBOutlet weak var messaageTextLabel: UILabel!
    @IBOutlet weak var messgaeView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messgaeView.clipsToBounds = true
        self.messgaeView.layer.cornerRadius = 12
        self.messgaeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
