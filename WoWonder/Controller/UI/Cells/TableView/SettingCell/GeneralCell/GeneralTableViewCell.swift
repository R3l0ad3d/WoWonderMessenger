//
//  GeneralTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 14/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    @IBOutlet weak var chackMarkImageView: UIImageView!
    @IBOutlet weak var rightArroeView: UIView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var decrepitationLabel: UILabel!
    @IBOutlet weak var Actionbutton: UIControl!
    @IBOutlet weak var switchStutes: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.Actionbutton.borderColorV = UIColor.mainColor
        self.switchStutes.onTintColor = UIColor.mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
