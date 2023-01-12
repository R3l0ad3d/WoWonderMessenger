//
//  UIStoryboard.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/3/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    private static var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    private static var dashboardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)

    static func getViewFromStoryboard(with identifier: String) -> UIViewController {
        
        let dictionaryKey = "identifierToNibNameMap"
        
        if let availableIdentifiers = dashboardStoryboard.value(forKey: dictionaryKey) as? [String: Any] {
            if availableIdentifiers[identifier] != nil {
                return dashboardStoryboard.instantiateViewController(identifier: identifier)
            }
        }
        return mainStoryboard.instantiateViewController(identifier: identifier)
    }
}
