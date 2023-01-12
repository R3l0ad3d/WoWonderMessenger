//
//  MessageModelResponse.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

struct MessageModelResponse: Codable {
    var apiStatus: Int?
    var messages: [MessageModel]?
    var typing, isRecording: Int?
    
    enum CodingKeys: String, CodingKey {
        case apiStatus = "api_status"
        case messages, typing
        case isRecording = "is_recording"
    }
}

struct SendMessageResponse: Codable {
    var apiStatus: Int?
    var messages: [SendMessageModel]?
    
    enum CodingKeys: String, CodingKey {
        case apiStatus = "api_status"
        case messages = "message_data"
    }
}
