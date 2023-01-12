//
//  UILabelExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/11/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    public func setRegualAndBoldText(boldiText: String, regualText: String) {
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: font.pointSize)]
        let userString = NSMutableAttributedString(string: "User ")
        let boldiString = NSMutableAttributedString(string: boldiText, attributes:attrs)
        let regularString = NSMutableAttributedString(string: regualText)
        userString.append(boldiString)
        userString.append(regularString)
        attributedText = userString
   }
}
