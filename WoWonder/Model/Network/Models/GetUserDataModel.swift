

import Foundation

class GetUserDataModel: BaseModel {
    
    struct GetUserDataSuccessModel: Codable {
        var apiStatus: Int?
        var userData: UserData?
        var followers : [Followers]?
        var following : [Following]?
        
        enum CodingKeys: String, CodingKey {
            
            case apiStatus = "api_status"
            case userData = "user_data"
            case followers = "followers"
            case following = "following"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            apiStatus = try values.decodeIfPresent(Int.self, forKey: .apiStatus)
            userData = try values.decodeIfPresent(UserData.self, forKey: .userData)
            followers = try values.decodeIfPresent([Followers].self, forKey: .followers)
            following = try values.decodeIfPresent([Following].self, forKey: .following)
        }
    }
    
    struct GetUserDataErrorModel: Codable {
        let apiStatus: String?
        let errors: Errors?
        
        enum CodingKeys: String, CodingKey {
            case apiStatus = "api_status"
            case errors
        }
    }
    
    struct Errors: Codable {
        let errorID: Int?
        let errorText: String?
        
        enum CodingKeys: String, CodingKey {
            case errorID = "error_id"
            case errorText = "error_text"
        }
    }
        
    struct Following : Codable {
        let user_id : String?
        let username : String?
        let email : String?
        let first_name : String?
        let last_name : String?
        let avatar : String?
        let cover : String?
        let background_image : String?
        let background_image_status : String?
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
        let email_code : String?
        let src : String?
        let ip_address : String?
        let follow_privacy : String?
        let friend_privacy : String?
        let post_privacy : String?
        let message_privacy : String?
        let confirm_followers : String?
        let show_activities_privacy : String?
        let birthPrivacy : String?
        let visit_privacy : String?
        let verified : String?
        let lastseen : String?
        let showlastseen : String?
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
        let type : String?
        let registered : String?
        let start_up : String?
        let start_up_info : String?
        let startup_follow : String?
        let startup_image : String?
        let last_email_sent : String?
        let phone_number : String?
        let sms_code : String?
        let is_pro : String?
        let pro_time : String?
        let pro_type : String?
        let joined : String?
        let css_file : String?
        let timezone : String?
        let referrer : String?
        let ref_user_id : String?
        let balance : String?
        let paypal_email : String?
        let notifications_sound : String?
        let order_posts_by : String?
        let social_login : String?
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
        let sidebar_data : String?
        let last_avatar_mod : String?
        let last_cover_mod : String?
        let points : String?
        let daily_points : String?
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
        let stripeSessionId : String?
        let time_code_sent : String?
        let permission : String?
        let skills : String?
        let languages : String?
        let currently_working : String?
        let banned : String?
        let banned_reason : String?
        let coinbase_hash : String?
        let coinbase_code : String?
        let yoomoney_hash : String?
        let conversationId : String?
        let securionpay_key : String?
        let fortumo_hash : String?
        let aamarpay_tran_id : String?
        let ngenius_ref : String?
        let coinpayments_txn_id : String?
        let avatar_post_id : String?
        let cover_post_id : Int?
        let avatar_org : String?
        let cover_org : String?
        let cover_full : String?
        let avatar_full : String?
        let id : String?
        let user_platform : String?
        let url : String?
        let name : String?
        let api_notification_settings : APINotificationSettings?
        let is_notify_stopped : Int?
        let following_data : [String]?
        let followers_data : [String]?
        let mutual_friends_data : String?
        let likes_data : String?
        let groups_data : [String]?
        let album_data : String?
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
        let family_member : String?
        let is_following : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case user_id = "user_id"
            case username = "username"
            case email = "email"
            case first_name = "first_name"
            case last_name = "last_name"
            case avatar = "avatar"
            case cover = "cover"
            case background_image = "background_image"
            case background_image_status = "background_image_status"
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
            case email_code = "email_code"
            case src = "src"
            case ip_address = "ip_address"
            case follow_privacy = "follow_privacy"
            case friend_privacy = "friend_privacy"
            case post_privacy = "post_privacy"
            case message_privacy = "message_privacy"
            case confirm_followers = "confirm_followers"
            case show_activities_privacy = "show_activities_privacy"
            case birthPrivacy = "birth_privacy"
            case visit_privacy = "visit_privacy"
            case verified = "verified"
            case lastseen = "lastseen"
            case showlastseen = "showlastseen"
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
            case type = "type"
            case registered = "registered"
            case start_up = "start_up"
            case start_up_info = "start_up_info"
            case startup_follow = "startup_follow"
            case startup_image = "startup_image"
            case last_email_sent = "last_email_sent"
            case phone_number = "phone_number"
            case sms_code = "sms_code"
            case is_pro = "is_pro"
            case pro_time = "pro_time"
            case pro_type = "pro_type"
            case joined = "joined"
            case css_file = "css_file"
            case timezone = "timezone"
            case referrer = "referrer"
            case ref_user_id = "ref_user_id"
            case balance = "balance"
            case paypal_email = "paypal_email"
            case notifications_sound = "notifications_sound"
            case order_posts_by = "order_posts_by"
            case social_login = "social_login"
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
            case sidebar_data = "sidebar_data"
            case last_avatar_mod = "last_avatar_mod"
            case last_cover_mod = "last_cover_mod"
            case points = "points"
            case daily_points = "daily_points"
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
            case stripeSessionId = "StripeSessionId"
            case time_code_sent = "time_code_sent"
            case permission = "permission"
            case skills = "skills"
            case languages = "languages"
            case currently_working = "currently_working"
            case banned = "banned"
            case banned_reason = "banned_reason"
            case coinbase_hash = "coinbase_hash"
            case coinbase_code = "coinbase_code"
            case yoomoney_hash = "yoomoney_hash"
            case conversationId = "ConversationId"
            case securionpay_key = "securionpay_key"
            case fortumo_hash = "fortumo_hash"
            case aamarpay_tran_id = "aamarpay_tran_id"
            case ngenius_ref = "ngenius_ref"
            case coinpayments_txn_id = "coinpayments_txn_id"
            case avatar_post_id = "avatar_post_id"
            case cover_post_id = "cover_post_id"
            case avatar_org = "avatar_org"
            case cover_org = "cover_org"
            case cover_full = "cover_full"
            case avatar_full = "avatar_full"
            case id = "id"
            case user_platform = "user_platform"
            case url = "url"
            case name = "name"
            case api_notification_settings = "API_notification_settings"
            case is_notify_stopped = "is_notify_stopped"
            case following_data = "following_data"
            case followers_data = "followers_data"
            case mutual_friends_data = "mutual_friends_data"
            case likes_data = "likes_data"
            case groups_data = "groups_data"
            case album_data = "album_data"
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
            case family_member = "family_member"
            case is_following = "is_following"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
            username = try values.decodeIfPresent(String.self, forKey: .username)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
            last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
            avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
            cover = try values.decodeIfPresent(String.self, forKey: .cover)
            background_image = try values.decodeIfPresent(String.self, forKey: .background_image)
            background_image_status = try values.decodeIfPresent(String.self, forKey: .background_image_status)
            relationship_id = try values.decodeIfPresent(String.self, forKey: .relationship_id)
            address = try values.decodeIfPresent(String.self, forKey: .address)
            working = try values.decodeIfPresent(String.self, forKey: .working)
            working_link = try values.decodeIfPresent(String.self, forKey: .working_link)
            about = try values.decodeIfPresent(String.self, forKey: .about)
            school = try values.decodeIfPresent(String.self, forKey: .school)
            gender = try values.decodeIfPresent(String.self, forKey: .gender)
            birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
            country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
            website = try values.decodeIfPresent(String.self, forKey: .website)
            facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
            google = try values.decodeIfPresent(String.self, forKey: .google)
            twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
            linkedin = try values.decodeIfPresent(String.self, forKey: .linkedin)
            youtube = try values.decodeIfPresent(String.self, forKey: .youtube)
            vk = try values.decodeIfPresent(String.self, forKey: .vk)
            instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
            qq = try values.decodeIfPresent(String.self, forKey: .qq)
            wechat = try values.decodeIfPresent(String.self, forKey: .wechat)
            discord = try values.decodeIfPresent(String.self, forKey: .discord)
            mailru = try values.decodeIfPresent(String.self, forKey: .mailru)
            okru = try values.decodeIfPresent(String.self, forKey: .okru)
            language = try values.decodeIfPresent(String.self, forKey: .language)
            email_code = try values.decodeIfPresent(String.self, forKey: .email_code)
            src = try values.decodeIfPresent(String.self, forKey: .src)
            ip_address = try values.decodeIfPresent(String.self, forKey: .ip_address)
            follow_privacy = try values.decodeIfPresent(String.self, forKey: .follow_privacy)
            friend_privacy = try values.decodeIfPresent(String.self, forKey: .friend_privacy)
            post_privacy = try values.decodeIfPresent(String.self, forKey: .post_privacy)
            message_privacy = try values.decodeIfPresent(String.self, forKey: .message_privacy)
            confirm_followers = try values.decodeIfPresent(String.self, forKey: .confirm_followers)
            show_activities_privacy = try values.decodeIfPresent(String.self, forKey: .show_activities_privacy)
            birthPrivacy = try values.decodeIfPresent(String.self, forKey: .birthPrivacy)
            visit_privacy = try values.decodeIfPresent(String.self, forKey: .visit_privacy)
            verified = try values.decodeIfPresent(String.self, forKey: .verified)
            lastseen = try values.decodeIfPresent(String.self, forKey: .lastseen)
            showlastseen = try values.decodeIfPresent(String.self, forKey: .showlastseen)
            emailNotification = try values.decodeIfPresent(String.self, forKey: .emailNotification)
            e_liked = try values.decodeIfPresent(String.self, forKey: .e_liked)
            e_wondered = try values.decodeIfPresent(String.self, forKey: .e_wondered)
            e_shared = try values.decodeIfPresent(String.self, forKey: .e_shared)
            e_followed = try values.decodeIfPresent(String.self, forKey: .e_followed)
            e_commented = try values.decodeIfPresent(String.self, forKey: .e_commented)
            e_visited = try values.decodeIfPresent(String.self, forKey: .e_visited)
            e_liked_page = try values.decodeIfPresent(String.self, forKey: .e_liked_page)
            e_mentioned = try values.decodeIfPresent(String.self, forKey: .e_mentioned)
            e_joined_group = try values.decodeIfPresent(String.self, forKey: .e_joined_group)
            e_accepted = try values.decodeIfPresent(String.self, forKey: .e_accepted)
            e_profile_wall_post = try values.decodeIfPresent(String.self, forKey: .e_profile_wall_post)
            e_sentme_msg = try values.decodeIfPresent(String.self, forKey: .e_sentme_msg)
            e_last_notif = try values.decodeIfPresent(String.self, forKey: .e_last_notif)
            notification_settings = try values.decodeIfPresent(String.self, forKey: .notification_settings)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            active = try values.decodeIfPresent(String.self, forKey: .active)
            admin = try values.decodeIfPresent(String.self, forKey: .admin)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            registered = try values.decodeIfPresent(String.self, forKey: .registered)
            start_up = try values.decodeIfPresent(String.self, forKey: .start_up)
            start_up_info = try values.decodeIfPresent(String.self, forKey: .start_up_info)
            startup_follow = try values.decodeIfPresent(String.self, forKey: .startup_follow)
            startup_image = try values.decodeIfPresent(String.self, forKey: .startup_image)
            last_email_sent = try values.decodeIfPresent(String.self, forKey: .last_email_sent)
            phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
            sms_code = try values.decodeIfPresent(String.self, forKey: .sms_code)
            is_pro = try values.decodeIfPresent(String.self, forKey: .is_pro)
            pro_time = try values.decodeIfPresent(String.self, forKey: .pro_time)
            pro_type = try values.decodeIfPresent(String.self, forKey: .pro_type)
            joined = try values.decodeIfPresent(String.self, forKey: .joined)
            css_file = try values.decodeIfPresent(String.self, forKey: .css_file)
            timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
            referrer = try values.decodeIfPresent(String.self, forKey: .referrer)
            ref_user_id = try values.decodeIfPresent(String.self, forKey: .ref_user_id)
            balance = try values.decodeIfPresent(String.self, forKey: .balance)
            paypal_email = try values.decodeIfPresent(String.self, forKey: .paypal_email)
            notifications_sound = try values.decodeIfPresent(String.self, forKey: .notifications_sound)
            order_posts_by = try values.decodeIfPresent(String.self, forKey: .order_posts_by)
            social_login = try values.decodeIfPresent(String.self, forKey: .social_login)
            android_m_device_id = try values.decodeIfPresent(String.self, forKey: .android_m_device_id)
            ios_m_device_id = try values.decodeIfPresent(String.self, forKey: .ios_m_device_id)
            android_n_device_id = try values.decodeIfPresent(String.self, forKey: .android_n_device_id)
            ios_n_device_id = try values.decodeIfPresent(String.self, forKey: .ios_n_device_id)
            web_device_id = try values.decodeIfPresent(String.self, forKey: .web_device_id)
            wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
            lat = try values.decodeIfPresent(String.self, forKey: .lat)
            lng = try values.decodeIfPresent(String.self, forKey: .lng)
            last_location_update = try values.decodeIfPresent(String.self, forKey: .last_location_update)
            share_my_location = try values.decodeIfPresent(String.self, forKey: .share_my_location)
            last_data_update = try values.decodeIfPresent(String.self, forKey: .last_data_update)
            details = try values.decodeIfPresent(Details.self, forKey: .details)
            sidebar_data = try values.decodeIfPresent(String.self, forKey: .sidebar_data)
            last_avatar_mod = try values.decodeIfPresent(String.self, forKey: .last_avatar_mod)
            last_cover_mod = try values.decodeIfPresent(String.self, forKey: .last_cover_mod)
            points = try values.decodeIfPresent(String.self, forKey: .points)
            daily_points = try values.decodeIfPresent(String.self, forKey: .daily_points)
            point_day_expire = try values.decodeIfPresent(String.self, forKey: .point_day_expire)
            last_follow_id = try values.decodeIfPresent(String.self, forKey: .last_follow_id)
            share_my_data = try values.decodeIfPresent(String.self, forKey: .share_my_data)
            last_login_data = try values.decodeIfPresent(String.self, forKey: .last_login_data)
            two_factor = try values.decodeIfPresent(String.self, forKey: .two_factor)
            two_factor_hash = try values.decodeIfPresent(String.self, forKey: .two_factor_hash)
            new_email = try values.decodeIfPresent(String.self, forKey: .new_email)
            two_factor_verified = try values.decodeIfPresent(String.self, forKey: .two_factor_verified)
            new_phone = try values.decodeIfPresent(String.self, forKey: .new_phone)
            info_file = try values.decodeIfPresent(String.self, forKey: .info_file)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            state = try values.decodeIfPresent(String.self, forKey: .state)
            zip = try values.decodeIfPresent(String.self, forKey: .zip)
            school_completed = try values.decodeIfPresent(String.self, forKey: .school_completed)
            weather_unit = try values.decodeIfPresent(String.self, forKey: .weather_unit)
            paystack_ref = try values.decodeIfPresent(String.self, forKey: .paystack_ref)
            code_sent = try values.decodeIfPresent(String.self, forKey: .code_sent)
            stripeSessionId = try values.decodeIfPresent(String.self, forKey: .stripeSessionId)
            time_code_sent = try values.decodeIfPresent(String.self, forKey: .time_code_sent)
            permission = try values.decodeIfPresent(String.self, forKey: .permission)
            skills = try values.decodeIfPresent(String.self, forKey: .skills)
            languages = try values.decodeIfPresent(String.self, forKey: .languages)
            currently_working = try values.decodeIfPresent(String.self, forKey: .currently_working)
            banned = try values.decodeIfPresent(String.self, forKey: .banned)
            banned_reason = try values.decodeIfPresent(String.self, forKey: .banned_reason)
            coinbase_hash = try values.decodeIfPresent(String.self, forKey: .coinbase_hash)
            coinbase_code = try values.decodeIfPresent(String.self, forKey: .coinbase_code)
            yoomoney_hash = try values.decodeIfPresent(String.self, forKey: .yoomoney_hash)
            conversationId = try values.decodeIfPresent(String.self, forKey: .conversationId)
            securionpay_key = try values.decodeIfPresent(String.self, forKey: .securionpay_key)
            fortumo_hash = try values.decodeIfPresent(String.self, forKey: .fortumo_hash)
            aamarpay_tran_id = try values.decodeIfPresent(String.self, forKey: .aamarpay_tran_id)
            ngenius_ref = try values.decodeIfPresent(String.self, forKey: .ngenius_ref)
            coinpayments_txn_id = try values.decodeIfPresent(String.self, forKey: .coinpayments_txn_id)
            avatar_post_id = try values.decodeIfPresent(String.self, forKey: .avatar_post_id)
            cover_post_id = try values.decodeIfPresent(Int.self, forKey: .cover_post_id)
            avatar_org = try values.decodeIfPresent(String.self, forKey: .avatar_org)
            cover_org = try values.decodeIfPresent(String.self, forKey: .cover_org)
            cover_full = try values.decodeIfPresent(String.self, forKey: .cover_full)
            avatar_full = try values.decodeIfPresent(String.self, forKey: .avatar_full)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            user_platform = try values.decodeIfPresent(String.self, forKey: .user_platform)
            url = try values.decodeIfPresent(String.self, forKey: .url)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            api_notification_settings = try values.decodeIfPresent(APINotificationSettings.self, forKey: .api_notification_settings)
            is_notify_stopped = try values.decodeIfPresent(Int.self, forKey: .is_notify_stopped)
            following_data = try values.decodeIfPresent([String].self, forKey: .following_data)
            followers_data = try values.decodeIfPresent([String].self, forKey: .followers_data)
            mutual_friends_data = try values.decodeIfPresent(String.self, forKey: .mutual_friends_data)
            likes_data = try values.decodeIfPresent(String.self, forKey: .likes_data)
            groups_data = try values.decodeIfPresent([String].self, forKey: .groups_data)
            album_data = try values.decodeIfPresent(String.self, forKey: .album_data)
            lastseen_unix_time = try values.decodeIfPresent(String.self, forKey: .lastseen_unix_time)
            lastseen_status = try values.decodeIfPresent(String.self, forKey: .lastseen_status)
            is_reported = try values.decodeIfPresent(Bool.self, forKey: .is_reported)
            is_story_muted = try values.decodeIfPresent(Bool.self, forKey: .is_story_muted)
            is_following_me = try values.decodeIfPresent(Int.self, forKey: .is_following_me)
            is_reported_user = try values.decodeIfPresent(Int.self, forKey: .is_reported_user)
            is_open_to_work = try values.decodeIfPresent(Int.self, forKey: .is_open_to_work)
            is_providing_service = try values.decodeIfPresent(Int.self, forKey: .is_providing_service)
            providing_service = try values.decodeIfPresent(Int.self, forKey: .providing_service)
            open_to_work_data = try values.decodeIfPresent(String.self, forKey: .open_to_work_data)
            formated_langs = try values.decodeIfPresent([String].self, forKey: .formated_langs)
            family_member = try values.decodeIfPresent(String.self, forKey: .family_member)
            is_following = try values.decodeIfPresent(Int.self, forKey: .is_following)
        }
    }
    
    struct Followers : Codable {
        let user_id : String?
        let username : String?
        let email : String?
        let first_name : String?
        let last_name : String?
        let avatar : String?
        let cover : String?
        let background_image : String?
        let background_image_status : String?
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
        let email_code : String?
        let src : String?
        let ip_address : String?
        let follow_privacy : String?
        let friend_privacy : String?
        let post_privacy : String?
        let message_privacy : String?
        let confirm_followers : String?
        let show_activities_privacy : String?
        let birthPrivacy : String?
        let visit_privacy : String?
        let verified : String?
        let lastseen : String?
        let showlastseen : String?
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
        let type : String?
        let registered : String?
        let start_up : String?
        let start_up_info : String?
        let startup_follow : String?
        let startup_image : String?
        let last_email_sent : String?
        let phone_number : String?
        let sms_code : String?
        let is_pro : String?
        let pro_time : String?
        let pro_type : String?
        let joined : String?
        let css_file : String?
        let timezone : String?
        let referrer : String?
        let ref_user_id : String?
        let balance : String?
        let paypal_email : String?
        let notifications_sound : String?
        let order_posts_by : String?
        let social_login : String?
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
        let sidebar_data : String?
        let last_avatar_mod : String?
        let last_cover_mod : String?
        let points : String?
        let daily_points : String?
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
        let stripeSessionId : String?
        let time_code_sent : String?
        let permission : String?
        let skills : String?
        let languages : String?
        let currently_working : String?
        let banned : String?
        let banned_reason : String?
        let coinbase_hash : String?
        let coinbase_code : String?
        let yoomoney_hash : String?
        let conversationId : String?
        let securionpay_key : String?
        let fortumo_hash : String?
        let aamarpay_tran_id : String?
        let ngenius_ref : String?
        let coinpayments_txn_id : String?
        let avatar_post_id : String?
        let cover_post_id : Int?
        let avatar_org : String?
        let cover_org : String?
        let cover_full : String?
        let avatar_full : String?
        let id : String?
        let user_platform : String?
        let url : String?
        let name : String?
        let api_notification_settings : APINotificationSettings?
        let is_notify_stopped : Int?
        let following_data : [String]?
        let followers_data : String?
        let mutual_friends_data : [String]?
        let likes_data : String?
        let groups_data : String?
        let album_data : String?
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
        let family_member : String?
        let is_following : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case user_id = "user_id"
            case username = "username"
            case email = "email"
            case first_name = "first_name"
            case last_name = "last_name"
            case avatar = "avatar"
            case cover = "cover"
            case background_image = "background_image"
            case background_image_status = "background_image_status"
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
            case email_code = "email_code"
            case src = "src"
            case ip_address = "ip_address"
            case follow_privacy = "follow_privacy"
            case friend_privacy = "friend_privacy"
            case post_privacy = "post_privacy"
            case message_privacy = "message_privacy"
            case confirm_followers = "confirm_followers"
            case show_activities_privacy = "show_activities_privacy"
            case birthPrivacy = "birth_privacy"
            case visit_privacy = "visit_privacy"
            case verified = "verified"
            case lastseen = "lastseen"
            case showlastseen = "showlastseen"
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
            case type = "type"
            case registered = "registered"
            case start_up = "start_up"
            case start_up_info = "start_up_info"
            case startup_follow = "startup_follow"
            case startup_image = "startup_image"
            case last_email_sent = "last_email_sent"
            case phone_number = "phone_number"
            case sms_code = "sms_code"
            case is_pro = "is_pro"
            case pro_time = "pro_time"
            case pro_type = "pro_type"
            case joined = "joined"
            case css_file = "css_file"
            case timezone = "timezone"
            case referrer = "referrer"
            case ref_user_id = "ref_user_id"
            case balance = "balance"
            case paypal_email = "paypal_email"
            case notifications_sound = "notifications_sound"
            case order_posts_by = "order_posts_by"
            case social_login = "social_login"
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
            case sidebar_data = "sidebar_data"
            case last_avatar_mod = "last_avatar_mod"
            case last_cover_mod = "last_cover_mod"
            case points = "points"
            case daily_points = "daily_points"
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
            case stripeSessionId = "StripeSessionId"
            case time_code_sent = "time_code_sent"
            case permission = "permission"
            case skills = "skills"
            case languages = "languages"
            case currently_working = "currently_working"
            case banned = "banned"
            case banned_reason = "banned_reason"
            case coinbase_hash = "coinbase_hash"
            case coinbase_code = "coinbase_code"
            case yoomoney_hash = "yoomoney_hash"
            case conversationId = "ConversationId"
            case securionpay_key = "securionpay_key"
            case fortumo_hash = "fortumo_hash"
            case aamarpay_tran_id = "aamarpay_tran_id"
            case ngenius_ref = "ngenius_ref"
            case coinpayments_txn_id = "coinpayments_txn_id"
            case avatar_post_id = "avatar_post_id"
            case cover_post_id = "cover_post_id"
            case avatar_org = "avatar_org"
            case cover_org = "cover_org"
            case cover_full = "cover_full"
            case avatar_full = "avatar_full"
            case id = "id"
            case user_platform = "user_platform"
            case url = "url"
            case name = "name"
            case api_notification_settings = "API_notification_settings"
            case is_notify_stopped = "is_notify_stopped"
            case following_data = "following_data"
            case followers_data = "followers_data"
            case mutual_friends_data = "mutual_friends_data"
            case likes_data = "likes_data"
            case groups_data = "groups_data"
            case album_data = "album_data"
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
            case family_member = "family_member"
            case is_following = "is_following"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
            username = try values.decodeIfPresent(String.self, forKey: .username)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
            last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
            avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
            cover = try values.decodeIfPresent(String.self, forKey: .cover)
            background_image = try values.decodeIfPresent(String.self, forKey: .background_image)
            background_image_status = try values.decodeIfPresent(String.self, forKey: .background_image_status)
            relationship_id = try values.decodeIfPresent(String.self, forKey: .relationship_id)
            address = try values.decodeIfPresent(String.self, forKey: .address)
            working = try values.decodeIfPresent(String.self, forKey: .working)
            working_link = try values.decodeIfPresent(String.self, forKey: .working_link)
            about = try values.decodeIfPresent(String.self, forKey: .about)
            school = try values.decodeIfPresent(String.self, forKey: .school)
            gender = try values.decodeIfPresent(String.self, forKey: .gender)
            birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
            country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
            website = try values.decodeIfPresent(String.self, forKey: .website)
            facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
            google = try values.decodeIfPresent(String.self, forKey: .google)
            twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
            linkedin = try values.decodeIfPresent(String.self, forKey: .linkedin)
            youtube = try values.decodeIfPresent(String.self, forKey: .youtube)
            vk = try values.decodeIfPresent(String.self, forKey: .vk)
            instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
            qq = try values.decodeIfPresent(String.self, forKey: .qq)
            wechat = try values.decodeIfPresent(String.self, forKey: .wechat)
            discord = try values.decodeIfPresent(String.self, forKey: .discord)
            mailru = try values.decodeIfPresent(String.self, forKey: .mailru)
            okru = try values.decodeIfPresent(String.self, forKey: .okru)
            language = try values.decodeIfPresent(String.self, forKey: .language)
            email_code = try values.decodeIfPresent(String.self, forKey: .email_code)
            src = try values.decodeIfPresent(String.self, forKey: .src)
            ip_address = try values.decodeIfPresent(String.self, forKey: .ip_address)
            follow_privacy = try values.decodeIfPresent(String.self, forKey: .follow_privacy)
            friend_privacy = try values.decodeIfPresent(String.self, forKey: .friend_privacy)
            post_privacy = try values.decodeIfPresent(String.self, forKey: .post_privacy)
            message_privacy = try values.decodeIfPresent(String.self, forKey: .message_privacy)
            confirm_followers = try values.decodeIfPresent(String.self, forKey: .confirm_followers)
            show_activities_privacy = try values.decodeIfPresent(String.self, forKey: .show_activities_privacy)
            birthPrivacy = try values.decodeIfPresent(String.self, forKey: .birthPrivacy)
            visit_privacy = try values.decodeIfPresent(String.self, forKey: .visit_privacy)
            verified = try values.decodeIfPresent(String.self, forKey: .verified)
            lastseen = try values.decodeIfPresent(String.self, forKey: .lastseen)
            showlastseen = try values.decodeIfPresent(String.self, forKey: .showlastseen)
            emailNotification = try values.decodeIfPresent(String.self, forKey: .emailNotification)
            e_liked = try values.decodeIfPresent(String.self, forKey: .e_liked)
            e_wondered = try values.decodeIfPresent(String.self, forKey: .e_wondered)
            e_shared = try values.decodeIfPresent(String.self, forKey: .e_shared)
            e_followed = try values.decodeIfPresent(String.self, forKey: .e_followed)
            e_commented = try values.decodeIfPresent(String.self, forKey: .e_commented)
            e_visited = try values.decodeIfPresent(String.self, forKey: .e_visited)
            e_liked_page = try values.decodeIfPresent(String.self, forKey: .e_liked_page)
            e_mentioned = try values.decodeIfPresent(String.self, forKey: .e_mentioned)
            e_joined_group = try values.decodeIfPresent(String.self, forKey: .e_joined_group)
            e_accepted = try values.decodeIfPresent(String.self, forKey: .e_accepted)
            e_profile_wall_post = try values.decodeIfPresent(String.self, forKey: .e_profile_wall_post)
            e_sentme_msg = try values.decodeIfPresent(String.self, forKey: .e_sentme_msg)
            e_last_notif = try values.decodeIfPresent(String.self, forKey: .e_last_notif)
            notification_settings = try values.decodeIfPresent(String.self, forKey: .notification_settings)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            active = try values.decodeIfPresent(String.self, forKey: .active)
            admin = try values.decodeIfPresent(String.self, forKey: .admin)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            registered = try values.decodeIfPresent(String.self, forKey: .registered)
            start_up = try values.decodeIfPresent(String.self, forKey: .start_up)
            start_up_info = try values.decodeIfPresent(String.self, forKey: .start_up_info)
            startup_follow = try values.decodeIfPresent(String.self, forKey: .startup_follow)
            startup_image = try values.decodeIfPresent(String.self, forKey: .startup_image)
            last_email_sent = try values.decodeIfPresent(String.self, forKey: .last_email_sent)
            phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
            sms_code = try values.decodeIfPresent(String.self, forKey: .sms_code)
            is_pro = try values.decodeIfPresent(String.self, forKey: .is_pro)
            pro_time = try values.decodeIfPresent(String.self, forKey: .pro_time)
            pro_type = try values.decodeIfPresent(String.self, forKey: .pro_type)
            joined = try values.decodeIfPresent(String.self, forKey: .joined)
            css_file = try values.decodeIfPresent(String.self, forKey: .css_file)
            timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
            referrer = try values.decodeIfPresent(String.self, forKey: .referrer)
            ref_user_id = try values.decodeIfPresent(String.self, forKey: .ref_user_id)
            balance = try values.decodeIfPresent(String.self, forKey: .balance)
            paypal_email = try values.decodeIfPresent(String.self, forKey: .paypal_email)
            notifications_sound = try values.decodeIfPresent(String.self, forKey: .notifications_sound)
            order_posts_by = try values.decodeIfPresent(String.self, forKey: .order_posts_by)
            social_login = try values.decodeIfPresent(String.self, forKey: .social_login)
            android_m_device_id = try values.decodeIfPresent(String.self, forKey: .android_m_device_id)
            ios_m_device_id = try values.decodeIfPresent(String.self, forKey: .ios_m_device_id)
            android_n_device_id = try values.decodeIfPresent(String.self, forKey: .android_n_device_id)
            ios_n_device_id = try values.decodeIfPresent(String.self, forKey: .ios_n_device_id)
            web_device_id = try values.decodeIfPresent(String.self, forKey: .web_device_id)
            wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
            lat = try values.decodeIfPresent(String.self, forKey: .lat)
            lng = try values.decodeIfPresent(String.self, forKey: .lng)
            last_location_update = try values.decodeIfPresent(String.self, forKey: .last_location_update)
            share_my_location = try values.decodeIfPresent(String.self, forKey: .share_my_location)
            last_data_update = try values.decodeIfPresent(String.self, forKey: .last_data_update)
            details = try values.decodeIfPresent(Details.self, forKey: .details)
            sidebar_data = try values.decodeIfPresent(String.self, forKey: .sidebar_data)
            last_avatar_mod = try values.decodeIfPresent(String.self, forKey: .last_avatar_mod)
            last_cover_mod = try values.decodeIfPresent(String.self, forKey: .last_cover_mod)
            points = try values.decodeIfPresent(String.self, forKey: .points)
            daily_points = try values.decodeIfPresent(String.self, forKey: .daily_points)
            point_day_expire = try values.decodeIfPresent(String.self, forKey: .point_day_expire)
            last_follow_id = try values.decodeIfPresent(String.self, forKey: .last_follow_id)
            share_my_data = try values.decodeIfPresent(String.self, forKey: .share_my_data)
            last_login_data = try values.decodeIfPresent(String.self, forKey: .last_login_data)
            two_factor = try values.decodeIfPresent(String.self, forKey: .two_factor)
            two_factor_hash = try values.decodeIfPresent(String.self, forKey: .two_factor_hash)
            new_email = try values.decodeIfPresent(String.self, forKey: .new_email)
            two_factor_verified = try values.decodeIfPresent(String.self, forKey: .two_factor_verified)
            new_phone = try values.decodeIfPresent(String.self, forKey: .new_phone)
            info_file = try values.decodeIfPresent(String.self, forKey: .info_file)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            state = try values.decodeIfPresent(String.self, forKey: .state)
            zip = try values.decodeIfPresent(String.self, forKey: .zip)
            school_completed = try values.decodeIfPresent(String.self, forKey: .school_completed)
            weather_unit = try values.decodeIfPresent(String.self, forKey: .weather_unit)
            paystack_ref = try values.decodeIfPresent(String.self, forKey: .paystack_ref)
            code_sent = try values.decodeIfPresent(String.self, forKey: .code_sent)
            stripeSessionId = try values.decodeIfPresent(String.self, forKey: .stripeSessionId)
            time_code_sent = try values.decodeIfPresent(String.self, forKey: .time_code_sent)
            permission = try values.decodeIfPresent(String.self, forKey: .permission)
            skills = try values.decodeIfPresent(String.self, forKey: .skills)
            languages = try values.decodeIfPresent(String.self, forKey: .languages)
            currently_working = try values.decodeIfPresent(String.self, forKey: .currently_working)
            banned = try values.decodeIfPresent(String.self, forKey: .banned)
            banned_reason = try values.decodeIfPresent(String.self, forKey: .banned_reason)
            coinbase_hash = try values.decodeIfPresent(String.self, forKey: .coinbase_hash)
            coinbase_code = try values.decodeIfPresent(String.self, forKey: .coinbase_code)
            yoomoney_hash = try values.decodeIfPresent(String.self, forKey: .yoomoney_hash)
            conversationId = try values.decodeIfPresent(String.self, forKey: .conversationId)
            securionpay_key = try values.decodeIfPresent(String.self, forKey: .securionpay_key)
            fortumo_hash = try values.decodeIfPresent(String.self, forKey: .fortumo_hash)
            aamarpay_tran_id = try values.decodeIfPresent(String.self, forKey: .aamarpay_tran_id)
            ngenius_ref = try values.decodeIfPresent(String.self, forKey: .ngenius_ref)
            coinpayments_txn_id = try values.decodeIfPresent(String.self, forKey: .coinpayments_txn_id)
            avatar_post_id = try values.decodeIfPresent(String.self, forKey: .avatar_post_id)
            cover_post_id = try values.decodeIfPresent(Int.self, forKey: .cover_post_id)
            avatar_org = try values.decodeIfPresent(String.self, forKey: .avatar_org)
            cover_org = try values.decodeIfPresent(String.self, forKey: .cover_org)
            cover_full = try values.decodeIfPresent(String.self, forKey: .cover_full)
            avatar_full = try values.decodeIfPresent(String.self, forKey: .avatar_full)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            user_platform = try values.decodeIfPresent(String.self, forKey: .user_platform)
            url = try values.decodeIfPresent(String.self, forKey: .url)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            api_notification_settings = try values.decodeIfPresent(APINotificationSettings.self, forKey: .api_notification_settings)
            is_notify_stopped = try values.decodeIfPresent(Int.self, forKey: .is_notify_stopped)
            following_data = try values.decodeIfPresent([String].self, forKey: .following_data)
            followers_data = try values.decodeIfPresent(String.self, forKey: .followers_data)
            mutual_friends_data = try values.decodeIfPresent([String].self, forKey: .mutual_friends_data)
            likes_data = try values.decodeIfPresent(String.self, forKey: .likes_data)
            groups_data = try values.decodeIfPresent(String.self, forKey: .groups_data)
            album_data = try values.decodeIfPresent(String.self, forKey: .album_data)
            lastseen_unix_time = try values.decodeIfPresent(String.self, forKey: .lastseen_unix_time)
            lastseen_status = try values.decodeIfPresent(String.self, forKey: .lastseen_status)
            is_reported = try values.decodeIfPresent(Bool.self, forKey: .is_reported)
            is_story_muted = try values.decodeIfPresent(Bool.self, forKey: .is_story_muted)
            is_following_me = try values.decodeIfPresent(Int.self, forKey: .is_following_me)
            is_reported_user = try values.decodeIfPresent(Int.self, forKey: .is_reported_user)
            is_open_to_work = try values.decodeIfPresent(Int.self, forKey: .is_open_to_work)
            is_providing_service = try values.decodeIfPresent(Int.self, forKey: .is_providing_service)
            providing_service = try values.decodeIfPresent(Int.self, forKey: .providing_service)
            open_to_work_data = try values.decodeIfPresent(String.self, forKey: .open_to_work_data)
            formated_langs = try values.decodeIfPresent([String].self, forKey: .formated_langs)
            family_member = try values.decodeIfPresent(String.self, forKey: .family_member)
            is_following = try values.decodeIfPresent(Int.self, forKey: .is_following)
        }
    }
    
    struct LastLogin: Codable {
        
        var status : String?   /// "success"
        var country : String?   /// "Palestine"
        var countryCode : String?   /// "PS"
        var region : String?   /// "GZA"
        var regionName : String?   /// "Gaza"
        var city : String?   /// "Gaza"
        var zip : String?   /// ""
        var lat : Double?   /// 31.50189999999999912461134954355657100677490234375
        var lon : Double?   /// 34.466599999999999681676854379475116729736328125
        var timezone : String?   /// "Asia\\/Gaza"
        var isp : String?   /// "AGIS"
        var org : String?   /// "Digital Communication ltd."
        var asStr : String?   /// "AS44213 Thaer A. T. Abuyousef trading as Abuyousef Co & Partners For General Trade"
        var query : String?   /// "206.62.147.23"
            
        enum CodingKeys: String, CodingKey {
            case status = "status"
            case country = "country"
            case countryCode = "countryCode"
            case region = "region"
            case regionName = "regionName"
            case city = "city"
            case zip = "zip"
            case lat = "lat"
            case lon = "lon"
            case timezone = "timezone"
            case isp = "isp"
            case org = "org"
            case asStr = "as"
            case query = "query"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            country = try values.decodeIfPresent(String.self, forKey: .country)
            countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
            region = try values.decodeIfPresent(String.self, forKey: .region)
            regionName = try values.decodeIfPresent(String.self, forKey: .regionName)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            zip = try values.decodeIfPresent(String.self, forKey: .zip)
            lat = try values.decodeIfPresent(Double.self, forKey: .lat)
            lon = try values.decodeIfPresent(Double.self, forKey: .lon)
            timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
            isp = try values.decodeIfPresent(String.self, forKey: .isp)
            org = try values.decodeIfPresent(String.self, forKey: .org)
            asStr = try values.decodeIfPresent(String.self, forKey: .asStr)
            query = try values.decodeIfPresent(String.self, forKey: .query)
        }
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userDataResponse = try? newJSONDecoder().decode(UserDataResponse.self, from: jsonData)

import Foundation

// MARK: - UserDataResponse
struct UserDataResponse: Codable {
    var userData: UserModel?
    
    enum CodingKeys: String, CodingKey {
        case userData = "user_data"
    }
}

// MARK: - UserData
struct UserData: Codable {
    var userID, username, email, firstName: String?
    var lastName: String?
    var avatar, cover: String?
    var backgroundImage, relationshipID, address, working: String?
    var workingLink, about, school, gender: String?
    var birthday, countryID, website, facebook: String?
    var google, twitter, linkedin, youtube: String?
    var vk, instagram: String?
    var qq, wechat, discord, mailru: JSONNull?
    var okru, language, ipAddress, followPrivacy: String?
    var friendPrivacy, postPrivacy, messagePrivacy, confirmFollowers: String?
    var showActivitiesPrivacy, birthPrivacy, visitPrivacy, verified: String?
    var lastseen, emailNotification, eLiked, eWondered: String?
    var eShared, eFollowed, eCommented, eVisited: String?
    var eLikedPage, eMentioned, eJoinedGroup, eAccepted: String?
    var eProfileWallPost, eSentmeMsg, eLastNotif, notificationSettings: String?
    var status, active, admin, registered: String?
    var phoneNumber, isPro, proType, timezone: String?
    var referrer, refUserID, balance, paypalEmail: String?
    var notificationsSound, orderPostsBy, androidMDeviceID, iosMDeviceID: String?
    var androidNDeviceID, iosNDeviceID, webDeviceID, wallet: String?
    var lat, lng, lastLocationUpdate, shareMyLocation: String?
    var lastDataUpdate: String?
    var details: UserDataDetails?
    var lastAvatarMod, lastCoverMod, points, dailyPoints: String?
    var pointDayExpire, lastFollowID, shareMyData, lastLoginData: String?
    var twoFactor, twoFactorHash, newEmail, twoFactorVerified: String?
    var newPhone, infoFile, city, state: String?
    var zip, schoolCompleted, weatherUnit, paystackRef: String?
    var codeSent: String?
    var stripeSessionID: JSONNull?
    var timeCodeSent: String?
    var permission, skills, languages: JSONNull?
    var currentlyWorking, banned, bannedReason, coinbaseHash: String?
    var coinbaseCode, yoomoneyHash, conversationID, securionpayKey: String?
    var fortumoHash, aamarpayTranID, ngeniusRef, coinpaymentsTxnID: String?
    var avatarPostID, coverPostID: Int?
    var avatarFull, userPlatform: String?
    var url: String?
    var name: String?
    var apiNotificationSettings: APINotificationSettings?
    var isNotifyStopped: Int?
    var mutualFriendsData: [String]?
    var lastseenUnixTime, lastseenStatus: String?
    var isReported, isStoryMuted: Bool?
    var isFollowingMe, isReportedUser, isOpenToWork, isProvidingService: Int?
    var providingService: Int?
    var openToWorkData: String?
    var formatedLangs: [JSONAny]?
    var isFollowing, canFollow: Int?
    var genderText, lastseenTimeText: String?
    var isBlocked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar, cover
        case backgroundImage = "background_image"
        case relationshipID = "relationship_id"
        case address, working
        case workingLink = "working_link"
        case about, school, gender, birthday
        case countryID = "country_id"
        case website, facebook, google, twitter, linkedin, youtube, vk, instagram, qq, wechat, discord, mailru, okru, language
        case ipAddress = "ip_address"
        case followPrivacy = "follow_privacy"
        case friendPrivacy = "friend_privacy"
        case postPrivacy = "post_privacy"
        case messagePrivacy = "message_privacy"
        case confirmFollowers = "confirm_followers"
        case showActivitiesPrivacy = "show_activities_privacy"
        case birthPrivacy = "birth_privacy"
        case visitPrivacy = "visit_privacy"
        case verified, lastseen, emailNotification
        case eLiked = "e_liked"
        case eWondered = "e_wondered"
        case eShared = "e_shared"
        case eFollowed = "e_followed"
        case eCommented = "e_commented"
        case eVisited = "e_visited"
        case eLikedPage = "e_liked_page"
        case eMentioned = "e_mentioned"
        case eJoinedGroup = "e_joined_group"
        case eAccepted = "e_accepted"
        case eProfileWallPost = "e_profile_wall_post"
        case eSentmeMsg = "e_sentme_msg"
        case eLastNotif = "e_last_notif"
        case notificationSettings = "notification_settings"
        case status, active, admin, registered
        case phoneNumber = "phone_number"
        case isPro = "is_pro"
        case proType = "pro_type"
        case timezone, referrer
        case refUserID = "ref_user_id"
        case balance
        case paypalEmail = "paypal_email"
        case notificationsSound = "notifications_sound"
        case orderPostsBy = "order_posts_by"
        case androidMDeviceID = "android_m_device_id"
        case iosMDeviceID = "ios_m_device_id"
        case androidNDeviceID = "android_n_device_id"
        case iosNDeviceID = "ios_n_device_id"
        case webDeviceID = "web_device_id"
        case wallet, lat, lng
        case lastLocationUpdate = "last_location_update"
        case shareMyLocation = "share_my_location"
        case lastDataUpdate = "last_data_update"
        case details
        case lastAvatarMod = "last_avatar_mod"
        case lastCoverMod = "last_cover_mod"
        case points
        case dailyPoints = "daily_points"
        case pointDayExpire = "point_day_expire"
        case lastFollowID = "last_follow_id"
        case shareMyData = "share_my_data"
        case lastLoginData = "last_login_data"
        case twoFactor = "two_factor"
        case twoFactorHash = "two_factor_hash"
        case newEmail = "new_email"
        case twoFactorVerified = "two_factor_verified"
        case newPhone = "new_phone"
        case infoFile = "info_file"
        case city, state, zip
        case schoolCompleted = "school_completed"
        case weatherUnit = "weather_unit"
        case paystackRef = "paystack_ref"
        case codeSent = "code_sent"
        case stripeSessionID = "StripeSessionId"
        case timeCodeSent = "time_code_sent"
        case permission, skills, languages
        case currentlyWorking = "currently_working"
        case banned
        case bannedReason = "banned_reason"
        case coinbaseHash = "coinbase_hash"
        case coinbaseCode = "coinbase_code"
        case yoomoneyHash = "yoomoney_hash"
        case conversationID = "ConversationId"
        case securionpayKey = "securionpay_key"
        case fortumoHash = "fortumo_hash"
        case aamarpayTranID = "aamarpay_tran_id"
        case ngeniusRef = "ngenius_ref"
        case coinpaymentsTxnID = "coinpayments_txn_id"
        case avatarPostID = "avatar_post_id"
        case coverPostID = "cover_post_id"
        case avatarFull = "avatar_full"
        case userPlatform = "user_platform"
        case url, name
        case apiNotificationSettings = "API_notification_settings"
        case isNotifyStopped = "is_notify_stopped"
        case mutualFriendsData = "mutual_friends_data"
        case lastseenUnixTime = "lastseen_unix_time"
        case lastseenStatus = "lastseen_status"
        case isReported = "is_reported"
        case isStoryMuted = "is_story_muted"
        case isFollowingMe = "is_following_me"
        case isReportedUser = "is_reported_user"
        case isOpenToWork = "is_open_to_work"
        case isProvidingService = "is_providing_service"
        case providingService = "providing_service"
        case openToWorkData = "open_to_work_data"
        case formatedLangs = "formated_langs"
        case isFollowing = "is_following"
        case canFollow = "can_follow"
        case genderText = "gender_text"
        case lastseenTimeText = "lastseen_time_text"
        case isBlocked = "is_blocked"
    }
}

