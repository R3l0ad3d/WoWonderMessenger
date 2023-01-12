//
//  
//  UserCallData.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct UserCallData: Codable {
    var data: UserCallModel?
    var userID: String?
    var avatar: String?
    var name: String?
    
    var _userID: String {
        get {
            return self.userID ?? ""
        }
    }
    
    var _avatar: String {
        get {
            return self.avatar ?? ""
        }
    }
    
    var _name: String {
        get {
            return self.name ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case data
        case userID = "user_id"
        case avatar, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let data = try? container.decode(UserCallModel.self, forKey: .data) {
            self.data = data
        }
        if let userID = try? container.decode(String.self, forKey: .userID) {
            self.userID = userID
        }
        if let avatar = try? container.decode(String.self, forKey: .avatar) {
            self.avatar = avatar
        }
        if let name = try? container.decode(String.self, forKey: .name) {
            self.name = name
        }
    }
}
