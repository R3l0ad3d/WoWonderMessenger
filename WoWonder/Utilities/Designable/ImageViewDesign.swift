//
//  UIView.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/2/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class ImageViewDesign: UIImageView {
    
    @IBInspectable var imageTintColor: UIColor {
        set {
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = newValue
        }
        get {
            return .clear
        }
    }
    
    @IBInspectable var isCircle: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = .clear
    
    @IBInspectable var shadowColor: UIColor = .gray
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var hamadShadowRadius: CGFloat = 0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = hamadShadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = true
        
        setCorner()
    }
    
    private func setCorner() {
        if self.isCircle {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
}
