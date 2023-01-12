//
//  More.swift
//  WoWonder
//
//  Created by Mac on 17/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

struct MoreModel {
    var name: String
    var moreImage: String!
}

func MoredummyData() -> [MoreModel] {
    var objMore: [MoreModel] = []
    
    objMore.append(MoreModel(name: "View Profile", moreImage: "ic_Bottom_Profile"))
    objMore.append(MoreModel(name: "Block ", moreImage: "ic_Chat_Block"))
    objMore.append(MoreModel(name: "Change Chat Theme", moreImage: "ic_Chat_Theme"))
    objMore.append(MoreModel(name: "Wallpaper ", moreImage: "ic_photo_setting"))
    objMore.append(MoreModel(name: "Clear chat ", moreImage: "ic_clear_chat"))
    objMore.append(MoreModel(name: "Media ", moreImage: "ic_photo_setting"))
    
    return objMore
}
