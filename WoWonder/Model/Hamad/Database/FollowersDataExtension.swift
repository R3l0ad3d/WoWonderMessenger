//
//  FollowersDataExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension FollowersData: CoreDataObject {
    
    convenience init(userID: String, follower_user_id: String) {
        self.init(context: CoreDataManager.getInstance().context)
        self.user_id = userID
        self.follower_user_id = follower_user_id
    }
    
    func save() {
        self.setValue(user_id, forKey: #keyPath(FollowersData.user_id))
        self.setValue(follower_user_id, forKey: #keyPath(FollowersData.follower_user_id))
        
        do {
            try self.managedObjectContext!.save()
            
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
}
