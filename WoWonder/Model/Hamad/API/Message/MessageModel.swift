//
//  MessageModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

struct MessageModel: Codable {
    
    var id: String?
    var from_id: String?
    var group_id: String?
    var page_id: String?
    var toID: String?
    var text: String?
    var media: String?
    var mediaFileName: String?
    var mediaFileNames: String?
    var time: String?
    var seen: String?
    var deleted_one: String?
    var deleted_two: String?
    var sent_push: String?
    var notification_id: String?
    var type_two: String?
    var stickers: String?
    var product_id: String?
    var lat: String?
    var lng: String?
    var reply_id: String?
    var story_id: String?
    var broadcast_id: String?
    var forward: String?
    var listening: String?
    var messageUser: UserModel?
    var pin: String?
    var fav: String?
    var reply: MessageReply?
    var story: [JSONAny]?
    var reaction: MessageReaction?
    var timeText: String?
    var position: String?
    var type: String?
    var product: MessageProductModel?
    var file_size: String?
    var chat_color: String?
    var hash_id: String?
    
    var _id: String {
        get {
            return self.id ?? ""
        }
    }
    
    var _from_id: String {
        get {
            return self.from_id ?? ""
        }
    }
    
    var _group_id: String {
        get {
            return self.group_id ?? ""
        }
    }
    
