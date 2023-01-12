//
//  
//  AgoraCheckCallModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 03/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct AgoraCheckCallModel: Codable {
    
    var api_status: Int?
    var call_status: String?
    
    var _api_status: Int {
        get {
            return self.api_status ?? 0
        }
    }
    
    var _call_status: String {
        get {
            return self.call_status ?? ""
        }
    }
    
    var _callStatusObject: CallStatus {
        get {
            return CallStatus(rawValue: self._call_status) ?? .unknown
        }
    }
    
    enum CallStatus: String, CaseIterable {
        case declined
        case answered
        case no_answer
        case calling
        case unknown
    }
    
    enum CodingKeys: String, CodingKey {
        case api_status = "api_status"
        case call_status = "call_status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let api_status = try? container.decode(Int.self, forKey: .api_status) {
            self.api_status = api_status
        }
        if let callStatus = try? container.decode(String.self, forKey: .call_status) {
            self.call_status = callStatus
        }
    }
}
