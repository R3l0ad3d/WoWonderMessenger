//
//  MediaCollectionViewCell.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 29/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Kingfisher

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var imageName: UIImageView!
    
    //Varible's
    var object: Messages! {
        willSet {
            guard newValue._media_file_name.isNotEmpty else { return }
            let url = URL(string: newValue._media)
            self.mediaImageView.kf.indicatorType = .activity
            self.mediaImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
}
