//
//  LeftDocumentTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 10/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class LeftDocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var docTypeLabel: UILabel!
    @IBOutlet weak var docNameLabel: UILabel!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var messageSubView: UIView!
    @IBOutlet weak var messageMainView: UIControl!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageMainView.clipsToBounds = true
        self.messageMainView.layer.cornerRadius = 8
        self.messageMainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
