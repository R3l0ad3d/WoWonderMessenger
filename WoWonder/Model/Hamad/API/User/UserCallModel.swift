//
//  
//  UserCallModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct UserCallModel: Codable {
    var id: String?
    var fromID: String?
    var toID: String?
    var type: String?
    var roomName: String?
    var time: String?
    var status: String?
    var active: String?
    var called: String?
    var declined: String?
    var accessToken: String?
    var url: String?
    var accessToken2: JSONNull?
    
    var _id: String {
        get {
            return self.id ?? ""
        }
    }
    
    var _fromID: String {
        get {
            return self.fromID ?? ""
        }
    }
    
    var _toID: String {
        get {
            return self.toID ?? ""
        }
    }
    
    var _type: String {
        get {
            return self.type ?? ""
        }
    }
    
    var _roomName: String {
        get {
            return self.roomName ?? ""
        }
    }
    
    var _time: String {
        get {
            return self.time ?? ""
        }
    }
    
    var _status: String {
        get {
            return self.status ?? ""
        }
    }
    
    var _active: String {
        get {
            return self.active ?? ""
        }
    }
    
    var _called: String {
        get {
            return self.called ?? ""
        }
    }
    
    var _declined: String {
        get {
            return self.declined ?? ""
        }
    }
    
    var _accessToken: String {
        get {
            return self.accessToken ?? ""
        }
    }
    
    var _url: String {
        get {
            return self.url ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case toID = "to_id"
        case type
        case roomName = "room_name"
        case time, status, active, called, declined
        case accessToken = "access_token"
        case accessToken2 = "access_token_2"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let fromID = try? container.decode(String.self, forKey: .fromID) {
            self.fromID = fromID
        }
        if let toID = try? container.decode(String.self, forKey: .toID) {
            self.toID = toID
        }
        if let type = try? container.decode(String.self, forKey: .type) {
            self.type = type
        }
        if let roomName = try? container.decode(String.self, forKey: .roomName) {
            self.roomName = roomName
        }
        if let time = try? container.decode(String.self, forKey: .time) {
            self.time = time
        }
        if let status = try? container.decode(String.self, forKey: .status) {
            self.status = status
        }
        if let active = try? container.decode(String.self, forKey: .active) {
            self.active = active
        }
        if let called = try? container.decode(String.self, forKey: .called) {
            self.called = called
        }
        if let declined = try? container.decode(String.self, forKey: .declined) {
            self.declined = declined
        }
        if let accessToken = try? container.decode(String.self, forKey: .accessToken) {
            self.accessToken = accessToken
        }
        if let url = try? container.decode(String.self, forKey: .url) {
            self.url = url
        }
        if let accessToken2 = try? container.decode(JSONNull.self, forKey: .accessToken2) {
            self.accessToken2 = accessToken2
        }
    }
}
