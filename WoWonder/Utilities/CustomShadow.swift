//
//  CustomShadow.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 12/06/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

struct CustomShadow {
    
    var color: UIColor
    var opacity: Float
    var radius: CGFloat
    var offset: CGSize
    
    static let `default`: Self = .init(color: .darkGray,
                                       opacity: 0.2,
                                       radius: 4,
                                       offset: CGSize(width: 0, height: 2)
    )
}
