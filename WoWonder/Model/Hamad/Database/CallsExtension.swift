//
//  
//  CallsExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 10/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

extension Calls: CoreDataObject {
    
    private static var fetcher: CoreDataFetcher<Calls> {
        get {
            return CoreDataFetcher<Calls>()
        }
    }
    
    /// Custom Init
    convenience init(callID: String, userID: String, direction: Int16) {
        self.init(context: CoreDataManager.getInstance().context)
        self.my_id = Calls.getMaxID() + 1
        self.created_at = Date()
        
        self.user_id = userID
        self.call_id = callID
        self.direction = direction
    }
    
    var _call_id: String {
        get {
            return self.call_id ?? ""
        }
    }
    
    var _user_id: String {
        get {
            return self.user_id ?? ""
        }
    }
    
    var callType: CallType? {
        get {
            return CallType(rawValue: Int(self.type))
        }
    }
    
    var callDirection: CallDirection? {
        get {
            return CallDirection(rawValue: Int(self.direction))
        }
    }
    
    func save() {
//        self.setValue(my_id, forKey: #keyPath(Calls.my_id))
//        self.setValue(call_id, forKey: #keyPath(Calls.call_id))
//        self.setValue(user_id, forKey: #keyPath(Calls.user_id))
//        self.setValue(type, forKey: #keyPath(Calls.type))
//        self.setValue(time, forKey: #keyPath(Calls.time))
//        self.setValue(direction, forKey: #keyPath(Calls.direction))
//        self.setValue(created_at, forKey: #keyPath(Calls.created_at))
        
        do {
            if self.managedObjectContext!.hasChanges {
                try self.managedObjectContext!.save()
            }
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
    
    static func getCalls() -> [Calls] {
        return fetcher.fetchResults()
    }
    
    static func getCallByID(_ id: String) -> Calls? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Calls.call_id), id)
        let result = fetcher.fetchResults(limit: 1,
                                          predicate: predicate)
        return result.first
    }
    
    static func getMaxID() -> Int32 {
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Chats.my_id), ascending: false)
        let results = fetcher.fetchResults(limit: 1, sortDescriptors: [sortDescriptor])
        return results.first?.my_id ?? 0
    }
}
