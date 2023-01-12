//
//  GetPinData.swift
//  WoWonder
//
//  Created by UnikApp on 22/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation

struct GetPinData : Codable {
    let api_status : Int?
    let data : [GetPinDataMessage]?
    
    enum CodingKeys: String, CodingKey {
        case api_status = "api_status"
        case data = "data"
    }
    
    struct GetPinDataMessage : Codable {
        let user_id : String?
        let username : String?
        let email : String?
        let first_name : String?
        let last_name : String?
        let avatar : String?
        let cover : String?
        let background_image : String?
        let relationship_id : String?
        let address : String?
        let working : String?
        let working_link : String?
        let about : String?
        let school : String?
        let gender : String?
        let birthday : String?
        let country_id : String?
        let website : String?
        let facebook : String?
        let google : String?
        let twitter : String?
        let linkedin : String?
        let youtube : String?
        let vk : String?
        let instagram : String?
        let qq : String?
        let wechat : String?
        let discord : String?
        let mailru : String?
        let okru : String?
        let language : String?
        let ip_address : String?
        let follow_privacy : String?
        let friend_privacy : String?
        let post_privacy : String?
        let message_privacy : String?
        let confirm_followers : String?
        let show_activities_privacy : String?
        let birth_privacy : String?
        let visit_privacy : String?
        let verified : String?
        let lastseen : String?
        let emailNotification : String?
        let e_liked : String?
        let e_wondered : String?
        let e_shared : String?
        let e_followed : String?
        let e_commented : String?
        let e_visited : String?
        let e_liked_page : String?
        let e_mentioned : String?
        let e_joined_group : String?
        let e_accepted : String?
        let e_profile_wall_post : String?
        let e_sentme_msg : String?
        let e_last_notif : String?
        let notification_settings : String?
        let status : String?
        let active : String?
        let admin : String?
        let registered : String?
        let phone_number : String?
        let is_pro : String?
        let pro_type : String?
        let pro_remainder : String?
        let timezone : String?
        let referrer : String?
        let ref_user_id : String?
        let balance : String?
        let paypal_email : String?
        let notifications_sound : String?
        let order_posts_by : String?
        let android_m_device_id : String?
        let ios_m_device_id : String?
        let android_n_device_id : String?
        let ios_n_device_id : String?
        let web_device_id : String?
        let wallet : String?
        let lat : String?
        let lng : String?
        let last_location_update : String?
        let share_my_location : String?
        let last_data_update : String?
        let details : Details?
        let last_avatar_mod : String?
        let last_cover_mod : String?
        let points : String?
        let daily_points : String?
        let converted_points : String?
        let point_day_expire : String?
        let last_follow_id : String?
        let share_my_data : String?
        let last_login_data : String?
        let two_factor : String?
        let two_factor_hash : String?
        let new_email : String?
        let two_factor_verified : String?
        let new_phone : String?
        let info_file : String?
        let city : String?
        let state : String?
        let zip : String?
        let school_completed : String?
        let weather_unit : String?
        let paystack_ref : String?
        let code_sent : String?
        let time_code_sent : String?
        let permission : String?
        let skills : String?
        let languages : String?
        let currently_working : String?
        let banned : String?
        let banned_reason : String?
        let avatar_post_id : String?
        let cover_post_id : Int?
        let avatar_full : String?
        let user_platform : String?
        let url : String?
        let name : String?
        let aPI_notification_settings : pinAPI_notification_settings?
        let is_notify_stopped : Int?
        let mutual_friends_data : [String]?
        let lastseen_unix_time : String?
        let lastseen_status : String?
        let is_reported : Bool?
        let is_story_muted : Bool?
        let is_following_me : Int?
        let is_reported_user : Int?
        let is_open_to_work : Int?
        let is_providing_service : Int?
        let providing_service : Int?
        let open_to_work_data : String?
        let formated_langs : [String]?
        let chat_time : Int?
        let chat_id : Int?
        let chat_type : String?
        let mute : PinMute?
        let last_message : pinLast_message?
        let message_count : String?
        
        enum CodingKeys: String, CodingKey {
            
