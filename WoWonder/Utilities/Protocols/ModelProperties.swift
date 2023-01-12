//
//  ModelProperties.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 27/04/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

protocol ModelProperties {
    func labels() -> [String]
    func values() -> [Any]
}

extension ModelProperties {
    
    func labels() -> [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    func values() -> [Any] {
        return Mirror(reflecting: self).children.compactMap { $0.value }
    }
}

