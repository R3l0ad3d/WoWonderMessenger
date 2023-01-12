//
//  
//  ReplyModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct ReplyModel : Codable {
    
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
    var reaction: MessageReaction?
    var pin: String?
    var fav: String?
    var timeText: String?
    var position: String?
    var type: String?
    var product: MessageProductModel?
    var fileSize: Int?
    
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
        case onwer, reaction, pin, fav
        case timeText = "time_text"
        case position, type, product
        case fileSize = "file_size"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let fromID = try? container.decode(String.self, forKey: .id) {
            self.fromID = fromID
        }
        if let groupID = try? container.decode(String.self, forKey: .id) {
            self.groupID = groupID
        }
        if let pageID = try? container.decode(String.self, forKey: .id) {
            self.pageID = pageID
        }
        if let toID = try? container.decode(String.self, forKey: .id) {
            self.toID = toID
        }
        if let text = try? container.decode(String.self, forKey: .id) {
            self.text = text
        }
        if let media = try? container.decode(String.self, forKey: .id) {
            self.media = media
        }
        if let mediaFileName = try? container.decode(String.self, forKey: .id) {
            self.mediaFileName = mediaFileName
        }
        if let mediaFileNames = try? container.decode(String.self, forKey: .id) {
            self.mediaFileNames = mediaFileNames
        }
        if let time = try? container.decode(String.self, forKey: .id) {
            self.time = time
        }
        if let seen = try? container.decode(String.self, forKey: .id) {
            self.seen = seen
        }
        if let deletedOne = try? container.decode(String.self, forKey: .id) {
            self.deletedOne = deletedOne
        }
        if let deletedTwo = try? container.decode(String.self, forKey: .id) {
            self.deletedTwo = deletedTwo
        }
        if let sentPush = try? container.decode(String.self, forKey: .id) {
            self.sentPush = sentPush
        }
        if let notificationID = try? container.decode(String.self, forKey: .id) {
            self.notificationID = notificationID
        }
        if let typeTwo = try? container.decode(String.self, forKey: .id) {
            self.typeTwo = typeTwo
        }
        if let stickers = try? container.decode(String.self, forKey: .id) {
            self.stickers = stickers
        }
        if let productID = try? container.decode(String.self, forKey: .id) {
            self.productID = productID
        }
        if let lat = try? container.decode(String.self, forKey: .id) {
            self.lat = lat
        }
        if let lng = try? container.decode(String.self, forKey: .id) {
            self.lng = lng
        }
        if let replyID = try? container.decode(String.self, forKey: .id) {
            self.replyID = replyID
        }
        if let storyID = try? container.decode(String.self, forKey: .id) {
            self.storyID = storyID
        }
        if let broadcastID = try? container.decode(String.self, forKey: .id) {
            self.broadcastID = broadcastID
        }
        if let forward = try? container.decode(String.self, forKey: .id) {
            self.forward = forward
        }
        if let listening = try? container.decode(String.self, forKey: .id) {
            self.listening = listening
        }
        if let messageUser = try? container.decode(UserModel.self, forKey: .id) {
            self.messageUser = messageUser
        }
        if let orText = try? container.decode(String.self, forKey: .id) {
            self.orText = orText
        }
        if let onwer = try? container.decode(Int.self, forKey: .id) {
            self.onwer = onwer
        }
        if let reaction = try? container.decode(MessageReaction.self, forKey: .id) {
            self.reaction = reaction
        }
        if let pin = try? container.decode(String.self, forKey: .id) {
            self.pin = pin
        }
        if let fav = try? container.decode(String.self, forKey: .id) {
            self.fav = fav
        }
        if let timeText = try? container.decode(String.self, forKey: .id) {
            self.timeText = timeText
        }
        if let position = try? container.decode(String.self, forKey: .id) {
            self.position = position
        }
        if let type = try? container.decode(String.self, forKey: .id) {
            self.type = type
        }
        if let product = try? container.decode(MessageProductModel.self, forKey: .id) {
            self.product = product
        }
        if let fileSize = try? container.decode(Int.self, forKey: .id) {
            self.fileSize = fileSize
        }
    }
}
