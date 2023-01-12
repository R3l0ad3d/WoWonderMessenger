//
//  CoreDataFetcher.swift
//  CoreDataApp
//
//  Created by Mohammed Hamad on 10/03/2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataFetcher<Object: NSManagedObject & CoreDataObject> {
    
    private var manager: CoreDataManager
    private var context: NSManagedObjectContext
    
    public init() {
        self.manager = CoreDataManager.getInstance()
        self.context = self.manager.context
    }
    
    public func save(_ object: Object) {
        object.save()
    }
    
    @discardableResult
    public func insert(_ object: Object) -> Bool {
        do {
            self.context.insert(object)
            try self.context.saveIfNeeded()
            return true
            
        } catch let err {
            print("ERROR \(#function) \(err.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    public func delete(_ object: Object) -> Bool {
        do {
            self.context.delete(object)
            try self.context.saveIfNeeded()
            return true
            
        } catch let err {
            print("ERROR \(#function) \(err.localizedDescription)")
            return false
        }
    }
    
    /**
     Check object if exists in database...
     
     - parameter NSManagedObject.
     - returns: object if exists
     - warning: No Warning
     
     # Notes: #
     1.
     
     # Example #
     ```
     // isExists(user)
     ```
     */
    
    public func isExists(_ objectID: NSManagedObjectID) -> Bool {
        return self.fetchResults().filter({ $0.objectID == objectID }).first != nil
    }
    
    public func fetchResults(limit: Int = -1, offset: Int? = nil, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [Object] {
        do {
            let request = Object.fetchDataRequest
            if limit > 0 {
                request.fetchLimit = limit
            }
            if let offset = offset {
                request.fetchOffset = offset
            }
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            
            let results = try self.context.fetch(request)
            return results
            
        } catch let err {
            print("ERROR \(#function) \(err.localizedDescription)")
            return []
        }
    }
}
