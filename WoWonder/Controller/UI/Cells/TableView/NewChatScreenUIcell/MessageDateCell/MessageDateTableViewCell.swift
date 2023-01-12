//
//  MessageDateTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 12/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class MessageDateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stutesView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
