//
//  
//  CheckTwilloCallSuccessModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 03/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct CheckTwilloCallSuccessModel: Codable {
    var apiStatus: String?
    var apiText: String?
    var apiVersion: String?
    var callType: String?
    var callStatus: Int?
    
    var _apiStatus: String {
        get {
            return self.apiStatus ?? ""
        }
    }
    
    var _apiText: String {
        get {
            return self.apiText ?? ""
        }
    }
    
    var _apiVersion: String {
        get {
            return self.apiVersion ?? ""
        }
    }
    
    var _callType: String {
        get {
            return self.callType ?? ""
        }
    }
    
    var _callStatus: Int {
        get {
            return self.callStatus ?? 0
        }
    }
    
    var _callStatusObject: CallStatus {
        get {
            return CallStatus(rawValue: self._callStatus) ?? .no_answer
        }
    }
    
    enum CallStatus: Int, CaseIterable {
        /// 400
        case declined = 400
        /// 300
        case calling = 300
        /// 200
        case answered = 200
        case no_answer
    }
    
    enum CodingKeys: String, CodingKey {
        case apiStatus = "api_status"
        case apiText = "api_text"
        case apiVersion = "api_version"
        case callType = "call_type"
        case callStatus = "call_status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let apiStatus = try? container.decode(String.self, forKey: .apiStatus) {
            self.apiStatus = apiStatus
        }
        if let apiText = try? container.decode(String.self, forKey: .apiText) {
            self.apiText = apiText
        }
        if let apiVersion = try? container.decode(String.self, forKey: .apiVersion) {
            self.apiVersion = apiVersion
        }
        if let callType = try? container.decode(String.self, forKey: .callType) {
            self.callType = callType
        }
        if let callStatus = try? container.decode(Int.self, forKey: .callStatus) {
            self.callStatus = callStatus
        }
    }
}
