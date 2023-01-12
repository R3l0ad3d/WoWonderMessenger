//
//  Weakifiable.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 17/06/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

protocol Weakifiable: AnyObject {}

extension Weakifiable {
    func weakify<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> Void {
        return {
            [weak self] (data) in
            
            guard let self = self else { return }
            
            code(self, data)
        }
    }
}
