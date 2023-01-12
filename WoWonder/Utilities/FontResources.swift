//
//  FontResources.swift
//  EMS
//
//  Created by Mohammed Hamad on 22/08/2021.
//

import Foundation
import UIKit

struct Resources {
    
    struct Fonts {}
}

extension Resources.Fonts {
    enum Weight: String {
        case extralight = "Cairo-ExtraLight"
        case light = "Cairo-Light"
        case regular = "Cairo-Regular"
        case semibold = "Cairo-SemiBold"
        case bold = "Cairo-Bold"
        case black = "Cairo-Black"
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func mySystemFont(ofSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .ultraLight:
            return UIFont(name: Resources.Fonts.Weight.extralight.rawValue, size: ofSize)!
        case .semibold:
            return UIFont(name: Resources.Fonts.Weight.semibold.rawValue, size: ofSize)!
        case .black:
            return UIFont(name: Resources.Fonts.Weight.black.rawValue, size: ofSize)!
        case .regular:
            return UIFont(name: Resources.Fonts.Weight.regular.rawValue, size: ofSize)!
        case .bold:
            return UIFont(name: Resources.Fonts.Weight.bold.rawValue, size: ofSize)!
        default:
            return UIFont(name: Resources.Fonts.Weight.regular.rawValue, size: ofSize)!
        }
    }
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.regular.rawValue, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.semibold.rawValue, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(myCoder: aDecoder)
            return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = Resources.Fonts.Weight.regular.rawValue
        case "CTFontSemiboldUsage":
            fontName = Resources.Fonts.Weight.semibold.rawValue
        case "CTFontBlackUsage":
            fontName = Resources.Fonts.Weight.black.rawValue
        case "CTFontEmphasizedUsage":
            fontName = Resources.Fonts.Weight.semibold.rawValue
        case "CTFontBoldUsage":
            fontName = Resources.Fonts.Weight.bold.rawValue
        default:
            fontName = Resources.Fonts.Weight.regular.rawValue
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideDefaultTypography() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethodWithWeight = class_getClassMethod(self, #selector(systemFont(ofSize: weight:))),
           let mySystemFontMethodWithWeight = class_getClassMethod(self, #selector(mySystemFont(ofSize: weight:))) {
            method_exchangeImplementations(systemFontMethodWithWeight, mySystemFontMethodWithWeight)
        }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
           let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
           let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
           let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}