            case user_id = "user_id"
            case username = "username"
            case email = "email"
            case first_name = "first_name"
            case last_name = "last_name"
            case avatar = "avatar"
            case cover = "cover"
            case background_image = "background_image"
            case relationship_id = "relationship_id"
            case address = "address"
            case working = "working"
            case working_link = "working_link"
            case about = "about"
            case school = "school"
            case gender = "gender"
            case birthday = "birthday"
            case country_id = "country_id"
            case website = "website"
            case facebook = "facebook"
            case google = "google"
            case twitter = "twitter"
            case linkedin = "linkedin"
            case youtube = "youtube"
            case vk = "vk"
            case instagram = "instagram"
            case qq = "qq"
            case wechat = "wechat"
            case discord = "discord"
            case mailru = "mailru"
            case okru = "okru"
            case language = "language"
            case ip_address = "ip_address"
            case follow_privacy = "follow_privacy"
            case friend_privacy = "friend_privacy"
            case post_privacy = "post_privacy"
            case message_privacy = "message_privacy"
            case confirm_followers = "confirm_followers"
            case show_activities_privacy = "show_activities_privacy"
            case birth_privacy = "birth_privacy"
            case visit_privacy = "visit_privacy"
            case verified = "verified"
            case lastseen = "lastseen"
            case emailNotification = "emailNotification"
            case e_liked = "e_liked"
            case e_wondered = "e_wondered"
            case e_shared = "e_shared"
            case e_followed = "e_followed"
            case e_commented = "e_commented"
            case e_visited = "e_visited"
            case e_liked_page = "e_liked_page"
            case e_mentioned = "e_mentioned"
            case e_joined_group = "e_joined_group"
            case e_accepted = "e_accepted"
            case e_profile_wall_post = "e_profile_wall_post"
            case e_sentme_msg = "e_sentme_msg"
            case e_last_notif = "e_last_notif"
            case notification_settings = "notification_settings"
            case status = "status"
            case active = "active"
            case admin = "admin"
            case registered = "registered"
            case phone_number = "phone_number"
            case is_pro = "is_pro"
            case pro_type = "pro_type"
            case pro_remainder = "pro_remainder"
            case timezone = "timezone"
            case referrer = "referrer"
            case ref_user_id = "ref_user_id"
            case balance = "balance"
            case paypal_email = "paypal_email"
            case notifications_sound = "notifications_sound"
            case order_posts_by = "order_posts_by"
            case android_m_device_id = "android_m_device_id"
            case ios_m_device_id = "ios_m_device_id"
            case android_n_device_id = "android_n_device_id"
            case ios_n_device_id = "ios_n_device_id"
            case web_device_id = "web_device_id"
            case wallet = "wallet"
            case lat = "lat"
            case lng = "lng"
            case last_location_update = "last_location_update"
            case share_my_location = "share_my_location"
            case last_data_update = "last_data_update"
            case details = "details"
            case last_avatar_mod = "last_avatar_mod"
            case last_cover_mod = "last_cover_mod"
            case points = "points"
            case daily_points = "daily_points"
            case converted_points = "converted_points"
            case point_day_expire = "point_day_expire"
            case last_follow_id = "last_follow_id"
            case share_my_data = "share_my_data"
            case last_login_data = "last_login_data"
            case two_factor = "two_factor"
            case two_factor_hash = "two_factor_hash"
            case new_email = "new_email"
            case two_factor_verified = "two_factor_verified"
            case new_phone = "new_phone"
            case info_file = "info_file"
            case city = "city"
            case state = "state"
            case zip = "zip"
            case school_completed = "school_completed"
            case weather_unit = "weather_unit"
            case paystack_ref = "paystack_ref"
            case code_sent = "code_sent"
            case time_code_sent = "time_code_sent"
            case permission = "permission"
            case skills = "skills"
            case languages = "languages"
            case currently_working = "currently_working"
            case banned = "banned"
            case banned_reason = "banned_reason"
            case avatar_post_id = "avatar_post_id"
            case cover_post_id = "cover_post_id"
            case avatar_full = "avatar_full"
            case user_platform = "user_platform"
            case url = "url"
            case name = "name"
            case aPI_notification_settings = "API_notification_settings"
            case is_notify_stopped = "is_notify_stopped"
            case mutual_friends_data = "mutual_friends_data"
            case lastseen_unix_time = "lastseen_unix_time"
            case lastseen_status = "lastseen_status"
            case is_reported = "is_reported"
            case is_story_muted = "is_story_muted"
            case is_following_me = "is_following_me"
            case is_reported_user = "is_reported_user"
            case is_open_to_work = "is_open_to_work"
            case is_providing_service = "is_providing_service"
            case providing_service = "providing_service"
            case open_to_work_data = "open_to_work_data"
            case formated_langs = "formated_langs"
            case chat_time = "chat_time"
            case chat_id = "chat_id"
            case chat_type = "chat_type"
            case mute = "mute"
            case last_message = "last_message"
            case message_count = "message_count"
        }
    }
    
