//
//  RightDocumentTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 10/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class RightDocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var docTypeLabel: UILabel!
    @IBOutlet weak var docNameLabel: UILabel!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var lastseenImage: UIImageView!
    @IBOutlet weak var messageSubView: UIView!
    @IBOutlet weak var messageMainView: UIControl!    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var starImageVIew: UIImageView!
    @IBOutlet weak var documentImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageMainView.clipsToBounds = true
        self.messageMainView.layer.cornerRadius = 8
        self.messageMainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        if objColor as? String != "" {
            self.messageMainView.backgroundColor = UIColor(hex: objColor as! String)
            
            self.documentImageview.image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
            self.documentImageview.tintColor = UIColor(hex: objColor as! String)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
