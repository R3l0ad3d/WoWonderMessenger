//
//  BottonSetCell.swift
//  WoWonder
//
//  Created by Mac on 17/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class BottonSetCell: UITableViewCell {

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var moreimageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
