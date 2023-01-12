
import Foundation

//class GetUserListModel: BaseModel {
//
//    struct GetUserListErrorModel: Codable {
//        let apiStatus, apiText: String?
//        let errors: Errors?
//
//        enum CodingKeys: String, CodingKey {
//            case apiStatus = "api_status"
//            case apiText = "api_text"
//            case errors
//        }
//    }
//
//    struct Errors: Codable {
//        let errorID, errorText: String?
//        enum CodingKeys: String, CodingKey {
//            case errorID = "error_id"
//            case errorText = "error_text"
//        }
//    }
//
//    struct GetUserListSuccessModel: Codable {
//        let apiStatus: Int?
//        var data: [Datum]?
//        let videoCall: Bool?
////        let videoCallUser:[JSONAny]?
//        let audioCall: Bool?
////        let audioCallUser: [JSONAny]?
//        let agoraCall: Bool?
////        var agoraCallData:[JSONAny]?
//
//        enum CodingKeys: String, CodingKey {
//            case apiStatus = "api_status"
//            case data
//            case videoCall = "video_call"
////            case videoCallUser = "video_call_user"
//            case audioCall = "audio_call"
////            case audioCallUser = "audio_call_user"
//            case agoraCall = "agora_call"
////            case agoraCallData = "agora_call_data"
//        }
//    }
//
//    struct AgoraCallData: Codable {
//        let data: DataClass?
//        let userID: String?
//        let avatar: String?
//        let name: String?
//
//        enum CodingKeys: String, CodingKey {
//            case data
//            case userID = "user_id"
//            case avatar, name
//        }
//    }
//
//    // MARK: - DataClass
//    struct DataClass: Codable {
//        let id, fromID, toID, type: String?
//        let roomName, time, status: String?
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case fromID = "from_id"
//            case toID = "to_id"
//            case type
//            case roomName = "room_name"
//            case time, status
//        }
//    }
//
//    struct Datum: Codable {
//        let userID, username, email, password: String?
//        let firstName, lastName: String?
//        let avatar, cover: String?
//        let backgroundImage, backgroundImageStatus, relationshipID, address: String?
//        let working, workingLink, about, school: String?
//        let gender, birthday, countryID, website: String?
//        let facebook, google, twitter, linkedin: String?
//        let youtube, vk, instagram: String?
//        let language, emailCode, src, ipAddress: String?
//        let followPrivacy, friendPrivacy, postPrivacy, messagePrivacy: String?
//        let confirmFollowers, showActivitiesPrivacy, birthPrivacy, visitPrivacy: String?
//        let verified, lastseen, showlastseen, emailNotification: String?
//        let eLiked, eWondered, eShared, eFollowed: String?
//        let eCommented, eVisited, eLikedPage, eMentioned: String?
//        let eJoinedGroup, eAccepted, eProfileWallPost, eSentmeMsg: String?
//        let eLastNotif, notificationSettings, status, active: String?
//        let admin, type, registered, startUp: String?
//        let startUpInfo, startupFollow, startupImage, lastEmailSent: String?
//        let phoneNumber, smsCode, isPro, proTime: String?
//        let proType, joined, cssFile, timezone: String?
//        let referrer, refUserID, balance, paypalEmail: String?
//        let notificationsSound, orderPostsBy, socialLogin, androidMDeviceID: String?
//        let iosMDeviceID, androidNDeviceID, iosNDeviceID, webDeviceID: String?
//        let wallet, lat, lng, lastLocationUpdate: String?
//        let shareMyLocation, lastDataUpdate: String?
//        let sidebarData, lastAvatarMod, lastCoverMod, points: String?
//        let dailyPoints, pointDayExpire, lastFollowID, shareMyData: String?
//        let twoFactor, newEmail, twoFactorVerified, newPhone: String?
//        let infoFile, city, state, zip: String?
//        let schoolCompleted, weatherUnit, paystackRef, codeSent: String?
//        let timeCodeSent, avatarPostID: String?
//        let coverPostID: Int?
//        let avatarOrg, coverOrg, coverFull, avatarFull: String?
//        let id, userPlatform: String?
//        let url: String?
//        let name: String?
//        let apiNotificationSettings: [String: Int]?
//        let isNotifyStopped: Int?
//        let followingData, followersData: [String]?
//        let mutualFriendsData, likesData: String?
//        let groupsData: [String]?
//        let albumData, lastseenUnixTime, lastseenStatus: String?
//        let isReported, isStoryMuted: Bool?
//        let isFollowingMe: Int?
//        let chatTime, chatID, chatType: String?
//        let lastMessage: LastMessage?
//        let messageCount: String?
//
//        enum CodingKeys: String, CodingKey {
//            case userID = "user_id"
//            case username, email, password
//            case firstName = "first_name"
//            case lastName = "last_name"
//            case avatar, cover
//            case backgroundImage = "background_image"
//            case backgroundImageStatus = "background_image_status"
//            case relationshipID = "relationship_id"
//            case address, working
//            case workingLink = "working_link"
//            case about, school, gender, birthday
//            case countryID = "country_id"
//            case website, facebook, google, twitter, linkedin, youtube, vk, instagram, language
//            case emailCode = "email_code"
//            case src
//            case ipAddress = "ip_address"
//            case followPrivacy = "follow_privacy"
//            case friendPrivacy = "friend_privacy"
//            case postPrivacy = "post_privacy"
//            case messagePrivacy = "message_privacy"
//            case confirmFollowers = "confirm_followers"
//            case showActivitiesPrivacy = "show_activities_privacy"
//            case birthPrivacy = "birth_privacy"
//            case visitPrivacy = "visit_privacy"
//            case verified, lastseen, showlastseen, emailNotification
//            case eLiked = "e_liked"
//            case eWondered = "e_wondered"
//            case eShared = "e_shared"
//            case eFollowed = "e_followed"
//            case eCommented = "e_commented"
//            case eVisited = "e_visited"
//            case eLikedPage = "e_liked_page"
//            case eMentioned = "e_mentioned"
//            case eJoinedGroup = "e_joined_group"
//            case eAccepted = "e_accepted"
//            case eProfileWallPost = "e_profile_wall_post"
//            case eSentmeMsg = "e_sentme_msg"
//            case eLastNotif = "e_last_notif"
//            case notificationSettings = "notification_settings"
//            case status, active, admin, type, registered
//            case startUp = "start_up"
//            case startUpInfo = "start_up_info"
//            case startupFollow = "startup_follow"
//            case startupImage = "startup_image"
//            case lastEmailSent = "last_email_sent"
//            case phoneNumber = "phone_number"
//            case smsCode = "sms_code"
//            case isPro = "is_pro"
//            case proTime = "pro_time"
//            case proType = "pro_type"
//            case joined
//            case cssFile = "css_file"
//            case timezone, referrer
//            case refUserID = "ref_user_id"
//            case balance
//            case paypalEmail = "paypal_email"
//            case notificationsSound = "notifications_sound"
//            case orderPostsBy = "order_posts_by"
//            case socialLogin = "social_login"
//            case androidMDeviceID = "android_m_device_id"
//            case iosMDeviceID = "ios_m_device_id"
//            case androidNDeviceID = "android_n_device_id"
//            case iosNDeviceID = "ios_n_device_id"
//            case webDeviceID = "web_device_id"
//            case wallet, lat, lng
//            case lastLocationUpdate = "last_location_update"
//            case shareMyLocation = "share_my_location"
//            case lastDataUpdate = "last_data_update"
//            case sidebarData = "sidebar_data"
//            case lastAvatarMod = "last_avatar_mod"
//            case lastCoverMod = "last_cover_mod"
//            case points
//            case dailyPoints = "daily_points"
//            case pointDayExpire = "point_day_expire"
//            case lastFollowID = "last_follow_id"
//            case shareMyData = "share_my_data"
//            case twoFactor = "two_factor"
//            case newEmail = "new_email"
//            case twoFactorVerified = "two_factor_verified"
//            case newPhone = "new_phone"
//            case infoFile = "info_file"
//            case city, state, zip
//            case schoolCompleted = "school_completed"
//            case weatherUnit = "weather_unit"
//            case paystackRef = "paystack_ref"
//            case codeSent = "code_sent"
//            case timeCodeSent = "time_code_sent"
//            case avatarPostID = "avatar_post_id"
//            case coverPostID = "cover_post_id"
//            case avatarOrg = "avatar_org"
//            case coverOrg = "cover_org"
//            case coverFull = "cover_full"
//            case avatarFull = "avatar_full"
//            case id
//            case userPlatform = "user_platform"
//            case url, name
//            case apiNotificationSettings = "API_notification_settings"
//            case isNotifyStopped = "is_notify_stopped"
//            case followingData = "following_data"
//            case followersData = "followers_data"
//            case mutualFriendsData = "mutual_friends_data"
//            case likesData = "likes_data"
//            case groupsData = "groups_data"
//            case albumData = "album_data"
//            case lastseenUnixTime = "lastseen_unix_time"
//            case lastseenStatus = "lastseen_status"
//            case isReported = "is_reported"
//            case isStoryMuted = "is_story_muted"
//            case isFollowingMe = "is_following_me"
//            case chatTime = "chat_time"
//            case chatID = "chat_id"
//            case chatType = "chat_type"
//            case lastMessage = "last_message"
//            case messageCount = "message_count"
//        }
//    }
//    struct messageUser: Codable {
//        let userID, username, email, password: String?
//        let firstName, lastName: String?
//        let avatar, cover: String?
//        let backgroundImage, backgroundImageStatus, relationshipID, address: String?
//        let working, workingLink, about, school: String?
//        let gender, birthday, countryID, website: String?
//        let facebook, google, twitter, linkedin: String?
//        let youtube, vk, instagram: String?
//        let language, emailCode, src, ipAddress: String?
//        let followPrivacy, friendPrivacy, postPrivacy, messagePrivacy: String?
//        let confirmFollowers, showActivitiesPrivacy, birthPrivacy, visitPrivacy: String?
//        let verified, lastseen, showlastseen, emailNotification: String?
//        let eLiked, eWondered, eShared, eFollowed: String?
//        let eCommented, eVisited, eLikedPage, eMentioned: String?
//        let eJoinedGroup, eAccepted, eProfileWallPost, eSentmeMsg: String?
//        let eLastNotif, notificationSettings, status, active: String?
//        let admin, type, registered, startUp: String?
//        let startUpInfo, startupFollow, startupImage, lastEmailSent: String?
//        let phoneNumber, smsCode, isPro, proTime: String?
//        let proType, joined, cssFile, timezone: String?
//        let referrer, refUserID, balance, paypalEmail: String?
//        let notificationsSound, orderPostsBy, socialLogin, androidMDeviceID: String?
//        let iosMDeviceID, androidNDeviceID, iosNDeviceID, webDeviceID: String?
//        let wallet, lat, lng, lastLocationUpdate: String?
//        let shareMyLocation, lastDataUpdate: String?
//        let sidebarData, lastAvatarMod, lastCoverMod, points: String?
//        let dailyPoints, pointDayExpire, lastFollowID, shareMyData: String?
//        let twoFactor, newEmail, twoFactorVerified, newPhone: String?
//        let infoFile, city, state, zip: String?
//        let schoolCompleted, weatherUnit, paystackRef, codeSent: String?
//        let timeCodeSent, avatarPostID: String?
//        let coverPostID: Int?
//        let avatarOrg, coverOrg, coverFull, avatarFull: String?
//        let id, userPlatform: String?
//        let url: String?
//        let name: String?
//        let apiNotificationSettings: [String: Int]?
//        let isNotifyStopped: Int?
//        let followingData, followersData: [String]?
//        let mutualFriendsData, likesData: String?
//        let groupsData: [String]?
//        let albumData, lastseenUnixTime, lastseenStatus: String?
//        let isReported, isStoryMuted: Bool?
//        let isFollowingMe: Int?
//        let chatTime, chatID, chatType: String?
////        let lastMessage: LastMessage?
//        let messageCount: String?
//
//        enum CodingKeys: String, CodingKey {
//            case userID = "user_id"
//            case username, email, password
//            case firstName = "first_name"
//            case lastName = "last_name"
//            case avatar, cover
//            case backgroundImage = "background_image"
//            case backgroundImageStatus = "background_image_status"
//            case relationshipID = "relationship_id"
//            case address, working
//            case workingLink = "working_link"
//            case about, school, gender, birthday
//            case countryID = "country_id"
//            case website, facebook, google, twitter, linkedin, youtube, vk, instagram, language
//            case emailCode = "email_code"
//            case src
//            case ipAddress = "ip_address"
//            case followPrivacy = "follow_privacy"
//            case friendPrivacy = "friend_privacy"
//            case postPrivacy = "post_privacy"
//            case messagePrivacy = "message_privacy"
//            case confirmFollowers = "confirm_followers"
//            case showActivitiesPrivacy = "show_activities_privacy"
//            case birthPrivacy = "birth_privacy"
//            case visitPrivacy = "visit_privacy"
//            case verified, lastseen, showlastseen, emailNotification
//            case eLiked = "e_liked"
//            case eWondered = "e_wondered"
//            case eShared = "e_shared"
//            case eFollowed = "e_followed"
//            case eCommented = "e_commented"
//            case eVisited = "e_visited"
//            case eLikedPage = "e_liked_page"
//            case eMentioned = "e_mentioned"
//            case eJoinedGroup = "e_joined_group"
//            case eAccepted = "e_accepted"
//            case eProfileWallPost = "e_profile_wall_post"
//            case eSentmeMsg = "e_sentme_msg"
//            case eLastNotif = "e_last_notif"
//            case notificationSettings = "notification_settings"
//            case status, active, admin, type, registered
//            case startUp = "start_up"
//            case startUpInfo = "start_up_info"
//            case startupFollow = "startup_follow"
//            case startupImage = "startup_image"
//            case lastEmailSent = "last_email_sent"
//            case phoneNumber = "phone_number"
//            case smsCode = "sms_code"
//            case isPro = "is_pro"
//            case proTime = "pro_time"
//            case proType = "pro_type"
//            case joined
//            case cssFile = "css_file"
//            case timezone, referrer
//            case refUserID = "ref_user_id"
//            case balance
//            case paypalEmail = "paypal_email"
//            case notificationsSound = "notifications_sound"
//            case orderPostsBy = "order_posts_by"
//            case socialLogin = "social_login"
//            case androidMDeviceID = "android_m_device_id"
//            case iosMDeviceID = "ios_m_device_id"
//            case androidNDeviceID = "android_n_device_id"
//            case iosNDeviceID = "ios_n_device_id"
//            case webDeviceID = "web_device_id"
//            case wallet, lat, lng
//            case lastLocationUpdate = "last_location_update"
//            case shareMyLocation = "share_my_location"
//            case lastDataUpdate = "last_data_update"
//            case sidebarData = "sidebar_data"
//            case lastAvatarMod = "last_avatar_mod"
//            case lastCoverMod = "last_cover_mod"
//            case points
//            case dailyPoints = "daily_points"
//            case pointDayExpire = "point_day_expire"
//            case lastFollowID = "last_follow_id"
//            case shareMyData = "share_my_data"
//            case twoFactor = "two_factor"
//            case newEmail = "new_email"
//            case twoFactorVerified = "two_factor_verified"
//            case newPhone = "new_phone"
//            case infoFile = "info_file"
//            case city, state, zip
//            case schoolCompleted = "school_completed"
//            case weatherUnit = "weather_unit"
//            case paystackRef = "paystack_ref"
//            case codeSent = "code_sent"
//            case timeCodeSent = "time_code_sent"
//            case avatarPostID = "avatar_post_id"
//            case coverPostID = "cover_post_id"
//            case avatarOrg = "avatar_org"
//            case coverOrg = "cover_org"
//            case coverFull = "cover_full"
//            case avatarFull = "avatar_full"
//            case id
//            case userPlatform = "user_platform"
//            case url, name
//            case apiNotificationSettings = "API_notification_settings"
//            case isNotifyStopped = "is_notify_stopped"
//            case followingData = "following_data"
//            case followersData = "followers_data"
//            case mutualFriendsData = "mutual_friends_data"
//            case likesData = "likes_data"
//            case groupsData = "groups_data"
//            case albumData = "album_data"
//            case lastseenUnixTime = "lastseen_unix_time"
//            case lastseenStatus = "lastseen_status"
//            case isReported = "is_reported"
//            case isStoryMuted = "is_story_muted"
//            case isFollowingMe = "is_following_me"
//            case chatTime = "chat_time"
//            case chatID = "chat_id"
//            case chatType = "chat_type"
////            case lastMessage = "last_message"
//            case messageCount = "message_count"
//        }
//    }
////    struct User: Codable {
////        let userID, username, name: String?
////        let avatar, coverPicture: String?
////        let verified, lastseen, lastseenUnixTime, lastseenTimeText: String?
////        let url: String?
////        let chatColor, chatTime: String?
////        let lastMessage: LastMessage?
////
////        enum CodingKeys: String, CodingKey {
////            case userID = "user_id"
////            case username, name
////            case avatar = "avatar"
////            case coverPicture = "cover_picture"
////            case verified, lastseen
////            case lastseenUnixTime = "lastseen_unix_time"
////            case lastseenTimeText = "lastseen_time_text"
////            case url
////            case chatColor = "chat_color"
////            case chatTime = "chat_time"
////            case lastMessage = "last_message"
////        }
////    }
//    struct TwilloAudioCallData: Codable {
//        let data: TwilloAudioCallDataClass?
//        let userID: String?
//        let avatar: String?
//        let name: String?
//
//        enum CodingKeys: String, CodingKey {
//            case data
//            case userID = "user_id"
//            case avatar, name
//        }
//    }
//
//    // MARK: - DataClass
//    struct TwilloAudioCallDataClass: Codable {
//        let id, callID, accessToken, callID2: String?
//        let accessToken2, fromID, toID, roomName: String?
//        let active, called, time, declined: String?
//        let url: String?
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case callID = "call_id"
//            case accessToken = "access_token"
//            case callID2 = "call_id_2"
//            case accessToken2 = "access_token_2"
//            case fromID = "from_id"
//            case toID = "to_id"
//            case roomName = "room_name"
//            case active, called, time, declined, url
//        }
//    }
//
//    struct TwilloVideoCallData: Codable {
//        let data: TwilloVideoCallDataClass?
//        let userID: String?
//        let avatar: String?
//        let name: String?
//
//        enum CodingKeys: String, CodingKey {
//            case data
//            case userID = "user_id"
//            case avatar, name
//        }
//    }
//
//    struct TwilloVideoCallDataClass: Codable {
//        let id, accessToken, accessToken2, fromID: String?
//        let toID, roomName, active, called: String?
//        let time, declined: String?
//        let url: String?
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case accessToken = "access_token"
//            case accessToken2 = "access_token_2"
//            case fromID = "from_id"
//            case toID = "to_id"
//            case roomName = "room_name"
//            case active, called, time, declined, url
//        }
//    }
//
////    struct LastMessage: Codable {
////        let id, fromID, groupID, toID: String?
////        let text, media, mediaFileName, mediaFileNames: String?
////        let time, seen, deletedOne, deletedTwo: String?
////        let sentPush, notificationID, typeTwo, stickers: String?
////        let dateTime: String?
////        let productId: String
////        let lat, long: String?
////
////        enum CodingKeys: String, CodingKey {
////            case id
////            case fromID = "from_id"
////            case groupID = "group_id"
////            case toID = "to_id"
////            case text, media, mediaFileName, mediaFileNames, time, seen
////            case deletedOne = "deleted_one"
////            case deletedTwo = "deleted_two"
////            case sentPush = "sent_push"
////            case notificationID = "notification_id"
////            case typeTwo = "type_two"
////            case stickers
////            case dateTime = "date_time"
////            case productId = "product_id"
////            case lat = "lat"
////            case long = "lng"
////        }
////    }
//
////
//
//        struct LastMessage: Codable {
//            let id, fromID, groupID, pageID: String?
//            let toID, text, media, mediaFileName: String?
//            let mediaFileNames, time, seen, deletedOne: String?
//            let deletedTwo, sentPush, notificationID, typeTwo: String?
//            let productId: String?
//            let stickers, lat, lng: String?
//            let replyID, storyID, broadcastID, forward: String?
//            let messageUser: messageUser?
//            let onwer: Int?
//            let timeText, position, type: String?
//            let fileSize: Int?
//            let chatColor: String?
//
//            enum CodingKeys: String, CodingKey {
//                case id
//                case fromID = "from_id"
//                case groupID = "group_id"
//                case pageID = "page_id"
//                case toID = "to_id"
//                case text, media, mediaFileName, mediaFileNames, time, seen
//                case deletedOne = "deleted_one"
//                case deletedTwo = "deleted_two"
//                case sentPush = "sent_push"
//                case notificationID = "notification_id"
//                case typeTwo = "type_two"
//                case stickers
//                case productId = "product_id"
//                case lat, lng
//                case replyID = "reply_id"
//                case storyID = "story_id"
//                case broadcastID = "broadcast_id"
//                case forward, messageUser, onwer
//                case timeText = "time_text"
//                case position, type
//                case fileSize = "file_size"
//                case chatColor = "chat_color"
//            }
//        }
//}

