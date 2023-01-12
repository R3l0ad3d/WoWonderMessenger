//
//  CoreDataProtocols.swift
//  CoreDataApp
//
//  Created by Mohammed Hamad on 01/04/2021.
//

import Foundation
import UIKit
import CoreData

typealias CoreDataObject = CoreDataProtocol

protocol CoreDataProtocol: AnyObject {
    /// Update model in database
    func save()
//    func delete()
//    static func getMaxID() -> Int32
//    static func getObject(key: String, value: Any) -> CoreDataProtocol
}

extension CoreDataProtocol {
    
}
