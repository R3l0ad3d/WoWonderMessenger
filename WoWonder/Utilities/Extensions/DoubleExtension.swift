//
//  DoubleExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 25/01/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    var decimalPlaces: Int {
        let decimals = String(self).split(separator: ".")[1]
        return decimals == "0" ? 0 : decimals.count
    }
    
    /**
     Format number by seperate numbers to groups after 3 digits,
     Default max digites after comma is 2
     
     - parameter style: Number format style like (currency, decimal...).
     - parameter maxDigits: max number of digits after decimal seperator.
     - returns: String
     - warning: No Warning
     
     
     # Notes: #
     1. The default of number formatter style is decimal.
     2. The maximum digits of number after decimal seperator is 2.
     
     # Example #
     ```
     123,456,789.00
     ```
     */
    public func formatNumber(to style: NumberFormatter.Style = .decimal, maxDigits: Int = 2, minDigits: Int = 2) -> String {
        self.numberFormatBy(style: .decimal, maxDigits: maxDigits, minDigits: minDigits)
    }
    
    private func numberFormatBy(style: NumberFormatter.Style = .decimal, maxDigits: Int, minDigits: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = minDigits
        numberFormatter.maximumFractionDigits = maxDigits
//        numberFormatter.minimumIntegerDigits = 2
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
}