struct CallDataModel: Codable {
    let agoraCallData: AgoraCallData?
    enum CodingKeys: String, CodingKey {
        case agoraCallData = "agora_call_data"
    }
}

// MARK: - AgoraCallData
struct AgoraCallData: Codable {
    let data: DataClass?
    let userID: String?
    let avatar: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case userID = "user_id"
        case avatar, name
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, fromID, toID, type: String?
    let roomName, time, status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case toID = "to_id"
        case type
        case roomName = "room_name"
        case time, status
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chatModelResponse = try? newJSONDecoder().decode(ChatModelResponse.self, from: jsonData)

// MARK: - LastMessage
//struct LastMessage: Codable {
//    var id, fromID, groupID, pageID: String?
//    var toID, text, media, mediaFileName: String?
//    var mediaFileNames, time, seen, deletedOne: String?
//    var deletedTwo, sentPush, notificationID, typeTwo: String?
//    var stickers, productID, lat, lng: String?
//    var replyID, storyID, broadcastID, forward: String?
//    var listening: String?
//    var messageUser: ChatMessageUser?
//    var onwer: Int?
//    var reaction: Reaction?
//    var timeText, position, type: String?
//    var product: JSONNull?
//    var fileSize: Int?
//    var chatColor: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case fromID = "from_id"
//        case groupID = "group_id"
//        case pageID = "page_id"
//        case toID = "to_id"
//        case text, media, mediaFileName, mediaFileNames, time, seen
//        case deletedOne = "deleted_one"
//        case deletedTwo = "deleted_two"
//        case sentPush = "sent_push"
//        case notificationID = "notification_id"
//        case typeTwo = "type_two"
//        case stickers
//        case productID = "product_id"
//        case lat, lng
//        case replyID = "reply_id"
//        case storyID = "story_id"
//        case broadcastID = "broadcast_id"
//        case forward, listening, messageUser, onwer, reaction
//        case timeText = "time_text"
//        case position, type, product
//        case fileSize = "file_size"
//        case chatColor = "chat_color"
//    }
//}

//// MARK: - Reaction
//struct ChatReaction: Codable {
//    var isReacted: Bool?
//    var type: String?
//    var count: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case isReacted = "is_reacted"
//        case type, count
//    }
//}
//
//// MARK: - Details
//struct ChatDetails: Codable {
//    var postCount, albumCount, followingCount, followersCount: Count?
//    var groupsCount, likesCount: Count?
//    var mutualFriendsCount: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case postCount = "post_count"
//        case albumCount = "album_count"
//        case followingCount = "following_count"
//        case followersCount = "followers_count"
//        case groupsCount = "groups_count"
//        case likesCount = "likes_count"
//        case mutualFriendsCount = "mutual_friends_count"
//    }
//}

// MARK: - MessageUser
//struct ChatMessageUser: Codable {
//    var userID, username, email, firstName: String?
//    var lastName: String?
//    var avatar, cover: String?
//    var backgroundImage, relationshipID, address, working: String?
//    var workingLink, about, school, gender: String?
//    var birthday, countryID, website, facebook: String?
//    var google, twitter, linkedin, youtube: String?
//    var vk, instagram: String?
//    var qq, wechat, discord, mailru: JSONNull?
//    var okru, language, ipAddress, followPrivacy: String?
//    var friendPrivacy, postPrivacy, messagePrivacy, confirmFollowers: String?
//    var showActivitiesPrivacy, birthPrivacy, visitPrivacy, verified: String?
//    var lastseen, emailNotification, eLiked, eWondered: String?
//    var eShared, eFollowed, eCommented, eVisited: String?
//    var eLikedPage, eMentioned, eJoinedGroup, eAccepted: String?
//    var eProfileWallPost, eSentmeMsg, eLastNotif, notificationSettings: String?
//    var status, active, admin, registered: String?
//    var phoneNumber, isPro, proType, timezone: String?
//    var referrer, refUserID, balance, paypalEmail: String?
//    var notificationsSound, orderPostsBy, androidMDeviceID, iosMDeviceID: String?
//    var androidNDeviceID, iosNDeviceID, webDeviceID, wallet: String?
//    var lat, lng, lastLocationUpdate, shareMyLocation: String?
//    var lastDataUpdate: String?
//    var details: ChatMessageUserDetails?
//    var lastAvatarMod, lastCoverMod, points, dailyPoints: String?
//    var pointDayExpire, lastFollowID, shareMyData, lastLoginData: String?
//    var twoFactor, twoFactorHash, newEmail, twoFactorVerified: String?
//    var newPhone, infoFile, city, state: String?
//    var zip, schoolCompleted, weatherUnit, paystackRef: String?
//    var codeSent: String?
//    var stripeSessionID: JSONNull?
//    var timeCodeSent: String?
//    var permission, skills, languages: JSONNull?
//    var currentlyWorking, banned, bannedReason, coinbaseHash: String?
//    var coinbaseCode, yoomoneyHash, conversationID, securionpayKey: String?
//    var fortumoHash, aamarpayTranID, ngeniusRef, coinpaymentsTxnID: String?
//    var avatarPostID, coverPostID: Int?
//    var avatarFull, userPlatform: String?
//    var url: String?
//    var name: String?
//    var apiNotificationSettings: [String: Int]?
//    var isNotifyStopped: Int?
//    var mutualFriendsData: [String]?
//    var lastseenUnixTime, lastseenStatus: String?
//    var isReported, isStoryMuted: Bool?
//    var isFollowingMe, isReportedUser, isOpenToWork, isProvidingService: Int?
//    var providingService: Int?
//    var openToWorkData: String?
//    var formatedLangs: [JSONAny]?
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case username, email
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case avatar, cover
//        case backgroundImage = "background_image"
//        case relationshipID = "relationship_id"
//        case address, working
//        case workingLink = "working_link"
//        case about, school, gender, birthday
//        case countryID = "country_id"
//        case website, facebook, google, twitter, linkedin, youtube, vk, instagram, qq, wechat, discord, mailru, okru, language
//        case ipAddress = "ip_address"
//        case followPrivacy = "follow_privacy"
//        case friendPrivacy = "friend_privacy"
//        case postPrivacy = "post_privacy"
//        case messagePrivacy = "message_privacy"
//        case confirmFollowers = "confirm_followers"
//        case showActivitiesPrivacy = "show_activities_privacy"
//        case birthPrivacy = "birth_privacy"
//        case visitPrivacy = "visit_privacy"
//        case verified, lastseen, emailNotification
//        case eLiked = "e_liked"
//        case eWondered = "e_wondered"
//        case eShared = "e_shared"
//        case eFollowed = "e_followed"
//        case eCommented = "e_commented"
//        case eVisited = "e_visited"
//        case eLikedPage = "e_liked_page"
//        case eMentioned = "e_mentioned"
//        case eJoinedGroup = "e_joined_group"
//        case eAccepted = "e_accepted"
//        case eProfileWallPost = "e_profile_wall_post"
//        case eSentmeMsg = "e_sentme_msg"
//        case eLastNotif = "e_last_notif"
//        case notificationSettings = "notification_settings"
//        case status, active, admin, registered
//        case phoneNumber = "phone_number"
//        case isPro = "is_pro"
//        case proType = "pro_type"
//        case timezone, referrer
//        case refUserID = "ref_user_id"
//        case balance
//        case paypalEmail = "paypal_email"
//        case notificationsSound = "notifications_sound"
//        case orderPostsBy = "order_posts_by"
//        case androidMDeviceID = "android_m_device_id"
//        case iosMDeviceID = "ios_m_device_id"
//        case androidNDeviceID = "android_n_device_id"
//        case iosNDeviceID = "ios_n_device_id"
//        case webDeviceID = "web_device_id"
//        case wallet, lat, lng
//        case lastLocationUpdate = "last_location_update"
//        case shareMyLocation = "share_my_location"
//        case lastDataUpdate = "last_data_update"
//        case details
//        case lastAvatarMod = "last_avatar_mod"
//        case lastCoverMod = "last_cover_mod"
//        case points
//        case dailyPoints = "daily_points"
//        case pointDayExpire = "point_day_expire"
//        case lastFollowID = "last_follow_id"
//        case shareMyData = "share_my_data"
//        case lastLoginData = "last_login_data"
//        case twoFactor = "two_factor"
//        case twoFactorHash = "two_factor_hash"
//        case newEmail = "new_email"
//        case twoFactorVerified = "two_factor_verified"
//        case newPhone = "new_phone"
//        case infoFile = "info_file"
//        case city, state, zip
//        case schoolCompleted = "school_completed"
//        case weatherUnit = "weather_unit"
//        case paystackRef = "paystack_ref"
//        case codeSent = "code_sent"
//        case stripeSessionID = "StripeSessionId"
//        case timeCodeSent = "time_code_sent"
//        case permission, skills, languages
//        case currentlyWorking = "currently_working"
//        case banned
//        case bannedReason = "banned_reason"
//        case coinbaseHash = "coinbase_hash"
//        case coinbaseCode = "coinbase_code"
//        case yoomoneyHash = "yoomoney_hash"
//        case conversationID = "ConversationId"
//        case securionpayKey = "securionpay_key"
//        case fortumoHash = "fortumo_hash"
//        case aamarpayTranID = "aamarpay_tran_id"
//        case ngeniusRef = "ngenius_ref"
//        case coinpaymentsTxnID = "coinpayments_txn_id"
//        case avatarPostID = "avatar_post_id"
//        case coverPostID = "cover_post_id"
//        case avatarFull = "avatar_full"
//        case userPlatform = "user_platform"
//        case url, name
//        case apiNotificationSettings = "API_notification_settings"
//        case isNotifyStopped = "is_notify_stopped"
//        case mutualFriendsData = "mutual_friends_data"
//        case lastseenUnixTime = "lastseen_unix_time"
//        case lastseenStatus = "lastseen_status"
//        case isReported = "is_reported"
//        case isStoryMuted = "is_story_muted"
//        case isFollowingMe = "is_following_me"
//        case isReportedUser = "is_reported_user"
//        case isOpenToWork = "is_open_to_work"
//        case isProvidingService = "is_providing_service"
//        case providingService = "providing_service"
//        case openToWorkData = "open_to_work_data"
//        case formatedLangs = "formated_langs"
//    }
//}

// MARK: - MessageUserDetails
struct ChatMessageUserDetails: Codable {
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

/*
 {
 "api_status": 200,
 "data": [
 {
 "user_id": "183320",
 "username": "1658162819201698_183320",
 "email": "9testing3@gmail.com",
 "password": "$2y$10$YvGhzlxbGtBe24Ub0zlzMeuP7MFf4iq7ujFByyIvyS0I89pdbPCqq",
 "first_name": "Test",
 "last_name": "User",
 "avatar": "https:\/\/wowonder.fra1.digitaloceanspaces.com\/upload\/photos\/d-avatar.jpg?cache=0",
 "cover": "https:\/\/wowonder.fra1.digitaloceanspaces.com\/upload\/photos\/d-cover.jpg?cache=0",
 "background_image": "",
 "background_image_status": "0",
 "relationship_id": "0",
 "address": "",
 "working": "",
 "working_link": "",
 "about": "",
 "school": "",
 "gender": "male",
 "birthday": "00-00-0000",
 "country_id": "0",
 "website": "",
 "facebook": "",
 "google": "",
 "twitter": "",
 "linkedin": "",
 "youtube": "",
 "vk": "",
 "instagram": "",
 "qq": null,
 "wechat": null,
 "discord": null,
 "mailru": null,
 "okru": "",
 "language": "english",
 "email_code": "41cf643a3b928a55239379b7349d3e38",
 "src": "site",
 "ip_address": "206.62.149.124",
 "follow_privacy": "0",
 "friend_privacy": "0",
 "post_privacy": "ifollow",
 "message_privacy": "0",
 "confirm_followers": "0",
 "show_activities_privacy": "1",
 "birth_privacy": "0",
 "visit_privacy": "0",
 "verified": "0",
 "lastseen": "1659882277",
 "showlastseen": "1",
 "emailNotification": "1",
 "e_liked": "1",
 "e_wondered": "1",
 "e_shared": "1",
 "e_followed": "1",
 "e_commented": "1",
 "e_visited": "1",
 "e_liked_page": "1",
 "e_mentioned": "1",
 "e_joined_group": "1",
 "e_accepted": "1",
 "e_profile_wall_post": "1",
 "e_sentme_msg": "0",
 "e_last_notif": "0",
 "notification_settings": "{\"e_liked\":1,\"e_shared\":1,\"e_wondered\":0,\"e_commented\":1,\"e_followed\":1,\"e_accepted\":1,\"e_mentioned\":1,\"e_joined_group\":1,\"e_liked_page\":1,\"e_visited\":1,\"e_profile_wall_post\":1,\"e_memory\":1}",
 "status": "0",
 "active": "1",
 "admin": "0",
 "type": "user",
 "registered": "7\/2022",
 "start_up": "0",
 "start_up_info": "1",
 "startup_follow": "1",
 "startup_image": "1",
 "last_email_sent": "0",
 "phone_number": "",
 "sms_code": "0",
 "is_pro": "0",
 "pro_time": "0",
 "pro_type": "0",
 "joined": "1658162820",
 "css_file": "",
 "timezone": "UTC",
 "referrer": "0",
 "ref_user_id": "0",
 "balance": "0",
 "paypal_email": "",
 "notifications_sound": "0",
 "order_posts_by": "0",
 "social_login": "0",
 "android_m_device_id": "",
 "ios_m_device_id": "",
 "android_n_device_id": "",
 "ios_n_device_id": "",
 "web_device_id": "",
 "wallet": "0.00",
 "lat": "31.5153566",
 "lng": "34.4538471",
 "last_location_update": "1660112840",
 "share_my_location": "1",
 "last_data_update": "1659876065",
 "details": {
 "post_count": "0",
 "album_count": "0",
 "following_count": "2",
 "followers_count": "2",
 "groups_count": "0",
 "likes_count": "0",
 "mutual_friends_count": false
 },
 "sidebar_data": "{\"following_data\":[\"182951\",\"1\"],\"followers_data\":[\"182951\",\"115018\"],\"likes_data\":[],\"groups_data\":[],\"mutual_friends_data\":[]}",
 "last_avatar_mod": "0",
 "last_cover_mod": "0",
 "points": "0",
 "daily_points": "0",
 "point_day_expire": "",
 "last_follow_id": "0",
 "share_my_data": "1",
 "last_login_data": "{\"status\":\"success\",\"country\":\"Palestine\",\"countryCode\":\"PS\",\"region\":\"GZA\",\"regionName\":\"Gaza\",\"city\":\"Gaza\",\"zip\":\"\",\"lat\":31.50189999999999912461134954355657100677490234375,\"lon\":34.466599999999999681676854379475116729736328125,\"timezone\":\"Asia\/Gaza\",\"isp\":\"AGIS\",\"org\":\"Digital Communication ltd.\",\"as\":\"AS44213 Thaer A. T. Abuyousef trading as Abuyousef Co & Partners For General Trade\",\"query\":\"206.62.149.124\"}",
 "two_factor": "0",
 "two_factor_hash": "",
 "new_email": "",
 "two_factor_verified": "0",
 "new_phone": "",
 "info_file": "",
 "city": "",
 "state": "",
 "zip": "",
 "school_completed": "0",
 "weather_unit": "us",
 "paystack_ref": "",
 "code_sent": "0",
 "StripeSessionId": null,
 "time_code_sent": "0",
 "permission": null,
 "skills": null,
 "languages": null,
 "currently_working": "",
 "banned": "0",
 "banned_reason": "",
 "coinbase_hash": "",
 "coinbase_code": "",
 "yoomoney_hash": "",
 "ConversationId": "0",
 "securionpay_key": "",
 "fortumo_hash": "",
 "aamarpay_tran_id": "",
 "ngenius_ref": "",
 "coinpayments_txn_id": "",
 "avatar_post_id": 0,
 "cover_post_id": 0,
 "avatar_org": "upload\/photos\/d-avatar.jpg",
 "cover_org": "upload\/photos\/d-cover.jpg",
 "cover_full": "upload\/photos\/d-cover.jpg",
 "avatar_full": "upload\/photos\/d-avatar.jpg",
 "id": "183320",
 "user_platform": "web",
 "url": "https:\/\/demo.wowonder.com\/1658162819201698_183320",
 "name": "Test User",
 "API_notification_settings": {
 "e_liked": 1,
 "e_shared": 1,
 "e_wondered": 0,
 "e_commented": 1,
 "e_followed": 1,
 "e_accepted": 1,
 "e_mentioned": 1,
 "e_joined_group": 1,
 "e_liked_page": 1,
 "e_visited": 1,
 "e_profile_wall_post": 1,
 "e_memory": 1
 },
 "is_notify_stopped": 0,
 "following_data": [
 "182951",
 "1"
 ],
 "followers_data": [
 "182951",
 "115018"
 ],
 "mutual_friends_data": "",
 "likes_data": "",
 "groups_data": "",
 "album_data": "",
 "lastseen_unix_time": "1659882277",
 "lastseen_status": "on",
 "is_reported": false,
 "is_story_muted": false,
 "is_following_me": 1,
 "is_reported_user": 0,
 "is_open_to_work": 0,
 "is_providing_service": 0,
 "providing_service": 0,
 "open_to_work_data": "",
 "formated_langs": [],
 "chat_time": "1659348325",
 "chat_id": "91515",
 "chat_type": "user",
 "mute": {
 "notify": "yes",
 "call_chat": "yes",
 "archive": "no",
 "fav": "no",
 "pin": "no"
 },
 "last_message": {
 "id": "115742",
 "from_id": "182951",
 "group_id": "0",
 "page_id": "0",
 "to_id": "183320",
 "text": "lHgF7hs+u6MrCR3hJ4TJhg==",
 "media": "",
 "mediaFileName": "",
 "mediaFileNames": "",
 "time": "1659348325",
 "seen": "1659349225",
 "deleted_one": "0",
 "deleted_two": "0",
 "sent_push": "1",
 "notification_id": "",
 "type_two": "",
 "stickers": "",
 "product_id": "0",
 "lat": "0",
 "lng": "0",
 "reply_id": "0",
 "story_id": "0",
 "broadcast_id": "0",
 "forward": "0",
 "listening": "0",
 "messageUser": {
 "user_id": "182951",
 "username": "9Testing2",
 "email": "test92@gmail.com",
 "first_name": "",
 "last_name": "",
 "avatar": "https:\/\/wowonder.fra1.digitaloceanspaces.com\/upload\/photos\/d-avatar.jpg?cache=0",
 "cover": "https:\/\/wowonder.fra1.digitaloceanspaces.com\/upload\/photos\/d-cover.jpg?cache=0",
 "background_image": "",
 "relationship_id": "0",
 "address": "",
 "working": "",
 "working_link": "",
 "about": "",
 "school": "",
 "gender": "male",
 "birthday": "0000-00-00",
 "country_id": "0",
 "website": "",
 "facebook": "",
 "google": "",
 "twitter": "",
 "linkedin": "",
 "youtube": "",
 "vk": "",
 "instagram": "",
 "qq": null,
 "wechat": null,
 "discord": null,
 "mailru": null,
 "okru": "",
 "language": "arabic",
 "ip_address": "206.62.149.124",
 "follow_privacy": "0",
 "friend_privacy": "0",
 "post_privacy": "ifollow",
 "message_privacy": "0",
 "confirm_followers": "0",
 "show_activities_privacy": "1",
 "birth_privacy": "0",
 "visit_privacy": "0",
 "verified": "0",
 "lastseen": "1659350299",
 "emailNotification": "1",
 "e_liked": "1",
 "e_wondered": "1",
 "e_shared": "1",
 "e_followed": "1",
 "e_commented": "1",
 "e_visited": "1",
 "e_liked_page": "1",
 "e_mentioned": "1",
 "e_joined_group": "1",
 "e_accepted": "1",
 "e_profile_wall_post": "1",
 "e_sentme_msg": "0",
 "e_last_notif": "0",
 "notification_settings": "{\"e_liked\":1,\"e_shared\":1,\"e_wondered\":0,\"e_commented\":1,\"e_followed\":1,\"e_accepted\":1,\"e_mentioned\":1,\"e_joined_group\":1,\"e_liked_page\":1,\"e_visited\":1,\"e_profile_wall_post\":1,\"e_memory\":1}",
 "status": "0",
 "active": "1",
 "admin": "0",
 "registered": "7\/2022",
 "phone_number": "",
 "is_pro": "0",
 "pro_type": "0",
 "timezone": "UTC",
 "referrer": "0",
 "ref_user_id": "0",
 "balance": "0",
 "paypal_email": "",
 "notifications_sound": "0",
 "order_posts_by": "0",
 "android_m_device_id": "45426760-e3e9-45d5-b205-86b9e1593899",
 "ios_m_device_id": "3b259ab6-215a-4950-aea2-8c62538cfe0a",
 "android_n_device_id": "",
 "ios_n_device_id": "",
 "web_device_id": "",
 "wallet": "0.00",
 "lat": "31.5019",
 "lng": "34.4666",
 "last_location_update": "1658767785",
 "share_my_location": "1",
 "last_data_update": "1659882274",
 "details": {
 "post_count": "0",
 "album_count": "0",
 "following_count": "2",
 "followers_count": "1",
 "groups_count": "0",
 "likes_count": "0",
 "mutual_friends_count": 2
 },
 "last_avatar_mod": "0",
 "last_cover_mod": "0",
 "points": "0",
 "daily_points": "0",
 "point_day_expire": "",
 "last_follow_id": "0",
 "share_my_data": "1",
 "last_login_data": "{\"status\":\"success\",\"country\":\"Palestine\",\"countryCode\":\"PS\",\"region\":\"GZA\",\"regionName\":\"Gaza\",\"city\":\"Gaza\",\"zip\":\"\",\"lat\":31.50189999999999912461134954355657100677490234375,\"lon\":34.466599999999999681676854379475116729736328125,\"timezone\":\"Asia\/Gaza\",\"isp\":\"AGIS\",\"org\":\"Digital Communication ltd.\",\"as\":\"AS44213 Thaer A. T. Abuyousef trading as Abuyousef Co & Partners For General Trade\",\"query\":\"206.62.147.23\"}",
 "two_factor": "0",
 "two_factor_hash": "",
 "new_email": "",
 "two_factor_verified": "0",
 "new_phone": "",
 "info_file": "",
 "city": "",
 "state": "",
 "zip": "",
 "school_completed": "0",
 "weather_unit": "us",
 "paystack_ref": "",
 "code_sent": "0",
 "StripeSessionId": null,
 "time_code_sent": "0",
 "permission": null,
 "skills": null,
 "languages": null,
 "currently_working": "",
 "banned": "0",
 "banned_reason": "",
 "coinbase_hash": "",
 "coinbase_code": "",
 "yoomoney_hash": "",
 "ConversationId": "0",
 "securionpay_key": "",
 "fortumo_hash": "",
 "aamarpay_tran_id": "",
 "ngenius_ref": "",
 "coinpayments_txn_id": "",
 "avatar_post_id": 0,
 "cover_post_id": 0,
 "avatar_full": "upload\/photos\/d-avatar.jpg",
 "user_platform": "phone",
 "url": "https:\/\/demo.wowonder.com\/9Testing2",
 "name": "9Testing2",
 "API_notification_settings": {
 "e_liked": 1,
 "e_shared": 1,
 "e_wondered": 0,
 "e_commented": 1,
 "e_followed": 1,
 "e_accepted": 1,
 "e_mentioned": 1,
 "e_joined_group": 1,
 "e_liked_page": 1,
 "e_visited": 1,
 "e_profile_wall_post": 1,
 "e_memory": 1
 },
 "is_notify_stopped": 0,
 "mutual_friends_data": [
 "183320",
 "1"
 ],
 "lastseen_unix_time": "1659350299",
 "lastseen_status": "off",
 "is_reported": false,
 "is_story_muted": false,
 "is_following_me": 0,
 "is_reported_user": 0,
 "is_open_to_work": 0,
 "is_providing_service": 0,
 "providing_service": 0,
 "open_to_work_data": "",
 "formated_langs": []
 },
 "onwer": 1,
 "reaction": {
 "is_reacted": false,
 "type": "",
 "count": 0
 },
 "time_text": "08.01.22",
 "position": "left",
 "type": "left_text",
 "product": null,
 "file_size": 0,
 "chat_color": "#a52729"
 },
 "message_count": "0"
 }
 ],
 "video_call": false,
 "video_call_user": [],
 "audio_call": false,
 "audio_call_user": [],
 "agora_call": false,
 "agora_call_data": []
 }
 */
