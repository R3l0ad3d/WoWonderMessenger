//
//  UserListChatCell.swift
//  WoWonder
//
//  Created by UnikaApp on 12/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class UserListChatCell: UITableViewCell {

    @IBOutlet weak var pinmasageWith: NSLayoutConstraint!
    
    @IBOutlet weak var pinmasage: UIImageView!
    @IBOutlet weak var onlineImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var lastMassageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userimageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var isLastSeenImage: UIImageView!
    
    @IBOutlet weak var withLayoutConstraintimage: NSLayoutConstraint!
    @IBOutlet weak var lastMessageIcone: UIImageView!
    @IBOutlet weak var stutesView: UIView!
    
    @IBOutlet weak var muteImageVIew: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
