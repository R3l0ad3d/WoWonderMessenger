//
//  GradientColor.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 10/24/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class GradientView2: ViewDesign {
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
    
//    private var gradientLayer: CAGradientLayer!
//
//    @IBInspectable var topColor: UIColor = .red {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var bottomColor: UIColor = .yellow {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var shadowColor: UIColor = .clear {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var shadowX: CGFloat = 0 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var shadowY: CGFloat = -3 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var shadowBlur: CGFloat = 3 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var shadowOpacity: Float = 0 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var startPointX: CGFloat = 0 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var startPointY: CGFloat = 0.5 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var endPointX: CGFloat = 1 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var endPointY: CGFloat = 0.5 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//
//    override class var layerClass: AnyClass {
//        return CAGradientLayer.self
//    }
//
//    override func layoutSubviews() {
//        self.gradientLayer = self.layer as? CAGradientLayer
//        self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
//        self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
//        self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
//        self.layer.cornerRadius = cornerRadius
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
//        self.layer.shadowRadius = shadowBlur
//        self.layer.shadowOpacity = shadowOpacity
//    }
//
//    func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
//        let fromColors = self.gradientLayer?.colors
//        let toColors: [AnyObject] = [newTopColor.cgColor, newBottomColor.cgColor]
//        self.gradientLayer?.colors = toColors
//        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
//        animation.fromValue = fromColors
//        animation.toValue = toColors
//        animation.duration = duration
//        animation.isRemovedOnCompletion = true
//        animation.fillMode = .forwards
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        self.gradientLayer?.add(animation, forKey:"animateGradient")
//    }
}
