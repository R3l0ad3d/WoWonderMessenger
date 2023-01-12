//
//  ProductsExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 02/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Products: CoreDataObject {
    
    var _message_id: String {
        get {
            return self.message_id ?? ""
        }
    }
    
    var _my_id: String {
        get {
            return self.my_id ?? ""
        }
    }
    
    var _name: String {
        get {
            return self.name ?? ""
        }
    }
    
    var _active: String {
        get {
            return self.active ?? ""
        }
    }
    
    var _currency: String {
        get {
            return self.currency ?? ""
        }
    }
    
    var _price: String {
        get {
            return self.price ?? ""
        }
    }
    
    var _status: String {
        get {
            return self.status ?? ""
        }
    }
    
    var _type: String {
        get {
            return self.type ?? ""
        }
    }
    
    var _url: String {
        get {
            return self.url ?? ""
        }
    }
    
    func save() {
        self.setValue(message_id, forKey: #keyPath(Products.message_id))
        self.setValue(name, forKey: #keyPath(Products.name))
        self.setValue(active, forKey: #keyPath(Products.active))
        self.setValue(currency, forKey: #keyPath(Products.currency))
        self.setValue(price, forKey: #keyPath(Products.price))
        self.setValue(status, forKey: #keyPath(Products.status))
        self.setValue(type, forKey: #keyPath(Products.type))
        self.setValue(url, forKey: #keyPath(Products.url))
        self.setValue(my_id, forKey: #keyPath(Products.my_id))
        
        do {
            try self.managedObjectContext!.save()
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
    
    func getImages() -> [ProductImages] {
        return self.images?.map({ model in
            return model as! ProductImages
        }) ?? []
    }
}
