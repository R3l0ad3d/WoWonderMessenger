//
//  CIImageExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 09/06/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension CIImage {
    
    public var blackAndWhite: CIImage {
        get {
            let paramsColor: [String : AnyObject] = [kCIInputBrightnessKey: NSNumber(value: 0.0),
                                                     kCIInputContrastKey:   NSNumber(value: 1.1),
                                                     kCIInputSaturationKey: NSNumber(value: 0.0)]
            let blackAndWhite = self.applyingFilter("CIColorControls", parameters: paramsColor)
            
            let paramsExposure: [String : AnyObject] = [kCIInputEVKey: NSNumber(value: 0.7)]
            let output = blackAndWhite.applyingFilter("CIExposureAdjust", parameters: paramsExposure)
            
            return output
        }
    }
    
    public var uiImage: UIImage {
        get {
            let context: CIContext = CIContext()
            let cgImage: CGImage = context.createCGImage(self, from: self.extent)!
            let image: UIImage = UIImage(cgImage: cgImage)
            return image
        }
    }
}
