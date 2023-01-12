//
//  Stack.swift
//  Core Data Best Practices
//
//  Created by Antoine van der Lee on 05/11/2020.
//

import Foundation
import CoreData

final class PersistentContainer: NSPersistentContainer {

//    static let shared = PersistentContainer(name: "WoWonder")
    static let shared = PersistentContainer(name: "Database")

//    private var persistentHistoryObserver: PersistentHistoryObserver?

    func setup() {
//        registerValueTransformers()
//        enablePersistentHistoryTracking()

        loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy

//        persistentHistoryObserver = startObservingPersistentHistoryTransactions()
    }

    /// A convenience method for creating background contexts that specify the app as their transaction author.
    /// It's best practice to perform heavy lifting on a background context.
    ///
    /// - Returns: The background context configured with a name and transaction author.
    override func newBackgroundContext() -> NSManagedObjectContext {
        let context = super.newBackgroundContext()
        context.name = "background_context"
        context.transactionAuthor = "main_app_background_context"
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}

/// Defines a convenience class for `NSManagedObject` types to add common methods and remove boilerplate code.
public protocol Managed: NSFetchRequestResult {
    static var entityName: String { get }
}

extension NSManagedObject: Managed { }

public extension Managed where Self: NSManagedObject {
    /// Returns a `String` of the entity name.
    static var entityName: String { return String(describing: self) }
    
    /// Creates a `NSFetchRequest` which can be used to fetch data of this type.
    static var fetchDataRequest: NSFetchRequest<Self> {
        return NSFetchRequest<Self>(entityName: entityName)
    }
    
    static func resultController(_ context: NSManagedObjectContext, predicate: NSPredicate, sort: [NSSortDescriptor]) -> NSFetchedResultsController<Self> {
        
        let request = fetchDataRequest
        request.predicate = predicate
        request.sortDescriptors = sort
        
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
}
