//
//  
//  GetGeneralData.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

// MARK: - UserResponse
struct GeneralDataResponse: Codable {
    var apiStatus: Int?
    var notifications: [NotificationModel]?
    var newNotificationsCount: String?
//    var friendRequests: [JSONAny]?
    var newFriendRequestsCount: String?
//    var groupChatRequests: [JSONAny]?
    var newGroupChatRequestsCount: Int?
    var countNewMessages: String?
    var announcement: Bool?
    
    enum CodingKeys: String, CodingKey {
        case apiStatus = "api_status"
        case notifications
        case newNotificationsCount = "new_notifications_count"
//        case friendRequests = "friend_requests"
        case newFriendRequestsCount = "new_friend_requests_count"
//        case groupChatRequests = "group_chat_requests"
        case newGroupChatRequestsCount = "new_group_chat_requests_count"
        case countNewMessages = "count_new_messages"
        case announcement
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let apiStatus = try? container.decode(Int.self, forKey: .apiStatus) {
            self.apiStatus = apiStatus
        }
        if let notifications = try? container.decode([NotificationModel].self, forKey: .notifications) {
            self.notifications = notifications
        }
        if let newNotificationsCount = try? container.decode(String.self, forKey: .newNotificationsCount) {
            self.newNotificationsCount = newNotificationsCount
        }
        if let newFriendRequestsCount = try? container.decode(String.self, forKey: .newFriendRequestsCount) {
            self.newFriendRequestsCount = newFriendRequestsCount
        }
        if let newGroupChatRequestsCount = try? container.decode(Int.self, forKey: .newGroupChatRequestsCount) {
            self.newGroupChatRequestsCount = newGroupChatRequestsCount
        }
        if let countNewMessages = try? container.decode(String.self, forKey: .countNewMessages) {
            self.countNewMessages = countNewMessages
        }
        if let announcement = try? container.decode(Bool.self, forKey: .announcement) {
            self.announcement = announcement
        }
    }
}
