//
//  
//  TwilloVideoCallSuccessModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 04/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit


struct TwilloVidooCallSuccessModel: Codable {
    var status: Int?
    var accessToken: String?
    var accessToken2: String?
    var roomName: String?
    var id: Int?
    
    var _status: Int {
        get {
            return self.status ?? 0
        }
    }
    
    var _accessToken: String {
        get {
            return self.accessToken ?? ""
        }
    }
    
    var _accessToken2: String {
        get {
            return self.accessToken2 ?? ""
        }
    }
    
    var _roomName: String {
        get {
            return self.roomName ?? ""
        }
    }
    
    var _id: Int {
        get {
            return self.id ?? 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case accessToken = "access_token"
        case accessToken2 = "access_token_2"
        case roomName = "room_name"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let status = try? container.decode(Int.self, forKey: .status) {
            self.status = status
        }
        if let accessToken = try? container.decode(String.self, forKey: .accessToken) {
            self.accessToken = accessToken
        }
        if let accessToken2 = try? container.decode(String.self, forKey: .accessToken2) {
            self.accessToken2 = accessToken2
        }
        if let roomName = try? container.decode(String.self, forKey: .roomName) {
            self.roomName = roomName
        }
        if let id = try? container.decode(Int.self, forKey: .id) {
            self.id = id
        }
    }
}
