//
//  UIImageViewExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 8/30/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    
    subscript(i: Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
    
    public func getArrayFromValues() -> [Value] {
        var array = [Value]()
        for (_, value) in self.values.enumerated() {
            array.append(value)
        }
        return array
    }
}

