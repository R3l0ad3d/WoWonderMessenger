//
//  
//  CommonDetailsModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct CommonDetailsModel: Codable {
    var postCount, albumCount, followingCount, followersCount: String?
    var groupsCount, likesCount: String?
    //    var mutualFriendsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case postCount = "post_count"
        case albumCount = "album_count"
        case followingCount = "following_count"
        case followersCount = "followers_count"
        case groupsCount = "groups_count"
        case likesCount = "likes_count"
        //        case mutualFriendsCount = "mutual_friends_count"
    }
}