// MARK: - Details

struct UserDataDetails: Codable {
    var postCount, albumCount, followingCount, followersCount: String?
    var groupsCount, likesCount: String?
    var mutualFriendsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case postCount = "post_count"
        case albumCount = "album_count"
        case followingCount = "following_count"
        case followersCount = "followers_count"
        case groupsCount = "groups_count"
        case likesCount = "likes_count"
        case mutualFriendsCount = "mutual_friends_count"
    }
}

struct APINotificationSettings : Codable {
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

struct Details: Codable {
    let postCount, albumCount, followingCount, followersCount: String?
    let groupsCount, likesCount: String?
    let mutualFriendsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case postCount = "post_count"
        case albumCount = "album_count"
        case followingCount = "following_count"
        case followersCount = "followers_count"
        case groupsCount = "groups_count"
        case likesCount = "likes_count"
        case mutualFriendsCount = "mutual_friends_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postCount = try values.decodeIfPresent(String.self, forKey: .postCount)
        albumCount = try values.decodeIfPresent(String.self, forKey: .albumCount)
        followingCount = try values.decodeIfPresent(String.self, forKey: .followingCount)
        followersCount = try values.decodeIfPresent(String.self, forKey: .followersCount)
        groupsCount = try values.decodeIfPresent(String.self, forKey: .groupsCount)
        likesCount = try values.decodeIfPresent(String.self, forKey: .likesCount)
        mutualFriendsCount = try values.decodeIfPresent(Int.self, forKey: .mutualFriendsCount)
    }
}
