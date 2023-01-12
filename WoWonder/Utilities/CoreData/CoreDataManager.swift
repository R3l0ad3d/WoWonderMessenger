//
//  CoreDataManager.swift
//  CoreData
//
//  Created by Mohammed Hamad on 10/03/2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    private static var object: CoreDataManager!
    
    public static func getInstance() -> CoreDataManager {
        if object == nil {
            object = CoreDataManager()
        }
        return object
    }
    
    private var coreDataName: String
    
    private init() {
        self.coreDataName = "WoWonder"
    }
    
    public var persistentContainer: NSPersistentContainer {
        get {
//            return PersistentContainer.shared
            return AppDelegate.shared.persistentContainer
        }
    }
    
    public var context: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
}

extension UIViewController {
    
    var coreDataManager: CoreDataManager {
        get {
            return CoreDataManager.getInstance()
        }
    }
}
