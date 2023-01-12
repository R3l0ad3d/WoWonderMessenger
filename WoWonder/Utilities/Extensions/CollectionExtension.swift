//
//  CollectionExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 15/03/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension Collection {
    
    public var isNotEmpty: Bool {
        get {
            return !self.isEmpty
        }
    }
    
    public func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
