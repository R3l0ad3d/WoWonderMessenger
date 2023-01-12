//
//  
//  AgoraCallSuccessModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 05/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct AgoraCallSuccessModel: Codable {
    var api_status: Int?
    var room_name: String?
    var id: Int?
    var token: String?
    
    var _api_status: Int {
        get {
            return self.api_status ?? 0
        }
    }
    
    var _room_name: String {
        get {
            return self.room_name ?? ""
        }
    }
    
    var _id: Int {
        get {
            return self.id ?? 0
        }
    }
    
    var _token: String {
        get {
            return self.token ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case api_status
        case room_name = "room_name"
        case id
        case token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let api_status = try? container.decode(Int.self, forKey: .api_status) {
            self.api_status = api_status
        }
        if let roomName = try? container.decode(String.self, forKey: .room_name) {
            self.room_name = roomName
        }
        if let id = try? container.decode(Int.self, forKey: .id) {
            self.id = id
        }
        if let token = try? container.decode(String.self, forKey: .token) {
            self.token = token
        }
    }
}
