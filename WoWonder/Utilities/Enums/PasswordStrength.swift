//
//  PasswordStrength.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/4/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

enum PasswordStrength: Int {
    case None
    case Weak
    case Medium
    case Strong

    static func checkStrength(password: String) -> PasswordStrength {
        let len: Int = password.count
        var strength: Int = 0
        
        switch len {
        case 0:
            return .None
        case 1...4:
            strength+=1
        case 5...8:
            strength += 2
        default:
            strength += 3
        }
        
        // Upper case, Lower case, Number & Symbols
        let patterns = ["^(?=.*[A-Z]).*$", "^(?=.*[a-z]).*$", "^(?=.*[0-9]).*$", "^(?=.*[!@#%&-_=:;\"'<>,`~\\*\\?\\+\\[\\]\\(\\)\\{\\}\\^\\$\\|\\\\\\.\\/]).*$"]
        
        for pattern in patterns {
            if (password.range(of: pattern, options: .regularExpression) != nil) {
                strength+=1
            }
//            if (password =~ pattern).boolValue {
//                strength++
//            }
        }
        
        switch strength {
        case 0:
            return .None
        case 1...3:
            return .Weak
        case 4...6:
            return .Medium
        default:
            return .Strong
        }
    }
}
