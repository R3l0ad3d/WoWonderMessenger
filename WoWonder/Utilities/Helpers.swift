//
//  Helpers.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/13/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Real Variables

public typealias VoidCompletion = (() -> Void)

public typealias UpdateClosure = (isSuccess: Bool, message: String)

enum CallType: Int, CaseIterable {
    case audio = 0
    case video
    
    var title: String {
        get {
            switch self {
            case .audio: return "calling"
            case .video: return "calling Video..."
            }
        }
    }
    
    var requestString: String {
        get {
            switch self {
            case .audio: return "audio"
            case .video: return "video"
            }
        }
    }
}

enum CallProvider: String, CaseIterable {
    case agora
    case twillo
}

enum CallDirection: Int, CaseIterable {
    case incoming = 0
    case outgoing
}
