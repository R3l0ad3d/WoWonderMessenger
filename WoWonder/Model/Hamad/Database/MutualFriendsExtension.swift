//
//  MutualFriendsExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MutualFriends: CoreDataObject {
    
    convenience init(userID: String, friendID: String) {
        self.init(context: CoreDataManager.getInstance().context)
        self.user_id = userID
        self.friend_id = friendID
    }
    
    func save() {
        self.setValue(user_id, forKey: #keyPath(MutualFriends.user_id))
        self.setValue(friend_id, forKey: #keyPath(MutualFriends.friend_id))
        
        do {
            try self.managedObjectContext!.save()
            
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
}
