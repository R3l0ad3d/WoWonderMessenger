//
//  TimeZoneExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 30/11/2020.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension TimeZone {
    
    static var GMT: TimeZone {
        return Self(abbreviation: "GMT")!
    }
}
