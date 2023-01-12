//
//  UserChatsExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 02/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension ChatUsers: CoreDataObject {
    
    static var fetcher: CoreDataFetcher<ChatUsers> {
        get {
            return CoreDataFetcher<ChatUsers>()
        }
    }
    
    convenience init(chat_id: Int32, user_id: String) {
        self.init(context: CoreDataManager.getInstance().context)
        self.chat_id = chat_id
        self.user_id = user_id
    }
    
    var _user_id: String {
        get {
            return self.user_id ?? ""
        }
    }
    
    func save() {
        self.setValue(chat_id, forKey: #keyPath(ChatUsers.chat_id))
        self.setValue(user_id, forKey: #keyPath(ChatUsers.user_id))
        
        do {
            try self.managedObjectContext!.save()
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
    
    func getUser() -> Users? {
        guard self._user_id.isNotEmpty else { return nil }
        return Users.getUserByID(self._user_id)
    }
    
    func updateUser(_ userModel: UserModel) {
        self.user = Users(user: userModel)
//        print("User \(self.user?._last_seen ?? "") => \(userModel._lastseen)")
        self.save()
    }
}

extension ChatUsers {
    
    static func getChatUserByUserID(_ userId: String) -> ChatUsers? {
        let predicate = NSPredicate(format: "user_id == %@", userId)
        let result = fetcher.fetchResults(limit: 1,
                                          predicate: predicate)
        return result.first
    }
}
