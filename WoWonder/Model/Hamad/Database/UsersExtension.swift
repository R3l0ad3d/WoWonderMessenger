//
//  UsersExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 02/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Users: CoreDataObject {
    
    private static var fetcher: CoreDataFetcher<Users> {
        get {
            return CoreDataFetcher<Users>()
        }
    }
    
    convenience init(user: UserModel) {
        self.init(context: CoreDataManager.getInstance().context)
        self.gender = user._gender
        self.password = user._password
        self.message_count = user._messageCount
        self.lng = user._lng
        self.lat = user._lat
        self.last_seen_status = user._lastSeenStatus
        self.show_last_seen = user._showlastseen
        self.ip_address = user._ipAddress
        self.email = user._email
        self.cover_url = user._cover
        self.chat_type = user._chatType
        self.chat_time = user._chatTime
        self.name = user._name
        self.last_seen = user._lastseen
        self.last_name = user._lastName
        self.first_name = user._firstName
        self.username = user._username
        self.avatar_url = user._avatar
        self.user_id = user._userID
        self.last_message_id = user.lastMessage?.id
        self.my_id = Users.getMaxID() + 1
        
//        if let lastMessage = user.lastMessage {
//            self.last_message = Messages(chat_id: chat_id, message: lastMessage)
//        }
        
//        self.addToMututal_friends(NSSet(
//            array: user._mutualFriendsData.map({
//                return MutualFriends(userID: user._userID, friendID: $0)
//            })
//        ))
        
//        self.addToFollowings(NSSet(
//            array: user._followingData.map({
//                return FollowingsData(userID: user._userID, following_user_id: $0)
//            })
//        ))
        
//        self.addToFollowers(NSSet(
//            array: user._followersData.map({
//                return FollowersData(userID: user._userID, follower_user_id: $0)
//            })
//        ))
    }
    
    var _gender: String {
        get {
            return self.gender ?? ""
        }
    }
    
    var _message_count: String {
        get {
            return self.message_count ?? ""
        }
    }
    
    var _lng: String {
        get {
            return self.lng ?? ""
        }
    }
    
    var _lat: String {
        get {
            return self.lat ?? ""
        }
    }
    
    var _last_seen_status: String {
        get {
            return self.last_seen_status ?? ""
        }
    }
    
    var _show_last_seen: String {
        get {
            return self.show_last_seen ?? ""
        }
    }
    
    var _ip_address: String {
        get {
            return self.ip_address ?? ""
        }
    }
    
    var _email: String {
        get {
            return self.email ?? ""
        }
    }
    
    var _cover_url: String {
        get {
            return self.cover_url ?? ""
        }
    }
    
    var _chat_type: String {
        get {
            return self.chat_type ?? ""
        }
    }
    
    var _chat_time: String {
        get {
            return self.chat_time ?? ""
        }
    }
    
    var _name: String {
        get {
            return self.name ?? ""
        }
    }
    
    var _last_seen: String {
        get {
            return self.last_seen ?? ""
        }
    }
    
    var _last_name: String {
        get {
            return self.last_name ?? ""
        }
    }
    
    var _first_name: String {
        get {
            return self.first_name ?? ""
        }
    }
    
    var _username: String {
        get {
            return self.username ?? ""
        }
    }
    
    var _avatar_url: String {
        get {
            return self.avatar_url ?? ""
        }
    }
    
    var _user_id: String {
        get {
            return self.user_id ?? ""
        }
    }
    
    func save() {
        self.setValue(gender, forKey: #keyPath(Users.gender))
        self.setValue(message_count, forKey: #keyPath(Users.message_count))
        self.setValue(lng, forKey: #keyPath(Users.lng))
        self.setValue(lat, forKey: #keyPath(Users.lat))
        self.setValue(last_seen_status, forKey: #keyPath(Users.last_seen_status))
        self.setValue(ip_address, forKey: #keyPath(Users.ip_address))
        self.setValue(email, forKey: #keyPath(Users.email))
        self.setValue(password, forKey: #keyPath(Users.password))
        self.setValue(cover_url, forKey: #keyPath(Users.cover_url))
        self.setValue(chat_type, forKey: #keyPath(Users.chat_type))
        self.setValue(chat_time, forKey: #keyPath(Users.chat_time))
        self.setValue(name, forKey: #keyPath(Users.name))
        self.setValue(last_seen, forKey: #keyPath(Users.last_seen))
        self.setValue(last_name, forKey: #keyPath(Users.last_name))
        self.setValue(first_name, forKey: #keyPath(Users.first_name))
        self.setValue(username, forKey: #keyPath(Users.username))
        self.setValue(avatar_url, forKey: #keyPath(Users.avatar_url))
        self.setValue(user_id, forKey: #keyPath(Users.user_id))
        self.setValue(my_id, forKey: #keyPath(Users.my_id))
        
        do {
            try self.managedObjectContext!.save()
            
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
    
    static func getUserByID(_ userId: String) -> Users? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Users.user_id), userId)
        let result = fetcher.fetchResults(limit: 1,
                                          predicate: predicate)
        return result.first
    }
    
    static func getMaxID() -> Int32 {
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Users.my_id), ascending: false)
        let results = fetcher.fetchResults(limit: 1, sortDescriptors: [sortDescriptor])
        return results.first?.my_id ?? 0
    }
}
