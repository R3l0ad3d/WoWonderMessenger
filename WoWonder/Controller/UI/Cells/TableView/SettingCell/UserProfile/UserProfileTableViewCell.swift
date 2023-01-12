//
//  UserProfileTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 14/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var userIdprofileName: UILabel!
    @IBOutlet weak var cameraButton: UIControl!
    @IBOutlet weak var cellVew: UIView!
    @IBOutlet weak var cameraImagevIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cameraImagevIew.tintColor = UIColor.mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
