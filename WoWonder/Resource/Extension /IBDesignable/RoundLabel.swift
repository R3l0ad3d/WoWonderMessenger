//
//  RoundLabel.swift
//  WoWonder
//
//  Created by Ubaid Javaid on 7/14/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import UIKit

//@IBDesignable
class RoundLabel: UILabel {

       @IBInspectable var topInset: CGFloat = 5.0
       @IBInspectable var bottomInset: CGFloat = 5.0
       @IBInspectable var leftInset: CGFloat = 8.0
       @IBInspectable var rightInset: CGFloat = 8.0

       override func drawText(in rect: CGRect) {
           let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
           super.drawText(in: rect.inset(by: insets))
       }

       override var intrinsicContentSize: CGSize {
           let size = super.intrinsicContentSize
           return CGSize(width: size.width + leftInset + rightInset,
                         height: size.height + topInset + bottomInset)
       }
      

    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
        
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor = .white {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }

}
