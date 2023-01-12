//
//  MessagesExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 02/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Messages: CoreDataObject {
    
    static var fetcher: CoreDataFetcher<Messages> {
        get {
            return CoreDataFetcher<Messages>()
        }
    }
    
    convenience init(chat_id: Int32, message: MessageModel) {
        self.init(context: CoreDataManager.getInstance().context)
        self.chat_id = chat_id
        self.my_id = Messages.getMaxID() + 1
        self.setMessageModelToFields(message)
        self.created_at = Date()
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
    
    var _message_id: String {
        get {
            return self.message_id ?? ""
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
    
    var _to_id: String {
        get {
            return self.to_id ?? ""
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
    
    var _media_file_name: String {
        get {
            return self.media_file_name ?? ""
        }
    }
    
    var _time: String {
        get {
            return self.time ?? ""
        }
    }
    
    var date: Date? {
        get {
            guard let double = Double(self._time) else { return nil }
            return Date(timeIntervalSince1970: double)
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
    
    var _time_text: String {
        get {
            return self.time_text ?? ""
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
    
    var _typeObject: MessageTypes? {
        get {
            return MessageTypes(rawValue: self._type)
        }
    }
    
    var _file_size: String {
        get {
            return self.file_size ?? ""
        }
    }
    
    var _stickers: String {
        get {
            return self.stickers ?? ""
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
    
    var _date_time: Date {
        get {
            return self.date_time ?? Date()
        }
    }
    
    var _created_at: Date {
        get {
            return self.created_at ?? Date()
        }
    }
    
    func save() {
        self.setValue(message_id, forKey: #keyPath(Messages.message_id))
        self.setValue(from_id, forKey: #keyPath(Messages.from_id))
        self.setValue(group_id, forKey: #keyPath(Messages.group_id))
        self.setValue(page_id, forKey: #keyPath(Messages.page_id))
        self.setValue(to_id, forKey: #keyPath(Messages.to_id))
        self.setValue(text, forKey: #keyPath(Messages.text))
        self.setValue(media, forKey: #keyPath(Messages.media))
        self.setValue(media_file_name, forKey: #keyPath(Messages.media_file_name))
        self.setValue(time, forKey: #keyPath(Messages.time))
        self.setValue(seen, forKey: #keyPath(Messages.seen))
        self.setValue(deleted_one, forKey: #keyPath(Messages.deleted_one))
        self.setValue(deleted_two, forKey: #keyPath(Messages.deleted_two))
        self.setValue(product_id, forKey: #keyPath(Messages.product_id))
        self.setValue(lat, forKey: #keyPath(Messages.lat))
        self.setValue(lng, forKey: #keyPath(Messages.lng))
        self.setValue(reply_id, forKey: #keyPath(Messages.reply_id))
        self.setValue(story_id, forKey: #keyPath(Messages.story_id))
        self.setValue(pin, forKey: #keyPath(Messages.pin))
        self.setValue(fav, forKey: #keyPath(Messages.fav))
        self.setValue(time_text, forKey: #keyPath(Messages.time_text))
        self.setValue(position, forKey: #keyPath(Messages.position))
        self.setValue(type, forKey: #keyPath(Messages.type))
        self.setValue(file_size, forKey: #keyPath(Messages.file_size))
        self.setValue(stickers, forKey: #keyPath(Messages.stickers))
        self.setValue(chat_color, forKey: #keyPath(Messages.chat_color))
        self.setValue(hash_id, forKey: #keyPath(Messages.hash_id))
        self.setValue(is_favourite, forKey: #keyPath(Messages.is_favourite))
        self.setValue(created_at, forKey: #keyPath(Messages.created_at))
        self.setValue(date_time, forKey: #keyPath(Messages.date_time))
        
        do {
            if self.managedObjectContext!.hasChanges {
                try self.managedObjectContext!.save()
            }
        } catch let err {
            print("ERROR \(err.localizedDescription)")
        }
    }
    
    func updateMessage(message: MessageModel) {
        self.setMessageModelToFields(message)
        self.save()
    }
    
    func updateMessage(message: SendMessageModel) {
        self.message_id = message._id
        self.from_id = message._fromID
        self.group_id = message._groupID
        self.page_id = message._pageID
        self.to_id = message._toID
        self.text = message._text
        self.media = message.media
        self.media_file_name = message._mediaFileName
        self.time = message._time
        self.seen = message._seen
        self.deleted_one = message._deletedOne
        self.deleted_two = message._deletedTwo
        self.product_id = message._productID
        self.lat = message._lat
        self.lng = message._lng
        self.reply_id = message._replyID
        self.story_id = message._storyID
        self.time_text = message._timeText
        self.position = message._position
        self.type = message._type
        self.stickers = message._stickers
        
        if let double = Double(message._time) {
            self.date_time = Date(timeIntervalSince1970: double)
            self.my_time = Int64(double)
        }
        
        if let size = message.fileSize {
            self.file_size = "\(size)"
        }
        
        self.save()
    }
    
    func setMessageModelToFields(_ message: MessageModel) {
        self.message_id = message._id
        self.from_id = message._from_id
        self.group_id = message._group_id
        self.page_id = message._page_id
        self.to_id = message._toID
        self.text = message._text
        self.media = message.media
        self.media_file_name = message._mediaFileName
        self.time = message._time
        self.seen = message._seen
        self.deleted_one = message._deleted_one
        self.deleted_two = message._deleted_two
        self.product_id = message._product_id
        self.lat = message._lat
        self.lng = message._lng
        self.reply_id = message._reply_id
        self.story_id = message._story_id
        self.pin = message._pin
        self.fav = message._fav
        self.time_text = message._timeText
        self.position = message._position
        self.type = message._type
        self.stickers = message._stickers
        self.chat_color = message._chat_color
        self.hash_id = message._hash_id
        
        if let double = Double(message._time) {
            self.date_time = Date(timeIntervalSince1970: double)
            self.my_time = Int64(double)
        }
        
        if let size = message.file_size {
            self.file_size = size
        }
    }
    
    func getMessageByReplyID() -> Messages? {
        guard !self._reply_id.isEmpty && self._reply_id != "0" else { return nil }
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Messages.message_id), self._reply_id)
        return Self.fetcher.fetchResults(limit: 1, predicate: predicate).first
    }
    
    func getMessageByHashID() -> Messages? {
        guard !self._hash_id.isEmpty && self._hash_id != "0" else { return nil }
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Messages.hash_id), self._hash_id)
        return Self.fetcher.fetchResults(limit: 1, predicate: predicate).first
    }
}

extension Messages {
    
    @discardableResult
    static func saveMessages(chatID: Int32, _ messages: [MessageModel]) -> [Messages] {
        var msgs = [Messages]()
        
        for message in messages {
            let localMessage = Messages(chat_id: chatID, message: message)
            guard !isMessageExists(localMessage) else { continue }
            localMessage.save()
            msgs.append(localMessage)
        }
        
        return msgs.sorted(by: { $0.my_time < $1.my_time })
    }
    
    static func isMessageExists(_ message: Messages) -> Bool {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Messages.message_id), message._message_id)
        let result = fetcher.fetchResults(limit: 1, predicate: predicate)
        return !result.isEmpty
    }
    
    static func getFavouriteMessage() -> [Messages] {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Messages.is_favourite), true)
        return fetcher.fetchResults(predicate: predicate)
    }
    
    static func getMessageByHashID(_ id: String) -> Messages? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Messages.hash_id), id)
        return fetcher.fetchResults(limit: 1, predicate: predicate).first
    }
    
    static func getMessageByID(_ id: String) -> Messages? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Messages.message_id), id)
        return fetcher.fetchResults(limit: 1, predicate: predicate).first
    }
    
    static func getLastMessagesByChatID(_ id: Int32, limit: Int = 50, ascending: Bool = true) -> [Messages] {
        let predicate = NSPredicate(format: "%K == %d", #keyPath(Messages.chat_id), id)
        let sortSortDescriptor = NSSortDescriptor(key: #keyPath(Messages.my_time), ascending: ascending)
        
        return fetcher.fetchResults(limit: limit,
                                    predicate: predicate,
                                    sortDescriptors: [sortSortDescriptor])
    }
    
    static func getMessagesByChatID(_ id: Int32, limit: Int = 50) -> [Messages] {
        let predicate = NSPredicate(format: "%K == %d", #keyPath(Messages.chat_id), id)
        let sortSortDescriptor = NSSortDescriptor(key: #keyPath(Messages.date_time), ascending: true)
        return fetcher.fetchResults(limit: limit,
                                    predicate: predicate,
                                    sortDescriptors: [sortSortDescriptor])
    }
    
    static func getMaxID() -> Int32 {
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Chats.my_id), ascending: false)
        let results = fetcher.fetchResults(limit: 1, sortDescriptors: [sortDescriptor])
        return results.first?.my_id ?? 0
    }
}

extension Date: CVarArg {
    
}
