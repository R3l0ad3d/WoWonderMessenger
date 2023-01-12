//
//  RequestCell.swift
//  WoWonder
//
//  Created by UnikApp on 09/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class RequestCell: UITableViewCell {

    @IBOutlet weak var lastSeenLabel: UILabel!
    @IBOutlet weak var accpetButton: UIControl!
    @IBOutlet weak var cancleButton: UIControl!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var userProfileImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
