//
//  ChatsExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 02/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Chats: CoreDataObject {
    
    private static var fetcher: CoreDataFetcher<Chats> {
        get {
            return CoreDataFetcher<Chats>()
        }
    }
    
    /// Custom Init
    convenience init(user: UserModel) {
        self.init(context: CoreDataManager.getInstance().context)
        self.my_id = Chats.getMaxID() + 1
        self.avatar_url = user.avatar ?? ""
        
        if let username = user.name {
            self.name = username
        }
        
        self.created_at = Date()
        
        let chatUser = ChatUsers(chat_id: self.my_id, user_id: user._userID)
        
        let userModel = Users(user: user)
        chatUser.user = userModel
        
        if let lastMsg = user.lastMessage,
           let msg = Messages.getMessageByID(lastMsg._id) {
            userModel.last_message = msg
        }
        
        self.addToChat_user(chatUser)
    }
    
    var _name: String {
        get {
            return self.name ?? ""
        }
    }
    
    func save() {
        self.setValue(my_id, forKey: #keyPath(Chats.my_id))
        self.setValue(name, forKey: #keyPath(Chats.name))
        
        do {
            try self.managedObjectContext!.save()
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
    
    public func getFirstChatUser() -> ChatUsers? {
        return self.getChatUsers().first
    }
    
    public func getChatUsers() -> [ChatUsers] {
        return chat_user?.map({ object in
            return object as! ChatUsers
        }) ?? []
    }
    
    public func getMessages() -> [Messages] {
        return (messages?.map({ object in
            return object as! Messages
        }) ?? []).sorted(by: { $0.my_time < $1.my_time })
    }
}

extension Chats {
    
    static func getChats() -> [Chats] {
        return fetcher.fetchResults().sorted { chat1, chat2 in
            return chat1.getMessages().last?.my_time ?? 0 > chat2.getMessages().last?.user?.last_message?.my_time ?? 0
        }
    }
    
    static func getChatByID(my_id: Int32) -> Chats? {
        let predicate = NSPredicate(format: "%K == %d", #keyPath(Chats.my_id), my_id)
        let result = fetcher.fetchResults(limit: 1,
                                          predicate: predicate)
        return result.first
    }
    
    static func getChatByUserID(_ userID: String) -> Chats? {
        return ChatUsers.getChatUserByUserID(userID)?.chat
    }
    
    static func getMaxID() -> Int32 {
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Chats.my_id), ascending: false)
        let results = fetcher.fetchResults(limit: 1, sortDescriptors: [sortDescriptor])
        return results.first?.my_id ?? 0
    }
}
