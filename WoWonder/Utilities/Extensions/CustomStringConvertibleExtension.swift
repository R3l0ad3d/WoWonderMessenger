//
//  CustomStringConvertableExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 30/04/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation

extension CustomStringConvertible {
    var description : String {
        var description: String = ""
        
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
