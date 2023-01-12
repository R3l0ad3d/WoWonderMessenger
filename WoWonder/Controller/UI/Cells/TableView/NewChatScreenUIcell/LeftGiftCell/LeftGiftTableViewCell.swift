//
//  LeftGiftTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 10/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class LeftGiftTableViewCell: UITableViewCell {

    @IBOutlet weak var messageGiftView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var giftPlayButton: UIControl!
    @IBOutlet weak var vidoeImageVIew: UIImageView!
    @IBOutlet weak var profileImge: UIImageView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageView.clipsToBounds = true
        self.messageView.layer.cornerRadius = 12
        self.messageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
