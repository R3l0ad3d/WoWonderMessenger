//
//  PlistManager.swift
//  CoreDataApp
//
//  Created by Mohammed Hamad on 23/03/2021.
//

import Foundation

class PlistManager {
    
    private let url: URL
    private let fileName: String = "Test"
    
    public enum PlistError: Error {
        case NoFileFound(String)
        case WriteData
        case DataConvert
    }
    
    init() throws {
        guard let url = Bundle.main.url(forResource: self.fileName, withExtension: "plist") else {
            throw PlistError.NoFileFound("No file named \(self.fileName) found")
//            throw PlistError.NoFileFound
        }
        self.url = url
    }
    
    public func readObject<T: Decodable>(object: T.Type) throws -> T {
        guard let data = try? Data(contentsOf: self.url) else {
//            throw PlistError.DataConvert("Data convert error")
            throw PlistError.DataConvert
        }
        return try PropertyListDecoder().decode(object, from: data)
    }
    
    public func save<T: Encodable>(object: T) throws {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(object)
            try data.write(to: url)
        } catch {
//            throw PlistError.WriteData("Connot save data to file")
            throw PlistError.WriteData
        }
    }
    
    //    public static func readDictionary(fileName: String) -> [String : Any]? {
    //        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
    //              let plistData = FileManager.default.contents(atPath: path) else {
    //            return nil
    //        }
    //        var format = PropertyListSerialization.PropertyListFormat.xml
    //        return try? PropertyListSerialization.propertyList(from: plistData,
    //                                                          options: .mutableContainersAndLeaves,
    //                                                          format: &format) as? [String: Any]
    //    }
}
