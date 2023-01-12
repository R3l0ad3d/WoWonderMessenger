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
class ViewDesign: UIView {
    
    @IBInspectable var masksToBounds: Bool = true
    @IBInspectable var isCircle: Bool = false
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = .clear
    
    @IBInspectable var shadowColor: UIColor = .gray
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var shadowRadius2: CGFloat = 0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    
    var shadow: CustomShadow = .default {
        didSet {
            self.shadowColor = self.shadow.color
            self.shadowOpacity = self.shadow.opacity
            self.shadowRadius2 = self.shadow.radius
            self.shadowOffset = self.shadow.offset
        }
    }
    
    private var cornerRadiusRect: UIRectCorner = .allCorners
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = cornerRadius
        self.setCornerMask()
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius2
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = masksToBounds
        
        self.setCorner()
    }
    
    public func setViewCorners(_ corners: UIRectCorner) {
        self.cornerRadiusRect = corners
        self.layoutSubviews()
    }
    
    private func setCornerMask() {
        
        let corners = self.cornerRadiusRect
        
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()

            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            
            self.layer.maskedCorners = cornerMask
            
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    private func setCorner() {
        if self.isCircle {
            self.layer.cornerRadius = self.height / 2
        }
    }
}
