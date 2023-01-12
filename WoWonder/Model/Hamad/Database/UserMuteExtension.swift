//
//  UserMuteExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 06/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UserMute: CoreDataObject {
    
    func save() {
        self.setValue(user_id, forKey: #keyPath(UserMute.user_id))
        self.setValue(notify, forKey: #keyPath(UserMute.notify))
        self.setValue(archive, forKey: #keyPath(UserMute.archive))
        self.setValue(fav, forKey: #keyPath(UserMute.fav))
        self.setValue(pin, forKey: #keyPath(UserMute.pin))
        self.setValue(call_chat, forKey: #keyPath(UserMute.call_chat))
        
        do {
            try self.managedObjectContext!.save()
            
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
}
