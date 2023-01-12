//
//  UIButtonExtension.swift
//  DukkanTogo
//
//  Created by Mohammed Hamad on 02/12/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable
    var isUpperCased: Bool {
        get { self.titleLabel?.text == self.titleLabel?.text?.uppercased() }
        set { self.setTitle(self.titleLabel?.text?.uppercased(), for: .normal) }
    }
}
