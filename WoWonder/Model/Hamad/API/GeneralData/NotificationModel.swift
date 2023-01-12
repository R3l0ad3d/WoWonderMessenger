//
//  
//  NotificationModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct NotificationModel: Codable {
    var id: String?
    var notifierID: String?
    var recipientID: String?
    var postID: String?
    var replyID: String?
    var commentID: String?
    var pageID: String?
    var groupID: String?
    var groupChatID: String?
    var eventID: String?
    var threadID: String?
    var blogID: String?
    var storyID: String?
    var seenPop: String?
    var type: String?
    var type2: String?
    var text: String?
    var url: String?
    var fullLink: String?
    var seen: String?
    var sentPush: String?
    var admin: String?
    var time: String?
    var notifier: UserModel?
    var ajaxURL: String?
    var typeText: String?
    var icon: String?
    var timeTextString: String?
    var timeText: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case notifierID = "notifier_id"
        case recipientID = "recipient_id"
        case postID = "post_id"
        case replyID = "reply_id"
        case commentID = "comment_id"
        case pageID = "page_id"
        case groupID = "group_id"
        case groupChatID = "group_chat_id"
        case eventID = "event_id"
        case threadID = "thread_id"
        case blogID = "blog_id"
        case storyID = "story_id"
        case seenPop = "seen_pop"
        case type, type2, text, url
        case fullLink = "full_link"
        case seen
        case sentPush = "sent_push"
        case admin, time, notifier
        case ajaxURL = "ajax_url"
        case typeText = "type_text"
        case icon
        case timeTextString = "time_text_string"
        case timeText = "time_text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let notifierID = try? container.decode(String.self, forKey: .notifierID) {
            self.notifierID = notifierID
        }
        if let recipientID = try? container.decode(String.self, forKey: .recipientID) {
            self.recipientID = recipientID
        }
        if let postID = try? container.decode(String.self, forKey: .postID) {
            self.postID = postID
        }
        if let replyID = try? container.decode(String.self, forKey: .replyID) {
            self.replyID = replyID
        }
        if let commentID = try? container.decode(String.self, forKey: .commentID) {
            self.commentID = commentID
        }
        if let pageID = try? container.decode(String.self, forKey: .pageID) {
            self.pageID = pageID
        }
        if let groupID = try? container.decode(String.self, forKey: .groupID) {
            self.groupID = groupID
        }
        if let groupChatID = try? container.decode(String.self, forKey: .groupChatID) {
            self.groupChatID = groupChatID
        }
        if let eventID = try? container.decode(String.self, forKey: .eventID) {
            self.eventID = eventID
        }
        if let threadID = try? container.decode(String.self, forKey: .threadID) {
            self.threadID = threadID
        }
        if let blogID = try? container.decode(String.self, forKey: .blogID) {
            self.blogID = blogID
        }
        if let storyID = try? container.decode(String.self, forKey: .storyID) {
            self.storyID = storyID
        }
        if let seenPop = try? container.decode(String.self, forKey: .seenPop) {
            self.seenPop = seenPop
        }
        if let type = try? container.decode(String.self, forKey: .type) {
            self.type = type
        }
        if let type2 = try? container.decode(String.self, forKey: .type2) {
            self.type2 = type2
        }
        if let text = try? container.decode(String.self, forKey: .text) {
            self.text = text
        }
        if let url = try? container.decode(String.self, forKey: .url) {
            self.url = url
        }
        if let fullLink = try? container.decode(String.self, forKey: .fullLink) {
            self.fullLink = fullLink
        }
        if let seen = try? container.decode(String.self, forKey: .seen) {
            self.seen = seen
        }
        if let sentPush = try? container.decode(String.self, forKey: .sentPush) {
            self.sentPush = sentPush
        }
        if let admin = try? container.decode(String.self, forKey: .admin) {
            self.admin = admin
        }
        if let time = try? container.decode(String.self, forKey: .time) {
            self.time = time
        }
        if let notifier = try? container.decode(UserModel.self, forKey: .notifier) {
            self.notifier = notifier
        }
        if let ajaxURL = try? container.decode(String.self, forKey: .ajaxURL) {
            self.ajaxURL = ajaxURL
        }
        if let typeText = try? container.decode(String.self, forKey: .typeText) {
            self.typeText = typeText
        }
        if let icon = try? container.decode(String.self, forKey: .icon) {
            self.icon = icon
        }
        if let timeTextString = try? container.decode(String.self, forKey: .timeTextString) {
            self.timeTextString = timeTextString
        }
        if let timeText = try? container.decode(String.self, forKey: .timeText) {
            self.timeText = timeText
        }
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
    }
}
