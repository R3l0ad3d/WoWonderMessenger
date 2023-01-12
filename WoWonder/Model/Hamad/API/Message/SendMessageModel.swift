//
//  
//  SendMessageModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 13/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct SendMessageModel : Codable {
    var id: String?
    var fromID: String?
    var groupID: String?
    var pageID: String?
    var toID: String?
    var text: String?
    var media: String?
    var mediaFileName: String?
    var mediaFileNames: String?
    var time: String?
    var seen: String?
    var deletedOne: String?
    var deletedTwo: String?
    var sentPush: String?
    var notificationID: String?
    var typeTwo: String?
    var stickers: String?
    var productID: String?
    var lat: String?
    var lng: String?
    var replyID: String?
    var storyID: String?
    var broadcastID: String?
    var forward: String?
    var listening: String?
    var messageUser: UserModel?
    var orText: String?
    var onwer: Int?
    var reply: MessageReply?
    var story: [JSONAny]?
    var timeText: String?
    var position: String?
    var type: String?
    var fileSize: String?
    var messageHashID: String?
    
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
    
    var _groupID: String {
        get {
            return self.groupID ?? ""
        }
    }
    
    var _pageID: String {
        get {
            return self.pageID ?? ""
        }
    }
    
    var _toID: String {
        get {
            return self.toID ?? ""
        }
    }
    
    var _text: String {
        get {
            return self.text ?? ""
        }
    }
    
    var _media: String {
        get {
            return self.media ?? ""
        }
    }
    
    var _mediaFileName: String {
        get {
            return self.mediaFileName ?? ""
        }
    }
    
    var _mediaFileNames: String {
        get {
            return self.mediaFileNames ?? ""
        }
    }
    
    var _time: String {
        get {
            return self.time ?? ""
        }
    }
    
    var _seen: String {
        get {
            return self.seen ?? ""
        }
    }
    
    var _deletedOne: String {
        get {
            return self.deletedOne ?? ""
        }
    }
    
    var _deletedTwo: String {
        get {
            return self.deletedTwo ?? ""
        }
    }
    
    var _sentPush: String {
        get {
            return self.sentPush ?? ""
        }
    }
    
    var _notificationID: String {
        get {
            return self.notificationID ?? ""
        }
    }
    
    var _typeTwo: String {
        get {
            return self.typeTwo ?? ""
        }
    }
    
    var _stickers: String {
        get {
            return self.stickers ?? ""
        }
    }
    
    var _productID: String {
        get {
            return self.productID ?? ""
        }
    }
    
    var _lat: String {
        get {
            return self.lat ?? ""
        }
    }
    
    var _lng: String {
        get {
            return self.lng ?? ""
        }
    }
    
    var _replyID: String {
        get {
            return self.replyID ?? ""
        }
    }
    
    var _storyID: String {
        get {
            return self.storyID ?? ""
        }
    }
    
    var _broadcastID: String {
        get {
            return self.broadcastID ?? ""
        }
    }
    
    var _forward: String {
        get {
            return self.forward ?? ""
        }
    }
    
    var _listening: String {
        get {
            return self.listening ?? ""
        }
    }
    
    var _orText: String {
        get {
            return self.orText ?? ""
        }
    }
    
    var _onwer: Int {
        get {
            return self.onwer ?? 0
        }
    }
    
    var _story: [JSONAny] {
        get {
            return self.story ?? []
        }
    }
    
    var _timeText: String {
        get {
            return self.timeText ?? ""
        }
    }
    
    var _position: String {
        get {
            return self.position ?? ""
        }
    }
    
    var _type: String {
        get {
            return self.type ?? ""
        }
    }
    
    var _fileSize: String {
        get {
            return self.fileSize ?? "0"
        }
    }
    
    var _messageHashID: String {
        get {
            return self.messageHashID ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case groupID = "group_id"
        case pageID = "page_id"
        case toID = "to_id"
        case text, media, mediaFileName, mediaFileNames, time, seen
        case deletedOne = "deleted_one"
        case deletedTwo = "deleted_two"
        case sentPush = "sent_push"
        case notificationID = "notification_id"
        case typeTwo = "type_two"
        case stickers
        case productID = "product_id"
        case lat, lng
        case replyID = "reply_id"
        case storyID = "story_id"
        case broadcastID = "broadcast_id"
        case forward, listening, messageUser
        case orText = "or_text"
        case onwer, reply, story
        case timeText = "time_text"
        case position, type
        case fileSize = "file_size"
        case messageHashID = "message_hash_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let fromID = try? container.decode(String.self, forKey: .fromID) {
            self.fromID = fromID
        }
        if let groupID = try? container.decode(String.self, forKey: .groupID) {
            self.groupID = groupID
        }
        if let pageID = try? container.decode(String.self, forKey: .pageID) {
            self.pageID = pageID
        }
        if let toID = try? container.decode(String.self, forKey: .toID) {
            self.toID = toID
        }
        if let text = try? container.decode(String.self, forKey: .text) {
            self.text = text
        }
        if let media = try? container.decode(String.self, forKey: .media) {
            self.media = media
        }
        if let mediaFileName = try? container.decode(String.self, forKey: .mediaFileName) {
            self.mediaFileName = mediaFileName
        }
        if let mediaFileNames = try? container.decode(String.self, forKey: .mediaFileNames) {
            self.mediaFileNames = mediaFileNames
        }
        if let time = try? container.decode(String.self, forKey: .time) {
            self.time = time
        }
        if let seen = try? container.decode(String.self, forKey: .seen) {
            self.seen = seen
        }
        if let deletedOne = try? container.decode(String.self, forKey: .deletedOne) {
            self.deletedOne = deletedOne
        }
        if let deletedTwo = try? container.decode(String.self, forKey: .deletedTwo) {
            self.deletedTwo = deletedTwo
        }
        if let sentPush = try? container.decode(String.self, forKey: .sentPush) {
            self.sentPush = sentPush
        }
        if let notificationID = try? container.decode(String.self, forKey: .notificationID) {
            self.notificationID = notificationID
        }
        if let typeTwo = try? container.decode(String.self, forKey: .typeTwo) {
            self.typeTwo = typeTwo
        }
        if let stickers = try? container.decode(String.self, forKey: .stickers) {
            self.stickers = stickers
        }
        if let productID = try? container.decode(String.self, forKey: .productID) {
            self.productID = productID
        }
        if let lat = try? container.decode(String.self, forKey: .lat) {
            self.lat = lat
        }
        if let lng = try? container.decode(String.self, forKey: .lng) {
            self.lng = lng
        }
        if let replyID = try? container.decode(String.self, forKey: .replyID) {
            self.replyID = replyID
        }
        if let storyID = try? container.decode(String.self, forKey: .storyID) {
            self.storyID = storyID
        }
        if let broadcastID = try? container.decode(String.self, forKey: .broadcastID) {
            self.broadcastID = broadcastID
        }
        if let forward = try? container.decode(String.self, forKey: .forward) {
            self.forward = forward
        }
        if let listening = try? container.decode(String.self, forKey: .listening) {
            self.listening = listening
        }
        if let messageUser = try? container.decode(UserModel.self, forKey: .messageUser) {
            self.messageUser = messageUser
        }
        if let orText = try? container.decode(String.self, forKey: .orText) {
            self.orText = orText
        }
        if let onwer = try? container.decode(Int.self, forKey: .onwer) {
            self.onwer = onwer
        }
        if let reply = try? container.decode(MessageReply.self, forKey: .reply) {
            self.reply = reply
        }
        if let story = try? container.decode([JSONAny].self, forKey: .story) {
            self.story = story
        }
        if let timeText = try? container.decode(String.self, forKey: .timeText) {
            self.timeText = timeText
        }
        if let position = try? container.decode(String.self, forKey: .position) {
            self.position = position
        }
        if let type = try? container.decode(String.self, forKey: .type) {
            self.type = type
        }
        if let fileSize = try? container.decode(String.self, forKey: .fileSize) {
            self.fileSize = fileSize
        }
        if let messageHashID = try? container.decode(String.self, forKey: .messageHashID) {
            self.messageHashID = messageHashID
        }
    }
}
