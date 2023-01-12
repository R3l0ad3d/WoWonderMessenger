//
//  replyReceiverTableItem.swift
//  WoWonder
//
//  Created by Muhammad Haris Butt on 27/09/2021.
//  Copyright © 2021 ScriptSun. All rights reserved.
//

import UIKit

class replyReceiverTableItem: UITableViewCell,NIBCellProtocol {
    @IBOutlet weak var messageTextLabel: UITextView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var inSideView: UIView!
    @IBOutlet weak var messageTimelabel: UILabel!
        
    var isColor = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
