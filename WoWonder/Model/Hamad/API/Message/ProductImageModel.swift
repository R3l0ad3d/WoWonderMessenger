//
//  ProductImageModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

struct ProductImageModel: Codable {
    
    let id: String?
    let image: String?
    let productID: String?
    let imageOrg: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image
        case productID = "product_id"
        case imageOrg = "image_org"
    }
}
