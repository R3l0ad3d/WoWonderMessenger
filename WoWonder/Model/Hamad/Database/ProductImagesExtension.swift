//
//  
//  ProductImagesExtension.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 11/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

extension ProductImages: CoreDataObject {
    
    var _image_org: String {
        get {
            return self.image_id ?? ""
        }
    }
    
    var _image_id: String {
        get {
            return self.image_id ?? ""
        }
    }
    
    var _product_id: String {
        get {
            return self.product_id ?? ""
        }
    }
    
    var _url: String {
        get {
            return self.url ?? ""
        }
    }
    
    func save() {
        self.setValue(image_org, forKey: #keyPath(ProductImages.image_org))
        self.setValue(image_id, forKey: #keyPath(ProductImages.image_id))
        self.setValue(product_id, forKey: #keyPath(ProductImages.product_id))
        self.setValue(url, forKey: #keyPath(ProductImages.url))
        
        do {
            try self.managedObjectContext!.save()
        } catch let err {
            print("ERROR \(#file) => \(#function) => \(err.localizedDescription)")
        }
    }
}
