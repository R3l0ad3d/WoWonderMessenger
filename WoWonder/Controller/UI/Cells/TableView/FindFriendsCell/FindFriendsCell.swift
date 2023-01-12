//
//  FindFriendsCell.swift
//  WoWonder
//
//  Created by UnikApp on 05/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class FindFriendsCell: UICollectionViewCell {

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var lastStutesLabek: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var stutesView: UIView!
    @IBOutlet weak var userImagevIew: UIImageView!
    @IBOutlet weak var cellVIew: UIView!
    
    var indexPath:Int?
    var delegate:FollowUnFollowDelegate?
    var userId:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    @IBAction func followPressed(_ sender: Any) {
        let userID = userId ?? ""
        let index = indexPath ?? 0
        self.delegate?.followUnfollow(user_id: userID, index: index, cellBtn: followButton!)
    }
    
}
