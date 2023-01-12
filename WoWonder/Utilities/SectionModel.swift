//
//  SectionModel.swift
//  QPay
//
//  Created by Mohammed Hamad on 19/05/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

protocol SectionModelProtocol: Equatable {
    /// Special variable (Not from API)
    var isSelected: Bool { get set }
}

struct SectionModel<T: SectionModelProtocol>: Equatable {
    
    let title: String
    var list: [T]
    var isOpened: Bool = false

    var isSelected: Bool = false {
        willSet {
            for i in 0..<self.list.count {
                self.list[i].isSelected = newValue
            }
        }
    }
}
