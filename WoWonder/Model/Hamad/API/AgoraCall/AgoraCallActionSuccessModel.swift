//
//  
//  AgoraCallActionSuccessModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 03/09/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//
//
import Foundation
import UIKit

struct AgoraCallActionSuccessModel : Codable {
    var status: Int?
    
    var _status: Int {
        get {
            return self.status ?? 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "api_status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let status = try? container.decode(Int.self, forKey: .status) {
            self.status = status
        }
    }
}
