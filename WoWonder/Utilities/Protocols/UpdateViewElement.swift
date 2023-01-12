//
//  UploadProfileImage.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 8/8/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol UpdateViewElement {
    
    func elementUpdated(fromSourceView view: UIViewController, status: Bool, data: Any?)
    @objc optional func elementsUpdated(fromSourceView view: UIViewController, status: Bool, data: [Any]?)
}