    var _page_id: String {
        get {
            return self.page_id ?? ""
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
    
    var _deleted_one: String {
        get {
            return self.deleted_one ?? ""
        }
    }
    
    var _deleted_two: String {
        get {
            return self.deleted_two ?? ""
        }
    }
    
    var _sent_push: String {
        get {
            return self.sent_push ?? ""
        }
    }
    
    var _notification_id: String {
        get {
            return self.notification_id ?? ""
        }
    }
    
    var _type_two: String {
        get {
            return self.type_two ?? ""
        }
    }
    
    var _stickers: String {
        get {
            return self.stickers ?? ""
        }
    }
    
    var _product_id: String {
        get {
            return self.product_id ?? ""
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
    
    var _reply_id: String {
        get {
            return self.reply_id ?? ""
        }
    }
    
    var _story_id: String {
        get {
            return self.story_id ?? ""
        }
    }
    
    var _broadcast_id: String {
        get {
            return self.broadcast_id ?? ""
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
    
    var _pin: String {
        get {
            return self.pin ?? ""
        }
    }
    
    var _fav: String {
        get {
            return self.fav ?? ""
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
    
    var _chat_color: String {
        get {
            return self.chat_color ?? ""
        }
    }
    
    var _hash_id: String {
        get {
            return self.hash_id ?? ""
        }
    }
    
    var _file_size: String {
        get {
            return self.file_size ?? "0"
        }
    }
    
    enum MessageTypes: String, CaseIterable, Codable {
        case leftAudio = "left_audio"
        case rightAudio = "right_audio"
        case leftVideo = "left_video"
        case rightVideo = "right_video"
        case leftSticker = "left_sticker"
        case rightSticker = "right_sticker"
        case leftImage = "left_image"
        case rightImage = "right_image"
        case leftGif = "left_gif"
        case rightGif = "right_gif"
        case leftFile = "left_file"
        case rightFile = "right_file"
        case leftText = "left_text"
        case rightText = "right_text"
        case leftContact = "left_contact"
        case rightContact = "right_contact"
        case leftProduct = "left_product"
        case rightProduct = "right_product"
        case leftMap = "left_map"
        case rightMap = "right_map"
        case none = "None"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case from_id = "from_id"
        case group_id = "group_id"
        case page_id = "page_id"
        case toID = "to_id"
        case text, media, mediaFileName, mediaFileNames, time, seen
        case deleted_one = "deleted_one"
        case deleted_two = "deleted_two"
        case sent_push = "sent_push"
        case notification_id = "notification_id"
        case type_two = "type_two"
        case stickers
        case product_id = "product_id"
        case lat, lng
        case reply_id = "reply_id"
        case story_id = "story_id"
        case broadcast_id = "broadcast_id"
        case forward, listening, messageUser, pin, fav, reply, story, reaction
        case timeText = "time_text"
        case position, type, product
        case file_size = "file_size"
        case chat_color = "chat_color"
        case hash_id = "message_hash_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let from_id = try? container.decode(String.self, forKey: .from_id) {
            self.from_id = from_id
        }
        if let group_id = try? container.decode(String.self, forKey: .group_id) {
            self.group_id = group_id
        }
        if let page_id = try? container.decode(String.self, forKey: .page_id) {
            self.page_id = page_id
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
        if let deleted_one = try? container.decode(String.self, forKey: .deleted_one) {
            self.deleted_one = deleted_one
        }
        if let deleted_two = try? container.decode(String.self, forKey: .deleted_two) {
            self.deleted_two = deleted_two
        }
        if let sent_push = try? container.decode(String.self, forKey: .sent_push) {
            self.sent_push = sent_push
        }
        if let notification_id = try? container.decode(String.self, forKey: .notification_id) {
            self.notification_id = notification_id
        }
        if let type_two = try? container.decode(String.self, forKey: .type_two) {
            self.type_two = type_two
        }
        if let stickers = try? container.decode(String.self, forKey: .stickers) {
            self.stickers = stickers
        }
        if let product_id = try? container.decode(String.self, forKey: .product_id) {
            self.product_id = product_id
        }
        if let lat = try? container.decode(String.self, forKey: .lat) {
            self.lat = lat
        }
        if let lng = try? container.decode(String.self, forKey: .lng) {
            self.lng = lng
        }
        if let reply_id = try? container.decode(String.self, forKey: .reply_id) {
            self.reply_id = reply_id
        }
        if let story_id = try? container.decode(String.self, forKey: .story_id) {
            self.story_id = story_id
        }
        if let broadcast_id = try? container.decode(String.self, forKey: .broadcast_id) {
            self.broadcast_id = broadcast_id
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
        if let pin = try? container.decode(String.self, forKey: .pin) {
            self.pin = pin
        }
        if let fav = try? container.decode(String.self, forKey: .fav) {
            self.fav = fav
        }
        if let reply = try? container.decode(MessageReply.self, forKey: .reply) {
            self.reply = reply
        }
        if let story = try? container.decode([JSONAny].self, forKey: .story) {
            self.story = story
        }
        if let reaction = try? container.decode(MessageReaction.self, forKey: .reaction) {
            self.reaction = reaction
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
        if let product = try? container.decode(MessageProductModel.self, forKey: .product) {
            self.product = product
        }
        if let file_size = try? container.decode(String.self, forKey: .file_size) {
            self.file_size = file_size
        }
        if let chat_color = try? container.decode(String.self, forKey: .chat_color) {
            self.chat_color = chat_color
        }
        if let hash_id = try? container.decode(String.self, forKey: .hash_id) {
            self.hash_id = hash_id
        }
    }
    
    init(type: MessageTypes, hash_id: String, text: String, receipent_id: String, reply_id: String = "") {
        self.id = ""
        self.from_id = ""
        self.group_id = ""
        self.page_id = ""
        self.toID = receipent_id
        self.text = text
        self.media = ""
        self.mediaFileName = ""
        self.mediaFileNames = ""
        self.time = ""
        self.seen = ""
        self.deleted_one = ""
        self.deleted_two = ""
        self.sent_push = ""
        self.notification_id = ""
        self.type_two = ""
        self.stickers = ""
        self.product_id = ""
        self.reply_id = reply_id
        self.story_id = ""
        self.broadcast_id = ""
        self.forward = ""
        self.listening = ""
        self.messageUser = nil
        self.pin = ""
        self.fav = ""
        self.timeText = ""
        self.position = ""
        self.type = type.rawValue
        self.product = nil
        self.file_size = "0"
        self.hash_id = hash_id
    }
    
    init(sendMessage: SendMessageModel) {
        self.id = sendMessage._id
        self.from_id = sendMessage._fromID
        self.group_id = sendMessage._groupID
        self.page_id = sendMessage._pageID
        self.toID = sendMessage._toID
        self.text = sendMessage._text
        self.media = sendMessage._media
        self.mediaFileName = sendMessage._mediaFileName
        self.mediaFileNames = sendMessage._mediaFileNames
        self.time = sendMessage._time
        self.seen = sendMessage._seen
        self.deleted_one = sendMessage._deletedOne
        self.deleted_two = sendMessage._deletedTwo
        self.sent_push = sendMessage._sentPush
        self.notification_id = sendMessage._notificationID
        self.type_two = sendMessage._typeTwo
        self.stickers = sendMessage._stickers
        self.lat = sendMessage._lat
        self.lng = sendMessage._lng
        self.reply_id = sendMessage._replyID
        self.story_id = sendMessage._storyID
        self.broadcast_id = sendMessage._broadcastID
        self.forward = sendMessage._forward
        self.listening = sendMessage._listening
        self.messageUser = sendMessage.messageUser
        self.story = sendMessage._story
        self.timeText = sendMessage._timeText
        self.position = sendMessage._position
        self.type = sendMessage._type
        self.file_size = sendMessage._fileSize
        self.hash_id = sendMessage._messageHashID
    }
    
    init(lastMessage: LastMessage) {
        self.id = lastMessage._id
        self.from_id = lastMessage._fromID
        self.group_id = lastMessage._groupID
        self.page_id = lastMessage._pageID
        self.toID = lastMessage._toID
        self.text = lastMessage._text
        self.media = lastMessage._media
        self.mediaFileName = lastMessage._mediaFileName
        self.mediaFileNames = lastMessage._mediaFileNames
        self.time = lastMessage._time
        self.seen = lastMessage._seen
        self.deleted_one = lastMessage._deletedOne
        self.deleted_two = lastMessage._deletedTwo
        self.sent_push = lastMessage._sentPush
        self.notification_id = lastMessage._notificationID
        self.type_two = lastMessage._typeTwo
        self.stickers = lastMessage._stickers
        self.lat = lastMessage._lat
        self.lng = lastMessage._lng
        self.reply_id = lastMessage._replyID
        self.story_id = lastMessage._storyID
        self.broadcast_id = lastMessage._broadcastID
        self.forward = lastMessage._forward
        self.listening = lastMessage._listening
        if let user = lastMessage.messageUser {
            self.messageUser = UserModel(messageUser: user)
        }
        self.timeText = lastMessage._timeText
        self.position = lastMessage._position
        self.type = lastMessage._type
        self.file_size = lastMessage._fileSize
    }
}

struct MessageMedia {
    var media: String?
    var type: String?
}
