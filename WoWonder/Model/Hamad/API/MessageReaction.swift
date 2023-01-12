//
//  
//  MessageReaction.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct MessageReaction : Codable {
    var isReacted: Bool?
    var type: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case isReacted = "is_reacted"
        case type, count
    }
}
