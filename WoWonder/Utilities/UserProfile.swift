//
//  UserProfile.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/3/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

class UserProfile {
    
    private static var object: UserProfile?
    
    private init() {}
    
    public static var shared: UserProfile {
        
        if object == nil {
            object = UserProfile()
        }
        return object!
    }

    private let KEY_IS_LOGGED_IN = "is_logged_in"
    private let KEY_IS_FIRST_RUN = "is_first_run"
    
    private var userDefaults = UserDefaults.standard
    
    // MARK: - IS FIRST RUN
    
    func isFirstRun() -> Bool {
        let firstRunVar = userDefaults.string(forKey: KEY_IS_FIRST_RUN) ?? ""
        
        if firstRunVar.isEmpty {
            return true
        }
        return false
    }
    
    func changeFirstRunStatus() {
        userDefaults.set("exists", forKey: KEY_IS_FIRST_RUN)
    }
}
