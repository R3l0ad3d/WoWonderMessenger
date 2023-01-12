//
//  MessageProductModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

struct MessageProductModel: Codable {
    
    var id: String?
    var userID: String?
    var pageID: String?
    var name: String?
    var productDescription: String?
    var category: String?
    var subCategory: String?
    var price: String?
    var location: String?
    var status: String?
    var type: String?
    var currency: String?
    var lng: String?
    var lat: String?
    var time: String?
    var active: String?
    var images: [ProductImageModel]?
    var timeText: String?
    var postID: String?
    var editDescription: String?
    var url: String?
    var productSubCategory: String?
    var fields: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case pageID = "page_id"
        case name
        case productDescription = "description"
        case category
        case subCategory = "sub_category"
        case price, location, status, type, currency, lng, lat, time, active, images
        case timeText = "time_text"
        case postID = "post_id"
        case editDescription = "edit_description"
        case url
        case productSubCategory = "product_sub_category"
        case fields
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let userID = try? container.decode(String.self, forKey: .id) {
            self.userID = userID
        }
        if let pageID = try? container.decode(String.self, forKey: .id) {
            self.pageID = pageID
        }
        if let name = try? container.decode(String.self, forKey: .id) {
            self.name = name
        }
        if let productDescription = try? container.decode(String.self, forKey: .id) {
            self.productDescription = productDescription
        }
        if let category = try? container.decode(String.self, forKey: .id) {
            self.category = category
        }
        if let subCategory = try? container.decode(String.self, forKey: .id) {
            self.subCategory = subCategory
        }
        if let price = try? container.decode(String.self, forKey: .id) {
            self.price = price
        }
        if let location = try? container.decode(String.self, forKey: .id) {
            self.location = location
        }
        if let status = try? container.decode(String.self, forKey: .id) {
            self.status = status
        }
        if let type = try? container.decode(String.self, forKey: .id) {
            self.type = type
        }
        if let currency = try? container.decode(String.self, forKey: .id) {
            self.currency = currency
        }
        if let lng = try? container.decode(String.self, forKey: .id) {
            self.lng = lng
        }
        if let lat = try? container.decode(String.self, forKey: .id) {
            self.lat = lat
        }
        if let time = try? container.decode(String.self, forKey: .id) {
            self.time = time
        }
        if let active = try? container.decode(String.self, forKey: .id) {
            self.active = active
        }
        if let images = try? container.decode([ProductImageModel].self, forKey: .id) {
            self.images = images
        }
        if let timeText = try? container.decode(String.self, forKey: .id) {
            self.timeText = timeText
        }
        if let postID = try? container.decode(String.self, forKey: .id) {
            self.postID = postID
        }
        if let editDescription = try? container.decode(String.self, forKey: .id) {
            self.editDescription = editDescription
        }
        if let url = try? container.decode(String.self, forKey: .id) {
            self.url = url
        }
        if let productSubCategory = try? container.decode(String.self, forKey: .id) {
            self.productSubCategory = productSubCategory
        }
        if let fields = try? container.decode([String].self, forKey: .id) {
            self.fields = fields
        }
    }
}
