//
//  ChatBottomSiteCell.swift
//  WoWonder
//
//  Created by Fs on 29/09/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class ChatBottomSiteCell: UITableViewCell {

    @IBOutlet weak var iconeImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var namelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
