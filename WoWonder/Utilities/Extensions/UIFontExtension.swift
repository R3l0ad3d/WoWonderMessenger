//
//  DateFormatterExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 10/19/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    var regular: UIFont { return withWeight(.regular) }
    var medium: UIFont { return withWeight(.medium) }
    var semibold: UIFont { return withWeight(.semibold) }
    var bold: UIFont { return withWeight(.bold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
    static func sfDisplay(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SF UI Display", size: size)
    }
}
