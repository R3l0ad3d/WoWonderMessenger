//
//  GetFriendRequestModal.swift
//  WoWonder
//
//  Created by Ubaid Javaid on 7/17/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import Foundation

class GetFriendRequestModal: BaseVC{
    
    struct getFirend_RequestSuccessModal{
        var api_status: Int
        var friend_requests: [[String:Any]]
        init(json:[String:Any]) {
            let api_status = json["api_status"] as? Int
            let friend_requests = json["friend_requests"] as? [[String:Any]]
            self.api_status = api_status ?? 0
            self.friend_requests = friend_requests ?? [["id":"1312423"]]
        }
    }
    
    struct getFirend_Request_ErrorModel : Codable {
          let apiStatus: String
          let errors: Errors
          enum CodingKeys: String, CodingKey {
              case apiStatus = "api_status"
              case errors
          }
          
      }
      
      // MARK: - Errors
      struct Errors: Codable {
          let errorID: Int
          let errorText: String
          
          enum CodingKeys: String, CodingKey {
              case errorID = "error_id"
              case errorText = "error_text"
          }
      }
}

