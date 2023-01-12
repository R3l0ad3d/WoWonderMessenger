//
//  ArrayExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 9/26/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element:Equatable {
    
    public func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
