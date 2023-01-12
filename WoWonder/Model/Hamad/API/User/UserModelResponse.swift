//
//  UserModelResponse.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

struct UserModelResponse: Codable {
    var apiStatus: Int?
    var data: [UserModel]?
    var videoCall: Bool?
    var videoCallUser: UserCallData?
    var audioCall: Bool?
    var audioCallUser: UserCallData?
    var agoraCall: Bool?
    var agoraCallData: UserCallData?
    
    enum CodingKeys: String, CodingKey {
        case apiStatus = "api_status"
        case data
        case videoCall = "video_call"
        case videoCallUser = "video_call_user"
        case audioCall = "audio_call"
        case audioCallUser = "audio_call_user"
        case agoraCall = "agora_call"
        case agoraCallData = "agora_call_data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let apiStatus = try? container.decode(Int.self, forKey: .apiStatus) {
            self.apiStatus = apiStatus
        }
        if let data = try? container.decode([UserModel].self, forKey: .data) {
            self.data = data
        }
        if let videoCall = try? container.decode(Bool.self.self, forKey: .videoCall) {
            self.videoCall = videoCall
        }
        if let videoCallUser = try? container.decode(UserCallData.self, forKey: .videoCallUser) {
            self.videoCallUser = videoCallUser
        }
        if let audioCall = try? container.decode(Bool.self, forKey: .audioCall) {
            self.audioCall = audioCall
        }
        if let audioCallUser = try? container.decode(UserCallData.self, forKey: .audioCallUser) {
            self.audioCallUser = audioCallUser
        }
        if let agoraCall = try? container.decode(Bool.self, forKey: .agoraCall) {
            self.agoraCall = agoraCall
        }
        if let agoraCallData = try? container.decode(UserCallData.self, forKey: .agoraCallData) {
            self.agoraCallData = agoraCallData
        }
    }
}

/*
"video_call": false,
"video_call_user": [],
"audio_call": true,
"audio_call_user": {
    "data": {
        "id": "1321",
        "from_id": "188927",
        "to_id": "182951",
        "type": "audio",
        "room_name": "326611ed351630ebfb606fa56345b14b2ad6ed98",
        "time": "1661950152",
        "status": "calling",
        "active": "0",
        "called": "0",
        "declined": "0",
        "access_token": "",
        "access_token_2": null,
        "url": "https:\/\/demo.wowonder.com\/video-call\/326611ed351630ebfb606fa56345b14b2ad6ed98"
    },
    "user_id": "188927",
    "avatar": "https:\/\/wowonder.fra1.digitaloceanspaces.com\/upload\/photos\/d-avatar.jpg?cache=0",
    "name": "Test User 2"
},
"agora_call": true,
"agora_call_data": {
    "data": {
        "id": "1321",
        "from_id": "188927",
        "to_id": "182951",
        "type": "audio",
        "room_name": "326611ed351630ebfb606fa56345b14b2ad6ed98",
        "time": "1661950152",
        "status": "calling",
        "active": "0",
        "called": "0",
        "declined": "0",
        "access_token": "",
        "access_token_2": null
    },
    "user_id": "188927",
    "avatar": "https:\/\/wowonder.fra1.digitaloceanspaces.com\/upload\/photos\/d-avatar.jpg?cache=0",
    "name": "Test User 2"
}
*/
