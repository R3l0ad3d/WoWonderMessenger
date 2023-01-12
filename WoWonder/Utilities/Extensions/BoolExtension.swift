//
//  BoolExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 05/05/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension Bool {
    
    public mutating func toggle() {
        self = !self
    }
    
    public func toggleAndReturn() -> Bool {
        return !self
    }
}
