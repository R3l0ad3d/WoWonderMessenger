//
//  UIImageViewExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 8/30/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

extension UIImageView {
    
    public func setGrayScale(saturationLevel: Double) {
        if let img = self.image {
            let ciImage = CIImage(image: img)
            let grayscale = ciImage?.applyingFilter("CIColorControls",
                                                    parameters: [kCIInputSaturationKey : saturationLevel])
            if let gray = grayscale {
                self.image = UIImage(ciImage: gray)
            }
        }
    }
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    public func maskCircle(image: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // fix rotation.
        self.image = image
    }
}