    struct pinAPI_notification_settings : Codable {
        let e_liked : Int?
        let e_shared : Int?
        let e_wondered : Int?
        let e_commented : Int?
        let e_followed : Int?
        let e_accepted : Int?
        let e_mentioned : Int?
        let e_joined_group : Int?
        let e_liked_page : Int?
        let e_visited : Int?
        let e_profile_wall_post : Int?
        let e_memory : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case e_liked = "e_liked"
            case e_shared = "e_shared"
            case e_wondered = "e_wondered"
            case e_commented = "e_commented"
            case e_followed = "e_followed"
            case e_accepted = "e_accepted"
            case e_mentioned = "e_mentioned"
            case e_joined_group = "e_joined_group"
            case e_liked_page = "e_liked_page"
            case e_visited = "e_visited"
            case e_profile_wall_post = "e_profile_wall_post"
            case e_memory = "e_memory"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            e_liked = try values.decodeIfPresent(Int.self, forKey: .e_liked)
            e_shared = try values.decodeIfPresent(Int.self, forKey: .e_shared)
            e_wondered = try values.decodeIfPresent(Int.self, forKey: .e_wondered)
            e_commented = try values.decodeIfPresent(Int.self, forKey: .e_commented)
            e_followed = try values.decodeIfPresent(Int.self, forKey: .e_followed)
            e_accepted = try values.decodeIfPresent(Int.self, forKey: .e_accepted)
            e_mentioned = try values.decodeIfPresent(Int.self, forKey: .e_mentioned)
            e_joined_group = try values.decodeIfPresent(Int.self, forKey: .e_joined_group)
            e_liked_page = try values.decodeIfPresent(Int.self, forKey: .e_liked_page)
            e_visited = try values.decodeIfPresent(Int.self, forKey: .e_visited)
            e_profile_wall_post = try values.decodeIfPresent(Int.self, forKey: .e_profile_wall_post)
            e_memory = try values.decodeIfPresent(Int.self, forKey: .e_memory)
        }
        
    }
    
    struct PinMute : Codable {
        let notify : String?
        let call_chat : String?
        let archive : String?
        let fav : String?
        let pin : String?
        
        enum CodingKeys: String, CodingKey {
            
            case notify = "notify"
            case call_chat = "call_chat"
            case archive = "archive"
            case fav = "fav"
            case pin = "pin"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            notify = try values.decodeIfPresent(String.self, forKey: .notify)
            call_chat = try values.decodeIfPresent(String.self, forKey: .call_chat)
            archive = try values.decodeIfPresent(String.self, forKey: .archive)
            fav = try values.decodeIfPresent(String.self, forKey: .fav)
            pin = try values.decodeIfPresent(String.self, forKey: .pin)
        }
        
    }
    
    struct pinLast_message : Codable {
        let id : String?
        let from_id : String?
        let group_id : String?
        let page_id : String?
        let to_id : String?
        let text : String?
        let media : String?
        let mediaFileName : String?
        let mediaFileNames : String?
        let time : String?
        let seen : String?
        let deleted_one : String?
        let deleted_two : String?
        let sent_push : String?
        let notification_id : String?
        let type_two : String?
        let stickers : String?
        let product_id : String?
        let lat : String?
        let lng : String?
        let reply_id : String?
        let story_id : String?
        let broadcast_id : String?
        let forward : String?
        let listening : String?
        let messageUser : MessageUser?
        let onwer : Int?
        let reaction : Reaction?
        let time_text : String?
        let position : String?
        let type : String?
        let product : String?
        let file_size : Int?
        let chat_color : String?
        
        enum CodingKeys: String, CodingKey {
            
            case id = "id"
            case from_id = "from_id"
            case group_id = "group_id"
            case page_id = "page_id"
            case to_id = "to_id"
            case text = "text"
            case media = "media"
            case mediaFileName = "mediaFileName"
            case mediaFileNames = "mediaFileNames"
            case time = "time"
            case seen = "seen"
            case deleted_one = "deleted_one"
            case deleted_two = "deleted_two"
            case sent_push = "sent_push"
            case notification_id = "notification_id"
            case type_two = "type_two"
            case stickers = "stickers"
            case product_id = "product_id"
            case lat = "lat"
            case lng = "lng"
            case reply_id = "reply_id"
            case story_id = "story_id"
            case broadcast_id = "broadcast_id"
            case forward = "forward"
            case listening = "listening"
            case messageUser = "messageUser"
            case onwer = "onwer"
            case reaction = "reaction"
            case time_text = "time_text"
            case position = "position"
            case type = "type"
            case product = "product"
            case file_size = "file_size"
            case chat_color = "chat_color"
        }
    }
    
    enum avtarID: Codable {
        case integer(Int)
        case string(String)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(FileSize.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                  debugDescription: "Wrong type for FileSize"))
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .integer(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            }
        }
    }
}
