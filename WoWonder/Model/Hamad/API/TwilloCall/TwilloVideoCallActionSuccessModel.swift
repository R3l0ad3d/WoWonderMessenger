//
//  
//  TwilloVideoCallActionSuccessModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 04/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct TwilloVideoCallActionSuccessModel: Codable {
    var status: Int?
    var url: String?
    
    var _status: Int {
        get {
            return self.status ?? 0
        }
    }
    
    var _url: String {
        get {
            return self.url ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let status = try? container.decode(Int.self, forKey: .status) {
            self.status = status
        }
        if let url = try? container.decode(String.self, forKey: .url) {
            self.url = url
        }
    }
}
