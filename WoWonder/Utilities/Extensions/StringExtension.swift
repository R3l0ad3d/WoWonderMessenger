//
//  StringExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 7/14/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    public var isNumeric : Bool {
        get {
            NumberFormatter().number(from: self) != nil
        }
    }
    
//    public var isNumber: Bool {
//        let characters = CharacterSet.decimalDigits.inverted
//        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
//    }

    public func localize(_ className: Self? = nil) -> String {
        let tableName = className == nil ? "Localizable" : className
        return NSLocalizedString(self,
                                 tableName: tableName,
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
    
    public func removeWhiteSpacing() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    public func chunkFormatted(withChunkSize chunkSize: Int = 4,
                               withSeparator separator: Character = "-") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
    
    public func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    public func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    public func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1)
        )
    }
    
    public func formatToDate(_ format: String) -> Date? {
        return self.convertFormatStringToDate(format)
    }
    
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }
    
    private static let formatter = NumberFormatter()

    public func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }
    
    public func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale
        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            guard let digit = Self.formatter.number(from: String($0)) else {
                assertionFailure("Can not convert to number from: \(original)")
                return (original, original)
            }
            guard let localized = Self.formatter.string(from: digit) else {
                assertionFailure("Can not convert to string from: \(digit)")
                return (original, original)
            }
            return (original, localized)
        }

        var converted = self
        for map in maps { converted = converted.replacingOccurrences(of: map.original, with: map.converted) }
        return converted
    }
    
    public func correctUrlString() -> String {
        return self.replacingOccurrences(of: "\\", with: "/")
    }

    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    public func checkPasswordStrength() -> Int {
        
        var strength = 0
        
        do {
            let capitalizePattern = "[A-Z]+"
            let specialCharsPattern = "[\\\\!\\@\\#\\$\\%^\\&\\*\\(\\)\\{\\}\\[\\]|\\/\\?\\<\\>\\-\\_\\=\\+]+"
            let numbersPattern = "[0-9]+"
            
            let capitalizeRegex = try NSRegularExpression(pattern: capitalizePattern, options: NSRegularExpression.Options(rawValue: 0))
            let specialCharsRegex = try NSRegularExpression(pattern: specialCharsPattern, options: NSRegularExpression.Options(rawValue: 0))
            let numbersRegex = try NSRegularExpression(pattern: numbersPattern, options: NSRegularExpression.Options(rawValue: 0))
            
            let range: NSRange = NSMakeRange(0, self.count)
            
            let capitalizeMatches = capitalizeRegex.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: range)
            let specialCharsMatches = specialCharsRegex.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: range)
            let numbersMatches = numbersRegex.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: range)
            
            if capitalizeMatches.count > 0 {
                strength += 1
            }
            
            if specialCharsMatches.count > 0 {
                strength += 1
            }
            
            if numbersMatches.count > 0 {
                strength += 1
            }
            if self.count >= 6 {
                strength += 2
            }
            
        } catch let err {
            print("ERROR \(err.localizedDescription)")
        }
        return strength
    }

    internal func getImageFromURLString(completion: @escaping (Bool, UIImage?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            do {
                guard let url = URL(string: self.correctUrlString()) else {
                    completion(false, nil)
                    return
                }
                
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else {
                        completion(false, nil)
                        return
                    }
                    
                    completion(true, image)
                }
                
            } catch {
                completion(false, nil)
            }
        }
    }
    
    public func convertBase64StringToImage() -> UIImage {
        let imageData = Data(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }

    public func convertFormatStringToDate(_ format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        dateFormatter.timeZone = .GMT
        dateFormatter.dateFormat = format
        let convertedDate = dateFormatter.date(from: self)
        return convertedDate
    }
}
