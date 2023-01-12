
import Foundation

class BaseModel {
    
    struct ServerKeyErrorModel: Codable {
        let apiStatus: String?
        let errors: ServerKeyErrors?
        
        enum CodingKeys: String, CodingKey {
            case apiStatus = "api_status"
            case errors
        }
    }
    
    struct ServerKeyErrors: Codable {
        let  errorText: String?
        
        enum CodingKeys: String, CodingKey {
            case errorText = "error_text"
        }
    }
}

/*
{"api_status": 200,
 "user_data": {"user_id": "182951","username": "9Testing2","email": "test92@gmail.com","first_name": "","last_name": "","avatar": "https:\\/\\/wowonder.fra1.digitaloceanspaces.com\\/upload\\/photos\\/d-avatar.jpg?cache=0","cover": "https:\\/\\/wowonder.fra1.digitaloceanspaces.com\\/upload\\/photos\\/d-cover.jpg?cache=0","background_image": "","relationship_id": "0","address": "","working": "","working_link": "","about": "","school": "","gender": "male","birthday": "0000-00-00","country_id": "0","website": "","facebook": "","google": "","twitter": "","linkedin": "","youtube": "","vk": "","instagram": "","qq": null,"wechat": null,"discord": null,"mailru": null,"okru": "","language": "arabic","ip_address": "206.62.149.124","follow_privacy": "0","friend_privacy": "0","post_privacy": "ifollow","message_privacy": "0","confirm_followers": "0","show_activities_privacy": "1","birth_privacy": "0","visit_privacy": "0","verified": "0","lastseen": "1658400403","emailNotification": "1","e_liked": "1","e_wondered": "1","e_shared": "1","e_followed": "1","e_commented": "1","e_visited": "1","e_liked_page": "1","e_mentioned": "1","e_joined_group": "1","e_accepted": "1","e_profile_wall_post": "1","e_sentme_msg": "0","e_last_notif": "0","notification_settings": "{"e_liked":1,"e_shared":1,"e_wondered":0,"e_commented":1,"e_followed":1,"e_accepted":1,"e_mentioned":1,"e_joined_group":1,"e_liked_page":1,"e_visited":1,"e_profile_wall_post":1,"e_memory":1}","status": "0","active": "1","admin": "0","registered": "7\\/2022","phone_number": "","is_pro": "0","pro_type": "0","timezone": "UTC","referrer": "0","ref_user_id": "0","balance": "0","paypal_email": "","notifications_sound": "0","order_posts_by": "0","android_m_device_id": "8140e84e-6f8d-4b34-b080-0578023d6697","ios_m_device_id": "3b259ab6-215a-4950-aea2-8c62538cfe0a","android_n_device_id": "","ios_n_device_id": "","web_device_id": "","wallet": "0.00","lat": "31.5019","lng": "34.4666","last_location_update": "1658767785","share_my_location": "1","last_data_update": "1658672608","details": {    "post_count": "0",    "album_count": "0",    "following_count": "2",    "followers_count": "1",    "groups_count": "0",    "likes_count": "0",    "mutual_friends_count": 2},"last_avatar_mod": "0","last_cover_mod": "0","points": "0","daily_points": "0","point_day_expire": "","last_follow_id": "0","share_my_data": "1",
 "last_login_data": {"status":"success","country":"Palestine","countryCode":"PS","region":"GZA","regionName":"Gaza","city":"Gaza","zip":"\","lat":31.50189999999999912461134954355657100677490234375,"lon":34.466599999999999681676854379475116729736328125,"timezone":"Asia\\/Gaza","isp":"AGIS","org":"Digital Communication ltd.","as":"AS44213 Thaer A. T. Abuyousef trading as Abuyousef Co & Partners For General Trade","query":"206.62.147.23"}",
 "two_factor": "0","two_factor_hash": "","new_email": "","two_factor_verified": "0","new_phone": "","info_file": "","city": "","state": "","zip": "","school_completed": "0","weather_unit": "us","paystack_ref": "","code_sent": "0","StripeSessionId": null,"time_code_sent": "0","permission": null,"skills": null,"languages": null,"currently_working": "","banned": "0","banned_reason": "","coinbase_hash": "","coinbase_code": "","yoomoney_hash": "","ConversationId": "0","securionpay_key": "","fortumo_hash": "","aamarpay_tran_id": "","ngenius_ref": "","coinpayments_txn_id": "","avatar_post_id": 0,"cover_post_id": 0,"avatar_full": "upload\\/photos\\/d-avatar.jpg","user_platform": "phone","url": "https:\\/\\/demo.wowonder.com\\/9Testing2","name": "9Testing2","API_notification_settings": {    "e_liked": 1,    "e_shared": 1,    "e_wondered": 0,    "e_commented": 1,    "e_followed": 1,    "e_accepted": 1,    "e_mentioned": 1,    "e_joined_group": 1,    "e_liked_page": 1,    "e_visited": 1,    "e_profile_wall_post": 1,    "e_memory": 1},"is_notify_stopped": 0,"mutual_friends_data": [    "183320",    "1"],"lastseen_unix_time": "1658400403","lastseen_status": "off","is_reported": false,"is_story_muted": false,"is_following_me": 0,"is_reported_user": 0,"is_open_to_work": 0,"is_providing_service": 0,"providing_service": 0,"open_to_work_data": "","formated_langs": [],"is_following": 0,"can_follow": 1,"gender_text": "\u0630\\u0643\\u0631","lastseen_time_text": "3 \\u062f","is_blocked": false
 }}
*/
