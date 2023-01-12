//
//  UserModel.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 08/08/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UserModel
struct UserModel: Codable {
    var userID, username, email, password: String?
    var firstName, lastName: String?
    var avatar, cover: String?
    var backgroundImage, backgroundImageStatus, relationshipID, address: String?
    var working, workingLink, about, school: String?
    var gender, birthday, countryID, website: String?
    var facebook, google, twitter, linkedin: String?
    var youtube, vk, instagram: String?
    var okru, language, emailCode, src: String?
    var ipAddress, followPrivacy, friendPrivacy, postPrivacy: String?
    var messagePrivacy, confirmFollowers, showActivitiesPrivacy, birthPrivacy: String?
    var visitPrivacy, verified, lastseen, showlastseen: String?
    var emailNotification, eLiked, eWondered, eShared: String?
    var eFollowed, eCommented, eVisited, eLikedPage: String?
    var eMentioned, eJoinedGroup, eAccepted, eProfileWallPost: String?
    var eSentmeMsg, eLastNotif, notificationSettings, status: String?
    var active, admin, type, registered: String?
    var startUp, startUpInfo, startupFollow, startupImage: String?
    var lastEmailSent, phoneNumber, smsCode, isPro: String?
    var proTime, proType, joined, cssFile: String?
    var timezone, referrer, refUserID, balance: String?
    var paypalEmail, notificationsSound, orderPostsBy, socialLogin: String?
    var androidMDeviceID, iosMDeviceID, androidNDeviceID, iosNDeviceID: String?
    var webDeviceID, wallet, lat, lng: String?
    var lastLocationUpdate, shareMyLocation, lastDataUpdate: String?
    var details: ChatDetails?
    var sidebarData, lastAvatarMod, lastCoverMod, points: String?
    var dailyPoints, pointDayExpire, lastFollowID, shareMyData: String?
    var lastLoginData, twoFactor, twoFactorHash, newEmail: String?
    var twoFactorVerified, newPhone, infoFile, city: String?
    var state, zip, schoolCompleted, weatherUnit: String?
    var paystackRef, codeSent: String?
    var timeCodeSent: String?
    var currentlyWorking, banned, bannedReason, coinbaseHash: String?
    var coinbaseCode, yoomoneyHash, conversationID, securionpayKey: String?
    var fortumoHash, aamarpayTranID, ngeniusRef, coinpaymentsTxnID: String?
    var avatarPostID, coverPostID: Int?
    var avatarOrg, coverOrg, coverFull, avatarFull: String?
    var id: String?
    var url: String?
    var name: String?
    var isNotifyStopped: Int?
    var likesData: String?
    var albumData, lastseenUnixTime, lastseenStatus: String?
    var isReported, isStoryMuted: Bool?
    var isFollowingMe, isReportedUser, isOpenToWork, isProvidingService: Int?
    var providingService: Int?
    var openToWorkData: String?
    var chatTime, chatID, chatType: String?
    var mute: ChatMute?
    var lastMessage: LastMessage?
    var messageCount: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username, email, password
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar, cover
        case backgroundImage = "background_image"
        case backgroundImageStatus = "background_image_status"
        case relationshipID = "relationship_id"
        case address, working
        case workingLink = "working_link"
        case about, school, gender, birthday
        case countryID = "country_id"
        case website, facebook, google, twitter, linkedin, youtube, vk, instagram
        case okru, language
        case emailCode = "email_code"
        case src
        case ipAddress = "ip_address"
        case followPrivacy = "follow_privacy"
        case friendPrivacy = "friend_privacy"
        case postPrivacy = "post_privacy"
        case messagePrivacy = "message_privacy"
        case confirmFollowers = "confirm_followers"
        case showActivitiesPrivacy = "show_activities_privacy"
        case birthPrivacy = "birth_privacy"
        case visitPrivacy = "visit_privacy"
        case verified, lastseen, showlastseen, emailNotification
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
        case status, active, admin, type, registered
        case startUp = "start_up"
        case startUpInfo = "start_up_info"
        case startupFollow = "startup_follow"
        case startupImage = "startup_image"
        case lastEmailSent = "last_email_sent"
        case phoneNumber = "phone_number"
        case smsCode = "sms_code"
        case isPro = "is_pro"
        case proTime = "pro_time"
        case proType = "pro_type"
        case joined
        case cssFile = "css_file"
        case timezone, referrer
        case refUserID = "ref_user_id"
        case balance
        case paypalEmail = "paypal_email"
        case notificationsSound = "notifications_sound"
        case orderPostsBy = "order_posts_by"
        case socialLogin = "social_login"
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
        case sidebarData = "sidebar_data"
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
        case timeCodeSent = "time_code_sent"
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
        case avatarOrg = "avatar_org"
        case coverOrg = "cover_org"
        case coverFull = "cover_full"
        case avatarFull = "avatar_full"
        case id
        case url, name
        case isNotifyStopped = "is_notify_stopped"
        case likesData = "likes_data"
        case albumData = "album_data"
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
        case chatTime = "chat_time"
        case chatID = "chat_id"
        case chatType = "chat_type"
        case mute
        case lastMessage = "last_message"
        case messageCount = "message_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let user_id = try? values.decode(String.self, forKey: .userID) {
            self.userID = user_id
        }
        if let username = try? values.decode(String.self, forKey: .username) {
            self.username = username
        }
        if let email = try? values.decode(String.self, forKey: .email) {
            self.email = email
        }
        if let password = try? values.decode(String.self, forKey: .password) {
            self.password = password
        }
        if let firstName = try? values.decode(String.self, forKey: .firstName) {
            self.firstName = firstName
        }
        if let lastName = try? values.decode(String.self, forKey: .lastName) {
            self.lastName = lastName
        }
        if let avatar = try? values.decode(String.self, forKey: .avatar) {
            self.avatar = avatar
        }
        if let cover = try? values.decode(String.self, forKey: .cover) {
            self.cover = cover
        }
        if let backgroundImage = try? values.decode(String.self, forKey: .backgroundImage) {
            self.backgroundImage = backgroundImage
        }
        if let backgroundImageStatus = try? values.decode(String.self, forKey: .backgroundImageStatus) {
            self.backgroundImageStatus = backgroundImageStatus
        }
        if let relationshipID = try? values.decode(String.self, forKey: .relationshipID) {
            self.relationshipID = relationshipID
        }
        if let address = try? values.decode(String.self, forKey: .address) {
            self.address = address
        }
        if let working = try? values.decode(String.self, forKey: .working) {
            self.working = working
        }
        if let workingLink = try? values.decode(String.self, forKey: .workingLink) {
            self.workingLink = workingLink
        }
        if let about = try? values.decode(String.self, forKey: .about) {
            self.about = about
        }
        if let school = try? values.decode(String.self, forKey: .school) {
            self.school = school
        }
        if let gender = try? values.decode(String.self, forKey: .gender) {
            self.gender = gender
        }
        if let birthday = try? values.decode(String.self, forKey: .birthday) {
            self.birthday = birthday
        }
        if let countryID = try? values.decode(String.self, forKey: .countryID) {
            self.countryID = countryID
        }
        if let website = try? values.decode(String.self, forKey: .website) {
            self.website = website
        }
        if let facebook = try? values.decode(String.self, forKey: .facebook) {
            self.facebook = facebook
        }
        if let google = try? values.decode(String.self, forKey: .google) {
            self.google = google
        }
        if let twitter = try? values.decode(String.self, forKey: .twitter) {
            self.twitter = twitter
        }
        if let linkedin = try? values.decode(String.self, forKey: .linkedin) {
            self.linkedin = linkedin
        }
        if let youtube = try? values.decode(String.self, forKey: .youtube) {
            self.youtube = youtube
        }
        if let vk = try? values.decode(String.self, forKey: .vk) {
            self.vk = vk
        }
        if let instagram = try? values.decode(String.self, forKey: .instagram) {
            self.instagram = instagram
        }
        if let okru = try? values.decode(String.self, forKey: .okru) {
            self.okru = okru
        }
        if let language = try? values.decode(String.self, forKey: .language) {
            self.language = language
        }
        if let emailCode = try? values.decode(String.self, forKey: .emailCode) {
            self.emailCode = emailCode
        }
        if let src = try? values.decode(String.self, forKey: .src) {
            self.src = src
        }
        if let ipAddress = try? values.decode(String.self, forKey: .ipAddress) {
            self.ipAddress = ipAddress
        }
        if let followPrivacy = try? values.decode(String.self, forKey: .followPrivacy) {
            self.followPrivacy = followPrivacy
        }
        if let friendPrivacy = try? values.decode(String.self, forKey: .friendPrivacy) {
            self.friendPrivacy = friendPrivacy
        }
        if let postPrivacy = try? values.decode(String.self, forKey: .postPrivacy) {
            self.postPrivacy = postPrivacy
        }
        if let messagePrivacy = try? values.decode(String.self, forKey: .messagePrivacy) {
            self.messagePrivacy = messagePrivacy
        }
        if let confirmFollowers = try? values.decode(String.self, forKey: .confirmFollowers) {
            self.confirmFollowers = confirmFollowers
        }
        if let showActivitiesPrivacy = try? values.decode(String.self, forKey: .showActivitiesPrivacy) {
            self.showActivitiesPrivacy = showActivitiesPrivacy
        }
        if let birthPrivacy = try? values.decode(String.self, forKey: .birthPrivacy) {
            self.birthPrivacy = birthPrivacy
        }
        if let visitPrivacy = try? values.decode(String.self, forKey: .visitPrivacy) {
            self.visitPrivacy = visitPrivacy
        }
        if let verified = try? values.decode(String.self, forKey: .verified) {
            self.verified = verified
        }
        if let lastseen = try? values.decode(String.self, forKey: .lastseen) {
            self.lastseen = lastseen
        }
        if let showlastseen = try? values.decode(String.self, forKey: .showlastseen) {
            self.showlastseen = showlastseen
        }
        if let emailNotification = try? values.decode(String.self, forKey: .emailNotification) {
            self.emailNotification = emailNotification
        }
        if let eLiked = try? values.decode(String.self, forKey: .eLiked) {
            self.eLiked = eLiked
        }
        if let eWondered = try? values.decode(String.self, forKey: .eWondered) {
            self.eWondered = eWondered
        }
        if let eShared = try? values.decode(String.self, forKey: .eShared) {
            self.eShared = eShared
        }
        if let eFollowed = try? values.decode(String.self, forKey: .eFollowed) {
            self.eFollowed = eFollowed
        }
        if let eCommented = try? values.decode(String.self, forKey: .eCommented) {
            self.eCommented = eCommented
        }
        if let eVisited = try? values.decode(String.self, forKey: .eVisited) {
            self.eVisited = eVisited
        }
        if let eLikedPage = try? values.decode(String.self, forKey: .eLikedPage) {
            self.eLikedPage = eLikedPage
        }
        if let eMentioned = try? values.decode(String.self, forKey: .eMentioned) {
            self.eMentioned = eMentioned
        }
        if let eJoinedGroup = try? values.decode(String.self, forKey: .eJoinedGroup) {
            self.eJoinedGroup = eJoinedGroup
        }
        if let eAccepted = try? values.decode(String.self, forKey: .eAccepted) {
            self.eAccepted = eAccepted
        }
        if let eProfileWallPost = try? values.decode(String.self, forKey: .eProfileWallPost) {
            self.eProfileWallPost = eProfileWallPost
        }
        if let eSentmeMsg = try? values.decode(String.self, forKey: .eSentmeMsg) {
            self.eSentmeMsg = eSentmeMsg
        }
        if let eLastNotif = try? values.decode(String.self, forKey: .eLastNotif) {
            self.eLastNotif = eLastNotif
        }
        if let notificationSettings = try? values.decode(String.self, forKey: .notificationSettings) {
            self.notificationSettings = notificationSettings
        }
        if let status = try? values.decode(String.self, forKey: .status) {
            self.status = status
        }
        if let active = try? values.decode(String.self, forKey: .active) {
            self.active = active
        }
        if let admin = try? values.decode(String.self, forKey: .admin) {
            self.admin = admin
        }
        if let type = try? values.decode(String.self, forKey: .type) {
            self.type = type
        }
        if let registered = try? values.decode(String.self, forKey: .registered) {
            self.registered = registered
        }
        if let startUp = try? values.decode(String.self, forKey: .startUp) {
            self.startUp = startUp
        }
        if let startUpInfo = try? values.decode(String.self, forKey: .startUpInfo) {
            self.startUpInfo = startUpInfo
        }
        if let startupFollow = try? values.decode(String.self, forKey: .startupFollow) {
            self.startupFollow = startupFollow
        }
        if let startupImage = try? values.decode(String.self, forKey: .startupImage) {
            self.startupImage = startupImage
        }
        if let lastEmailSent = try? values.decode(String.self, forKey: .lastEmailSent) {
            self.lastEmailSent = lastEmailSent
        }
        if let phoneNumber = try? values.decode(String.self, forKey: .phoneNumber) {
            self.phoneNumber = phoneNumber
        }
        if let smsCode = try? values.decode(String.self, forKey: .smsCode) {
            self.smsCode = smsCode
        }
        if let isPro = try? values.decode(String.self, forKey: .isPro) {
            self.isPro = isPro
        }
        if let proTime = try? values.decode(String.self, forKey: .proTime) {
            self.proTime = proTime
        }
        if let proType = try? values.decode(String.self, forKey: .proType) {
            self.proType = proType
        }
        if let joined = try? values.decode(String.self, forKey: .joined) {
            self.joined = joined
        }
        if let cssFile = try? values.decode(String.self, forKey: .cssFile) {
            self.cssFile = cssFile
        }
        if let timezone = try? values.decode(String.self, forKey: .timezone) {
            self.timezone = timezone
        }
        if let referrer = try? values.decode(String.self, forKey: .referrer) {
            self.referrer = referrer
        }
        if let refUserID = try? values.decode(String.self, forKey: .refUserID) {
            self.refUserID = refUserID
        }
        if let balance = try? values.decode(String.self, forKey: .balance) {
            self.balance = balance
        }
        if let paypalEmail = try? values.decode(String.self, forKey: .paypalEmail) {
            self.paypalEmail = paypalEmail
        }
        if let notificationsSound = try? values.decode(String.self, forKey: .notificationsSound) {
            self.notificationsSound = notificationsSound
        }
        if let orderPostsBy = try? values.decode(String.self, forKey: .orderPostsBy) {
            self.orderPostsBy = orderPostsBy
        }
        if let socialLogin = try? values.decode(String.self, forKey: .socialLogin) {
            self.socialLogin = socialLogin
        }
        if let androidMDeviceID = try? values.decode(String.self, forKey: .androidMDeviceID) {
            self.androidMDeviceID = androidMDeviceID
        }
        if let iosMDeviceID = try? values.decode(String.self, forKey: .iosMDeviceID) {
            self.iosMDeviceID = iosMDeviceID
        }
        if let androidNDeviceID = try? values.decode(String.self, forKey: .androidNDeviceID) {
            self.androidNDeviceID = androidNDeviceID
        }
        if let iosNDeviceID = try? values.decode(String.self, forKey: .iosNDeviceID) {
            self.iosNDeviceID = iosNDeviceID
        }
        if let webDeviceID = try? values.decode(String.self, forKey: .webDeviceID) {
            self.webDeviceID = webDeviceID
        }
        if let wallet = try? values.decode(String.self, forKey: .wallet) {
            self.wallet = wallet
        }
        if let lat = try? values.decode(String.self, forKey: .lat) {
            self.lat = lat
        }
        if let lng = try? values.decode(String.self, forKey: .lng) {
            self.lng = lng
        }
        if let lastLocationUpdate = try? values.decode(String.self, forKey: .lastLocationUpdate) {
            self.lastLocationUpdate = lastLocationUpdate
        }
        if let shareMyLocation = try? values.decode(String.self, forKey: .shareMyLocation) {
            self.shareMyLocation = shareMyLocation
        }
        if let lastDataUpdate = try? values.decode(String.self, forKey: .lastDataUpdate) {
            self.lastDataUpdate = lastDataUpdate
        }
        if let details = try? values.decode(ChatDetails.self, forKey: .details) {
            self.details = details
        }
        if let sidebarData = try? values.decode(String.self, forKey: .sidebarData) {
            self.sidebarData = sidebarData
        }
        if let lastAvatarMod = try? values.decode(String.self, forKey: .lastAvatarMod) {
            self.lastAvatarMod = lastAvatarMod
        }
        if let lastCoverMod = try? values.decode(String.self, forKey: .lastCoverMod) {
            self.lastCoverMod = lastCoverMod
        }
        if let points = try? values.decode(String.self, forKey: .points) {
            self.points = points
        }
        if let dailyPoints = try? values.decode(String.self, forKey: .dailyPoints) {
            self.dailyPoints = dailyPoints
        }
        if let pointDayExpire = try? values.decode(String.self, forKey: .pointDayExpire) {
            self.pointDayExpire = pointDayExpire
        }
        if let lastFollowID = try? values.decode(String.self, forKey: .lastFollowID) {
            self.lastFollowID = lastFollowID
        }
        if let shareMyData = try? values.decode(String.self, forKey: .shareMyData) {
            self.shareMyData = shareMyData
        }
        if let lastLoginData = try? values.decode(String.self, forKey: .lastLoginData) {
            self.lastLoginData = lastLoginData
        }
        if let twoFactor = try? values.decode(String.self, forKey: .twoFactor) {
            self.twoFactor = twoFactor
        }
        if let twoFactorHash = try? values.decode(String.self, forKey: .twoFactorHash) {
            self.twoFactorHash = twoFactorHash
        }
        if let newEmail = try? values.decode(String.self, forKey: .newEmail) {
            self.newEmail = newEmail
        }
        if let twoFactorVerified = try? values.decode(String.self, forKey: .twoFactorVerified) {
            self.twoFactorVerified = twoFactorVerified
        }
        if let newPhone = try? values.decode(String.self, forKey: .newPhone) {
            self.newPhone = newPhone
        }
        if let infoFile = try? values.decode(String.self, forKey: .infoFile) {
            self.infoFile = infoFile
        }
        if let city = try? values.decode(String.self, forKey: .city) {
            self.city = city
        }
        if let state = try? values.decode(String.self, forKey: .state) {
            self.state = state
        }
        if let zip = try? values.decode(String.self, forKey: .zip) {
            self.zip = zip
        }
        if let schoolCompleted = try? values.decode(String.self, forKey: .schoolCompleted) {
            self.schoolCompleted = schoolCompleted
        }
        if let weatherUnit = try? values.decode(String.self, forKey: .weatherUnit) {
            self.weatherUnit = weatherUnit
        }
        if let paystackRef = try? values.decode(String.self, forKey: .paystackRef) {
            self.paystackRef = paystackRef
        }
        if let codeSent = try? values.decode(String.self, forKey: .codeSent) {
            self.codeSent = codeSent
        }
        if let timeCodeSent = try? values.decode(String.self, forKey: .timeCodeSent) {
            self.timeCodeSent = timeCodeSent
        }
        if let currentlyWorking = try? values.decode(String.self, forKey: .currentlyWorking) {
            self.currentlyWorking = currentlyWorking
        }
        if let banned = try? values.decode(String.self, forKey: .banned) {
            self.banned = banned
        }
        if let bannedReason = try? values.decode(String.self, forKey: .bannedReason) {
            self.bannedReason = bannedReason
        }
        if let coinbaseHash = try? values.decode(String.self, forKey: .coinbaseHash) {
            self.coinbaseHash = coinbaseHash
        }
        if let coinbaseCode = try? values.decode(String.self, forKey: .coinbaseCode) {
            self.coinbaseCode = coinbaseCode
        }
        if let yoomoneyHash = try? values.decode(String.self, forKey: .yoomoneyHash) {
            self.yoomoneyHash = yoomoneyHash
        }
        if let conversationID = try? values.decode(String.self, forKey: .conversationID) {
            self.conversationID = conversationID
        }
        if let securionpayKey = try? values.decode(String.self, forKey: .securionpayKey) {
            self.securionpayKey = securionpayKey
        }
        if let fortumoHash = try? values.decode(String.self, forKey: .fortumoHash) {
            self.fortumoHash = fortumoHash
        }
        if let aamarpayTranID = try? values.decode(String.self, forKey: .aamarpayTranID) {
            self.aamarpayTranID = aamarpayTranID
        }
        if let ngeniusRef = try? values.decode(String.self, forKey: .ngeniusRef) {
            self.ngeniusRef = ngeniusRef
        }
        if let coinpaymentsTxnID = try? values.decode(String.self, forKey: .coinpaymentsTxnID) {
            self.coinpaymentsTxnID = coinpaymentsTxnID
        }
        if let avatarPostID = try? values.decode(Int.self, forKey: .avatarPostID) {
            self.avatarPostID = avatarPostID
        }
        if let coverPostID = try? values.decode(Int.self, forKey: .coverPostID) {
            self.coverPostID = coverPostID
        }
        if let avatarOrg = try? values.decode(String.self, forKey: .avatarOrg) {
            self.avatarOrg = avatarOrg
        }
        if let coverOrg = try? values.decode(String.self, forKey: .coverOrg) {
            self.coverOrg = coverOrg
        }
        if let coverFull = try? values.decode(String.self, forKey: .coverFull) {
            self.coverFull = coverFull
        }
        if let avatarFull = try? values.decode(String.self, forKey: .avatarFull) {
            self.avatarFull = avatarFull
        }
        if let id = try? values.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let url = try? values.decode(String.self, forKey: .url) {
            self.url = url
        }
        if let name = try? values.decode(String.self, forKey: .name) {
            self.name = name
        }
        if let isNotifyStopped = try? values.decode(Int.self, forKey: .isNotifyStopped) {
            self.isNotifyStopped = isNotifyStopped
        }
        if let likesData = try? values.decode(String.self, forKey: .likesData) {
            self.likesData = likesData
        }
        if let albumData = try? values.decode(String.self, forKey: .albumData) {
            self.albumData = albumData
        }
        if let lastseenUnixTime = try? values.decode(String.self, forKey: .lastseenUnixTime) {
            self.lastseenUnixTime = lastseenUnixTime
        }
        if let lastseenStatus = try? values.decode(String.self, forKey: .lastseenStatus) {
            self.lastseenStatus = lastseenStatus
        }
        if let isReported = try? values.decode(Bool.self, forKey: .isReported) {
            self.isReported = isReported
        }
        if let isStoryMuted = try? values.decode(Bool.self, forKey: .isStoryMuted) {
            self.isStoryMuted = isStoryMuted
        }
        if let isFollowingMe = try? values.decode(Int.self, forKey: .isFollowingMe) {
            self.isFollowingMe = isFollowingMe
        }
        if let isReportedUser = try? values.decode(Int.self, forKey: .isReportedUser) {
            self.isReportedUser = isReportedUser
        }
        if let isOpenToWork = try? values.decode(Int.self, forKey: .isOpenToWork) {
            self.isOpenToWork = isOpenToWork
        }
        if let isProvidingService = try? values.decode(Int.self, forKey: .isProvidingService) {
            self.isProvidingService = isProvidingService
        }
        if let providingService = try? values.decode(Int.self, forKey: .providingService) {
            self.providingService = providingService
        }
        if let openToWorkData = try? values.decode(String.self, forKey: .openToWorkData) {
            self.openToWorkData = openToWorkData
        }
        if let chatTime = try? values.decode(String.self, forKey: .chatTime) {
            self.chatTime = chatTime
        }
        if let chatID = try? values.decode(String.self, forKey: .chatID) {
            self.chatID = chatID
        }
        if let chatType = try? values.decode(String.self, forKey: .chatType) {
            self.chatType = chatType
        }
        if let mute = try? values.decode(ChatMute.self, forKey: .mute) {
            self.mute = mute
        }
        if let lastMessage = try? values.decode(LastMessage.self, forKey: .lastMessage) {
            self.lastMessage = lastMessage
        }
        if let messageCount = try? values.decode(String.self, forKey: .messageCount) {
            self.messageCount = messageCount
        }
    }
    
    init(messageUser: MessageUser) {
        self.userID = messageUser.userID
        self.username = messageUser.username
        self.email = messageUser.email
        //        self.password = messageUser.password
        self.firstName = messageUser.firstName
        self.lastName = messageUser.lastName
        self.avatar = messageUser.avatar
        self.cover = messageUser.cover
        self.backgroundImage = messageUser.backgroundImage
        //        self.backgroundImageStatus = messageUser.backgroundImageStatus
        self.relationshipID = messageUser.relationshipID
        self.address = messageUser.address
        self.working = messageUser.working
        self.workingLink = messageUser.workingLink
        self.about = messageUser.about
        self.school = messageUser.school
        self.gender = messageUser.gender
        self.birthday = messageUser.birthday
        self.countryID = messageUser.countryID
        self.website = messageUser.website
        self.facebook = messageUser.facebook
        self.google = messageUser.google
        self.twitter = messageUser.twitter
        self.linkedin = messageUser.linkedin
        self.youtube = messageUser.youtube
        self.vk = messageUser.vk
        self.instagram = messageUser.instagram
        self.okru = messageUser.okru
        self.language = messageUser.language
        //        self.emailCode = messageUser.emailCode
        //        self.src = messageUser.src
        self.ipAddress = messageUser.ipAddress
        self.followPrivacy = messageUser.followPrivacy
        self.friendPrivacy = messageUser.friendPrivacy
        self.postPrivacy = messageUser.postPrivacy
        self.messagePrivacy = messageUser.messagePrivacy
        self.confirmFollowers = messageUser.confirmFollowers
        self.showActivitiesPrivacy = messageUser.showActivitiesPrivacy
        self.birthPrivacy = messageUser.birthPrivacy
        self.visitPrivacy = messageUser.visitPrivacy
        self.verified = messageUser.verified
        self.lastseen = messageUser.lastseen
        //        self.showlastseen = messageUser.showlastseen
        self.emailNotification = messageUser.emailNotification
        self.eLiked = messageUser.eLiked
        self.eWondered = messageUser.eWondered
        self.eShared = messageUser.eShared
        self.eFollowed = messageUser.eFollowed
        self.eCommented = messageUser.eCommented
        self.eVisited = messageUser.eVisited
        self.eLikedPage = messageUser.eLikedPage
        self.eMentioned = messageUser.eMentioned
        self.eJoinedGroup = messageUser.eJoinedGroup
        self.eAccepted = messageUser.eAccepted
        self.eProfileWallPost = messageUser.eProfileWallPost
        self.eSentmeMsg = messageUser.eSentmeMsg
        self.eLastNotif = messageUser.eLastNotif
        self.notificationSettings = messageUser.notificationSettings
        self.status = messageUser.status
        self.active = messageUser.active
        self.admin = messageUser.admin
        //        self.type = messageUser.type
        self.registered = messageUser.registered
        //        self.startUp = messageUser.startUp
        //        self.startUpInfo = messageUser.startUpInfo
        //        self.startupFollow = messageUser.startupFollow
        //        self.startupImage = messageUser.startupImage
        //        self.lastEmailSent = messageUser.lastEmailSent
        self.phoneNumber = messageUser.phoneNumber
        //        self.smsCode = messageUser.smsCode
        self.isPro = messageUser.isPro
        //        self.proTime = messageUser.proTime
        self.proType = messageUser.proType
        //        self.joined = messageUser.joined
        //        self.cssFile = messageUser.cssFile
        self.timezone = messageUser.timezone
        self.referrer = messageUser.referrer
        self.refUserID = messageUser.refUserID
        self.balance = messageUser.balance
        self.paypalEmail = messageUser.paypalEmail
        self.notificationsSound = messageUser.notificationsSound
        self.orderPostsBy = messageUser.orderPostsBy
        //        self.socialLogin = messageUser.socialLogin
        self.androidMDeviceID = messageUser.androidMDeviceID
        self.iosMDeviceID = messageUser.iosMDeviceID
        self.androidNDeviceID = messageUser.androidNDeviceID
        self.iosNDeviceID = messageUser.iosNDeviceID
        self.webDeviceID = messageUser.webDeviceID
        self.wallet = messageUser.wallet
        self.lat = messageUser.lat
        self.lng = messageUser.lng
        self.lastLocationUpdate = messageUser.lastLocationUpdate
        self.shareMyLocation = messageUser.shareMyLocation
        self.lastDataUpdate = messageUser.lastDataUpdate
        self.details = messageUser.details
        //        self.sidebarData = messageUser.sidebarData
        self.lastAvatarMod = messageUser.lastAvatarMod
        self.lastCoverMod = messageUser.lastCoverMod
        self.points = messageUser.points
        self.dailyPoints = messageUser.dailyPoints
        self.pointDayExpire = messageUser.pointDayExpire
        self.lastFollowID = messageUser.lastFollowID
        self.shareMyData = messageUser.shareMyData
        self.lastLoginData = messageUser.lastLoginData
        self.twoFactor = messageUser.twoFactor
        self.twoFactorHash = messageUser.twoFactorHash
        self.newEmail = messageUser.newEmail
        self.twoFactorVerified = messageUser.twoFactorVerified
        self.newPhone = messageUser.newPhone
        self.infoFile = messageUser.infoFile
        self.city = messageUser.city
        self.state = messageUser.state
        self.zip = messageUser.zip
        self.schoolCompleted = messageUser.schoolCompleted
        self.weatherUnit = messageUser.weatherUnit
        self.paystackRef = messageUser.paystackRef
        self.codeSent = messageUser.codeSent
        self.timeCodeSent = messageUser.timeCodeSent
        self.currentlyWorking = messageUser.currentlyWorking
        self.banned = messageUser.banned
        self.bannedReason = messageUser.bannedReason
        self.coinbaseHash = messageUser.coinbaseHash
        self.coinbaseCode = messageUser.coinbaseCode
        self.yoomoneyHash = messageUser.yoomoneyHash
        self.conversationID = messageUser.conversationID
        self.securionpayKey = messageUser.securionpayKey
        self.fortumoHash = messageUser.fortumoHash
        self.aamarpayTranID = messageUser.aamarpayTranID
        self.ngeniusRef = messageUser.ngeniusRef
        self.coinpaymentsTxnID = messageUser.coinpaymentsTxnID
        self.avatarPostID = messageUser.avatarPostID
        self.coverPostID = messageUser.coverPostID
        //        self.avatarOrg = messageUser.avatarOrg
        //        self.coverOrg = messageUser.coverOrg
        //        self.coverFull = messageUser.coverFull
        self.avatarFull = messageUser.avatarFull
        //        self.id = messageUser.id
        self.url = messageUser.url
        self.name = messageUser.name
        self.isNotifyStopped = messageUser.isNotifyStopped
        //        self.likesData = messageUser.likesData
        //        self.albumData = messageUser.albumData
        self.lastseenUnixTime = messageUser.lastseenUnixTime
        self.lastseenStatus = messageUser.lastseenStatus
        self.isReported = messageUser.isReported
        self.isStoryMuted = messageUser.isStoryMuted
        self.isFollowingMe = messageUser.isFollowingMe
        self.isReportedUser = messageUser.isReportedUser
        self.isOpenToWork = messageUser.isOpenToWork
        self.isProvidingService = messageUser.isProvidingService
        self.providingService = messageUser.providingService
        self.openToWorkData = messageUser.openToWorkData
        //        self.chatTime = messageUser.chatTime
        //        self.chatID = messageUser.chatID
        //        self.chatType = messageUser.chatType
        //        self.mute = messageUser.mute
        //        self.lastMessage = messageUser.lastMessage
        //        self.messageCount = messageUser.messageCount
    }
    
    init(user: Users) {
        self.userID = user._user_id
        self.username = user.username
        self.email = user._email
        self.password = user.password
        self.firstName = user._first_name
        self.lastName = user.last_name
        self.avatar = user._avatar_url
        self.cover = user._cover_url
        //        self.backgroundImage = user.backgroundImage
        //        self.backgroundImageStatus = messageUser.backgroundImageStatus
        //        self.relationshipID = user._relationshipID
        //        self.address = user.address
        //        self.working = user.working
        //        self.workingLink = user.workingLink
        //        self.about = user.about
        //        self.school = user.school
        self.gender = user._gender
        //        self.birthday = user.birthday
        //        self.countryID = user.countryID
        //        self.website = user.website
        //        self.facebook = user.facebook
        //        self.google = user.google
        //        self.twitter = user.twitter
        //        self.linkedin = user.linkedin
        //        self.youtube = user.youtube
        //        self.vk = user.vk
        //        self.instagram = user.instagram
        //        self.okru = user.okru
        //        self.language = user.language
        //        self.emailCode = messageUser.emailCode
        //        self.src = messageUser.src
        self.ipAddress = user._ip_address
        //        self.followPrivacy = user.followPrivacy
        //        self.friendPrivacy = user.friendPrivacy
        //        self.postPrivacy = user.postPrivacy
        //        self.messagePrivacy = user.messagePrivacy
        //        self.confirmFollowers = user.confirmFollowers
        //        self.showActivitiesPrivacy = user.showActivitiesPrivacy
        //        self.birthPrivacy = user.birthPrivacy
        //        self.visitPrivacy = user.visitPrivacy
        //        self.verified = user.verified
        self.lastseen = user._last_seen_status
        //        self.showlastseen = messageUser.showlastseen
        //        self.emailNotification = user.emailNotification
        //        self.eLiked = user.eLiked
        //        self.eWondered = user.eWondered
        //        self.eShared = user.eShared
        //        self.eFollowed = user.eFollowed
        //        self.eCommented = user.eCommented
        //        self.eVisited = user.eVisited
        //        self.eLikedPage = user.eLikedPage
        //        self.eMentioned = user.eMentioned
        //        self.eJoinedGroup = user.eJoinedGroup
        //        self.eAccepted = user.eAccepted
        //        self.eProfileWallPost = user.eProfileWallPost
        //        self.eSentmeMsg = user.eSentmeMsg
        //        self.eLastNotif = user.eLastNotif
        //        self.notificationSettings = user.notificationSettings
        //        self.status = user.status
        //        self.active = user.active
        //        self.admin = user.admin
        //        self.type = messageUser.type
        //        self.registered = user.registered
        //        self.startUp = messageUser.startUp
        //        self.startUpInfo = messageUser.startUpInfo
        //        self.startupFollow = messageUser.startupFollow
        //        self.startupImage = messageUser.startupImage
        //        self.lastEmailSent = messageUser.lastEmailSent
        //        self.phoneNumber = user.phoneNumber
        //        self.smsCode = messageUser.smsCode
        //        self.isPro = user.isPro
        //        self.proTime = messageUser.proTime
        //        self.proType = user.proType
        //        self.joined = messageUser.joined
        //        self.cssFile = messageUser.cssFile
        //        self.timezone = user.timezone
        //        self.referrer = user.referrer
        //        self.refUserID = user.refUserID
        //        self.balance = user.balance
        //        self.paypalEmail = user.paypalEmail
        //        self.notificationsSound = user.notificationsSound
        //        self.orderPostsBy = user.orderPostsBy
        //        self.socialLogin = messageUser.socialLogin
        //        self.androidMDeviceID = user.androidMDeviceID
        //        self.iosMDeviceID = user.iosMDeviceID
        //        self.androidNDeviceID = user.androidNDeviceID
        //        self.iosNDeviceID = user.iosNDeviceID
        //        self.webDeviceID = user.webDeviceID
        //        self.wallet = user.wallet
        self.lat = user.lat
        self.lng = user.lng
        //        self.lastLocationUpdate = user.lastLocationUpdate
        //        self.shareMyLocation = user.shareMyLocation
        //        self.lastDataUpdate = user.lastDataUpdate
        //        self.details = user.details
        //        self.sidebarData = messageUser.sidebarData
        //        self.lastAvatarMod = user.lastAvatarMod
        //        self.lastCoverMod = user.lastCoverMod
        //        self.points = user.points
        //        self.dailyPoints = user.dailyPoints
        //        self.pointDayExpire = user.pointDayExpire
        //        self.lastFollowID = user.lastFollowID
        //        self.shareMyData = user.shareMyData
        //        self.lastLoginData = user.lastLoginData
        //        self.twoFactor = user.twoFactor
        //        self.twoFactorHash = user.twoFactorHash
        //        self.newEmail = user.newEmail
        //        self.twoFactorVerified = user.twoFactorVerified
        //        self.newPhone = user.newPhone
        //        self.infoFile = user.infoFile
        //        self.city = user.city
        //        self.state = user.state
        //        self.zip = user.zip
        //        self.schoolCompleted = user.schoolCompleted
        //        self.weatherUnit = user.weatherUnit
        //        self.paystackRef = user.paystackRef
        //        self.codeSent = user.codeSent
        //        self.timeCodeSent = user.timeCodeSent
        //        self.currentlyWorking = user.currentlyWorking
        //        self.banned = user.banned
        //        self.bannedReason = user.bannedReason
        //        self.coinbaseHash = user.coinbaseHash
        //        self.coinbaseCode = user.coinbaseCode
        //        self.yoomoneyHash = user.yoomoneyHash
        //        self.conversationID = user.conversationID
        //        self.securionpayKey = user.securionpayKey
        //        self.fortumoHash = user.fortumoHash
        //        self.aamarpayTranID = user.aamarpayTranID
        //        self.ngeniusRef = user.ngeniusRef
        //        self.coinpaymentsTxnID = user.coinpaymentsTxnID
        //        self.avatarPostID = user.avatarPostID
        //        self.coverPostID = user.coverPostID
        //        self.avatarOrg = messageUser.avatarOrg
        //        self.coverOrg = messageUser.coverOrg
        //        self.coverFull = messageUser.coverFull
        //        self.avatarFull = user.avatarFull
        //        self.id = messageUser.id
        //        self.url = user.url
        self.name = user.name
        //        self.isNotifyStopped = user.isNotifyStopped
        //        self.likesData = messageUser.likesData
        //        self.albumData = messageUser.albumData
        //        self.lastseenUnixTime = user.lastseenUnixTime
        //        self.lastseenStatus = user.lastseenStatus
        //        self.isReported = user.isReported
        //        self.isStoryMuted = user.isStoryMuted
        //        self.isFollowingMe = user.isFollowingMe
        //        self.isReportedUser = user.isReportedUser
        //        self.isOpenToWork = user.isOpenToWork
        //        self.isProvidingService = user.isProvidingService
        //        self.providingService = user.providingService
        //        self.openToWorkData = user.openToWorkData
        //        self.chatTime = messageUser.chatTime
        //        self.chatID = messageUser.chatID
        //        self.chatType = messageUser.chatType
        //        self.mute = messageUser.mute
        //        self.lastMessage = messageUser.lastMessage
        //        self.messageCount = messageUser.messageCount
    }
    
    var _userID: String {
        get {
            return self.userID ?? ""
        }
    }
    
    var _username: String {
        get {
            return self.username ?? ""
        }
    }
    
    var _email: String {
        get {
            return self.email ?? ""
        }
    }
    
    var _password: String {
        get {
            return self.password ?? ""
        }
    }
    
    var _firstName: String {
        get {
            return self.firstName ?? ""
        }
    }
    
    var _lastName: String {
        get {
            return self.lastName ?? ""
        }
    }
    
    var _avatar: String {
        get {
            return self.avatar ?? ""
        }
    }
    
    var _cover: String {
        get {
            return self.cover ?? ""
        }
    }
    
    var _backgroundImage: String {
        get {
            return self.backgroundImage ?? ""
        }
    }
    
    var _backgroundImageStatus: String {
        get {
            return self.backgroundImageStatus ?? ""
        }
    }
    
    var _relationshipID: String {
        get {
            return self.relationshipID ?? ""
        }
    }
    
    var _address: String {
        get {
            return self.address ?? ""
        }
    }
    
    var _working: String {
        get {
            return self.working ?? ""
        }
    }
    
    var _workingLink: String {
        get {
            return self.workingLink ?? ""
        }
    }
    
    var _about: String {
        get {
            return self.about ?? ""
        }
    }
    
    var _school: String {
        get {
            return self.school ?? ""
        }
    }
    
    var _gender: String {
        get {
            return self.gender ?? ""
        }
    }
    
    var _birthday: String {
        get {
            return self.birthday ?? ""
        }
    }
    
    var _countryID: String {
        get {
            return self.countryID ?? ""
        }
    }
    
    var _website: String {
        get {
            return self.website ?? ""
        }
    }
    
    var _facebook: String {
        get {
            return self.facebook ?? ""
        }
    }
    
    var _google: String {
        get {
            return self.google ?? ""
        }
    }
    
    var _twitter: String {
        get {
            return self.twitter ?? ""
        }
    }
    
    var _linkedin: String {
        get {
            return self.linkedin ?? ""
        }
    }
    
    var _youtube: String {
        get {
            return self.youtube ?? ""
        }
    }
    
    var _vk: String {
        get {
            return self.vk ?? ""
        }
    }
    
    var _instagram: String {
        get {
            return self.instagram ?? ""
        }
    }
    
    var _okru: String {
        get {
            return self.okru ?? ""
        }
    }
    
    var _language: String {
        get {
            return self.language ?? ""
        }
    }
    
    var _emailCode: String {
        get {
            return self.emailCode ?? ""
        }
    }
    
    var _src: String {
        get {
            return self.src ?? ""
        }
    }
    
    var _ipAddress: String {
        get {
            return self.ipAddress ?? ""
        }
    }
    
    var _followPrivacy: String {
        get {
            return self.followPrivacy ?? ""
        }
    }
    
    var _friendPrivacy: String {
        get {
            return self.friendPrivacy ?? ""
        }
    }
    
    var _postPrivacy: String {
        get {
            return self.postPrivacy ?? ""
        }
    }
    
    var _messagePrivacy: String {
        get {
            return self.messagePrivacy ?? ""
        }
    }
    
    var _confirmFollowers: String {
        get {
            return self.confirmFollowers ?? ""
        }
    }
    
    var _showActivitiesPrivacy: String {
        get {
            return self.showActivitiesPrivacy ?? ""
        }
    }
    
    var _birthPrivacy: String {
        get {
            return self.birthPrivacy ?? ""
        }
    }
    
    var _visitPrivacy: String {
        get {
            return self.visitPrivacy ?? ""
        }
    }
    
    var _verified: String {
        get {
            return self.verified ?? ""
        }
    }
    
    var _lastseen: String {
        get {
            return self.lastseen ?? ""
        }
    }
    
    var _showlastseen: String {
        get {
            return self.showlastseen ?? ""
        }
    }
    
    var _emailNotification: String {
        get {
            return self.emailNotification ?? ""
        }
    }
    
    var _eLiked: String {
        get {
            return self.eLiked ?? ""
        }
    }
    
    var _eWondered: String {
        get {
            return self.eWondered ?? ""
        }
    }
    
    var _eShared: String {
        get {
            return self.eShared ?? ""
        }
    }
    
    var _eFollowed: String {
        get {
            return self.eFollowed ?? ""
        }
    }
    
    var _eCommented: String {
        get {
            return self.eCommented ?? ""
        }
    }
    
    var _eVisited: String {
        get {
            return self.eVisited ?? ""
        }
    }
    
    var _eLikedPage: String {
        get {
            return self.eLikedPage ?? ""
        }
    }
    
    var _eMentioned: String {
        get {
            return self.eMentioned ?? ""
        }
    }
    
    var _eJoinedGroup: String {
        get {
            return self.eJoinedGroup ?? ""
        }
    }
    
    var _eAccepted: String {
        get {
            return self.eAccepted ?? ""
        }
    }
    
    var _eProfileWallPost: String {
        get {
            return self.eProfileWallPost ?? ""
        }
    }
    
    var _eSentmeMsg: String {
        get {
            return self.eSentmeMsg ?? ""
        }
    }
    
    var _eLastNotif: String {
        get {
            return self.eLastNotif ?? ""
        }
    }
    
    var _status: String {
        get {
            return self.status ?? ""
        }
    }
    
    var _active: String {
        get {
            return self.active ?? ""
        }
    }
    
    var _admin: String {
        get {
            return self.admin ?? ""
        }
    }
    
    var _type: String {
        get {
            return self.type ?? ""
        }
    }
    
    var _registered: String {
        get {
            return self.registered ?? ""
        }
    }
    
    var _startUp: String {
        get {
            return self.startUp ?? ""
        }
    }
    
    var _startUpInfo: String {
        get {
            return self.startUpInfo ?? ""
        }
    }
    
    var _startupFollow: String {
        get {
            return self.startupFollow ?? ""
        }
    }
    
    var _startupImage: String {
        get {
            return self.startupImage ?? ""
        }
    }
    
    var _lastEmailSent: String {
        get {
            return self.lastEmailSent ?? ""
        }
    }
    
    var _phoneNumber: String {
        get {
            return self.phoneNumber ?? ""
        }
    }
    
    var _smsCode: String {
        get {
            return self.smsCode ?? ""
        }
    }
    
    var _isPro: String {
        get {
            return self.isPro ?? ""
        }
    }
    
    var _proTime: String {
        get {
            return self.proTime ?? ""
        }
    }
    
    var _proType: String {
        get {
            return self.proType ?? ""
        }
    }
    
    var _joined: String {
        get {
            return self.joined ?? ""
        }
    }
    
    var _cssFile: String {
        get {
            return self.cssFile ?? ""
        }
    }
    
    var _timezone: String {
        get {
            return self.timezone ?? ""
        }
    }
    
    var _referrer: String {
        get {
            return self.referrer ?? ""
        }
    }
    
    var _refUserID: String {
        get {
            return self.refUserID ?? ""
        }
    }
    
    var _balance: String {
        get {
            return self.balance ?? ""
        }
    }
    
    var _paypalEmail: String {
        get {
            return self.paypalEmail ?? ""
        }
    }
    
    var _notificationsSound: String {
        get {
            return self.notificationsSound ?? ""
        }
    }
    
    var _orderPostsBy: String {
        get {
            return self.orderPostsBy ?? ""
        }
    }
    
    var _socialLogin: String {
        get {
            return self.socialLogin ?? ""
        }
    }
    
    var _androidMDeviceID: String {
        get {
            return self.androidMDeviceID ?? ""
        }
    }
    
    var _iosMDeviceID: String {
        get {
            return self.iosMDeviceID ?? ""
        }
    }
    
    var _androidNDeviceID: String {
        get {
            return self.androidNDeviceID ?? ""
        }
    }
    
    var _iosNDeviceID: String {
        get {
            return self.iosNDeviceID ?? ""
        }
    }
    
    var _webDeviceID: String {
        get {
            return self.webDeviceID ?? ""
        }
    }
    
    var _wallet: String {
        get {
            return self.wallet ?? ""
        }
    }
    
    var _lat: String {
        get {
            return self.lat ?? ""
        }
    }
    
    var _lng: String {
        get {
            return self.lng ?? ""
        }
    }
    
    var _lastLocationUpdate: String {
        get {
            return self.lastLocationUpdate ?? ""
        }
    }
    
    var _shareMyLocation: String {
        get {
            return self.shareMyLocation ?? ""
        }
    }
    
    var _lastDataUpdate: String {
        get {
            return self.lastDataUpdate ?? ""
        }
    }
    
    var _lastAvatarMod: String {
        get {
            return self.lastAvatarMod ?? ""
        }
    }
    
    var _lastCoverMod: String {
        get {
            return self.lastCoverMod ?? ""
        }
    }
    
    var _points: String {
        get {
            return self.points ?? ""
        }
    }
    
    var _dailyPoints: String {
        get {
            return self.dailyPoints ?? ""
        }
    }
    
    var _pointDayExpire: String {
        get {
            return self.pointDayExpire ?? ""
        }
    }
    
    var _lastFollowID: String {
        get {
            return self.lastFollowID ?? ""
        }
    }
    
    var _shareMyData: String {
        get {
            return self.shareMyData ?? ""
        }
    }
    
    var _twoFactor: String {
        get {
            return self.twoFactor ?? ""
        }
    }
    
    var _twoFactorHash: String {
        get {
            return self.twoFactorHash ?? ""
        }
    }
    
    var _newEmail: String {
        get {
            return self.newEmail ?? ""
        }
    }
    
    var _twoFactorVerified: String {
        get {
            return self.twoFactorVerified ?? ""
        }
    }
    
    var _newPhone: String {
        get {
            return self.newPhone ?? ""
        }
    }
    
    var _infoFile: String {
        get {
            return self.infoFile ?? ""
        }
    }
    
    var _city: String {
        get {
            return self.city ?? ""
        }
    }
    
    var _state: String {
        get {
            return self.state ?? ""
        }
    }
    
    var _zip: String {
        get {
            return self.zip ?? ""
        }
    }
    
    var _schoolCompleted: String {
        get {
            return self.schoolCompleted ?? ""
        }
    }
    
    var _weatherUnit: String {
        get {
            return self.weatherUnit ?? ""
        }
    }
    
    var _paystackRef: String {
        get {
            return self.paystackRef ?? ""
        }
    }
    
    var _codeSent: String {
        get {
            return self.codeSent ?? ""
        }
    }
    
    var _timeCodeSent: String {
        get {
            return self.timeCodeSent ?? ""
        }
    }
    
    var _currentlyWorking: String {
        get {
            return self.currentlyWorking ?? ""
        }
    }
    
    var _banned: String {
        get {
            return self.banned ?? ""
        }
    }
    
    var _bannedReason: String {
        get {
            return self.bannedReason ?? ""
        }
    }
    
    var _coinbaseHash: String {
        get {
            return self.coinbaseHash ?? ""
        }
    }
    
    var _coinbaseCode: String {
        get {
            return self.coinbaseCode ?? ""
        }
    }
    
    var _yoomoneyHash: String {
        get {
            return self.yoomoneyHash ?? ""
        }
    }
    
    var _conversationID: String {
        get {
            return self.conversationID ?? ""
        }
    }
    
    var _securionpayKey: String {
        get {
            return self.securionpayKey ?? ""
        }
    }
    
    var _fortumoHash: String {
        get {
            return self.fortumoHash ?? ""
        }
    }
    
    var _aamarpayTranID: String {
        get {
            return self.aamarpayTranID ?? ""
        }
    }
    
    var _ngeniusRef: String {
        get {
            return self.ngeniusRef ?? ""
        }
    }
    
    var _coinpaymentsTxnID: String {
        get {
            return self.coinpaymentsTxnID ?? ""
        }
    }
    
    var _avatarPostID: Int {
        get {
            return self.avatarPostID ?? 0
        }
    }
    
    var _coverPostID: Int {
        get {
            return self.coverPostID ?? 0
        }
    }
    
    var _avatarOrg: String {
        get {
            return self.avatarOrg ?? ""
        }
    }
    
    var _coverOrg: String {
        get {
            return self.coverOrg ?? ""
        }
    }
    
    var _coverFull: String {
        get {
            return self.coverFull ?? ""
        }
    }
    
    var _avatarFull: String {
        get {
            return self.avatarFull ?? ""
        }
    }
    
    var _id: String {
        get {
            return self.id ?? ""
        }
    }
    
    var _url: String {
        get {
            return self.url ?? ""
        }
    }
    
    var _name: String {
        get {
            return self.name ?? ""
        }
    }
    
    var _isNotifyStopped: Int {
        get {
            return self.isNotifyStopped ?? 0
        }
    }
    
    var _likesData: String {
        get {
            return self.likesData ?? ""
        }
    }
    
    var _albumData: String {
        get {
            return self.albumData ?? ""
        }
    }
    
    var _lastseenUnixTime: String {
        get {
            return self.lastseenUnixTime ?? ""
        }
    }
    
    var _lastSeenStatus: String {
        get {
            return self.lastseenStatus ?? ""
        }
    }
    
    var _isReported: Bool {
        get {
            return self.isReported ?? false
        }
    }
    
    var _isStoryMuted: Bool {
        get {
            return self.isStoryMuted ?? false
        }
    }
    
    var _isFollowingMe: Int {
        get {
            return self.isFollowingMe ?? 0
        }
    }
    
    var _isReportedUser: Int {
        get {
            return self.isReportedUser ?? 0
        }
    }
    
    var _isOpenToWork: Int {
        get {
            return self.isOpenToWork ?? 0
        }
    }
    
    var _isProvidingService: Int {
        get {
            return self.isProvidingService ?? 0
        }
    }
    
    var _providingService: Int {
        get {
            return self.providingService ?? 0
        }
    }
    
    var _openToWorkData: String {
        get {
            return self.openToWorkData ?? ""
        }
    }
    
    var _chatTime: String {
        get {
            return self.chatTime ?? ""
        }
    }
    
    var _chatID: String {
        get {
            return self.chatID ?? ""
        }
    }
    
    var _chatType: String {
        get {
            return self.chatType ?? ""
        }
    }
    
    var _messageCount: String {
        get {
            return self.messageCount ?? ""
        }
    }
}

// MARK: - Details
struct ChatDetails: Codable {
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

// MARK: - LastMessage
struct LastMessage: Codable {
    var id, fromID, groupID, pageID: String?
    var toID, text, media, mediaFileName: String?
    var mediaFileNames, time, seen, deletedOne: String?
    var deletedTwo, sentPush, notificationID, typeTwo: String?
    var stickers, productID, lat, lng: String?
    var replyID, storyID, broadcastID, forward: String?
    var listening: String?
    var messageUser: MessageUser?
    var onwer: Int?
    var reaction: Reaction?
    var timeText, position, type: String?
    var product: MessageProductModel?
    var fileSize: String?
    var chatColor: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case groupID = "group_id"
        case pageID = "page_id"
        case toID = "to_id"
        case text, media, mediaFileName, mediaFileNames, time, seen
        case deletedOne = "deleted_one"
        case deletedTwo = "deleted_two"
        case sentPush = "sent_push"
        case notificationID = "notification_id"
        case typeTwo = "type_two"
        case stickers
        case productID = "product_id"
        case lat, lng
        case replyID = "reply_id"
        case storyID = "story_id"
        case broadcastID = "broadcast_id"
        case forward, listening, messageUser, onwer, reaction
        case timeText = "time_text"
        case position, type, product
        case fileSize = "file_size"
        case chatColor = "chat_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try? container.decode(String.self, forKey: .id) {
            self.id = id
        }
        if let fromID = try? container.decode(String.self, forKey: .fromID) {
            self.fromID = fromID
        }
        if let groupID = try? container.decode(String.self, forKey: .groupID) {
            self.groupID = groupID
        }
        if let pageID = try? container.decode(String.self, forKey: .pageID) {
            self.pageID = pageID
        }
        if let toID = try? container.decode(String.self, forKey: .toID) {
            self.toID = toID
        }
        if let text = try? container.decode(String.self, forKey: .text) {
            self.text = text
        }
        if let media = try? container.decode(String.self, forKey: .media) {
            self.media = media
        }
        if let mediaFileName = try? container.decode(String.self, forKey: .mediaFileName) {
            self.mediaFileName = mediaFileName
        }
        if let mediaFileNames = try? container.decode(String.self, forKey: .mediaFileNames) {
            self.mediaFileNames = mediaFileNames
        }
        if let time = try? container.decode(String.self, forKey: .time) {
            self.time = time
        }
        if let seen = try? container.decode(String.self, forKey: .seen) {
            self.seen = seen
        }
        if let deletedOne = try? container.decode(String.self, forKey: .deletedOne) {
            self.deletedOne = deletedOne
        }
        if let deletedTwo = try? container.decode(String.self, forKey: .deletedTwo) {
            self.deletedTwo = deletedTwo
        }
        if let sentPush = try? container.decode(String.self, forKey: .sentPush) {
            self.sentPush = sentPush
        }
        if let notificationID = try? container.decode(String.self, forKey: .notificationID) {
            self.notificationID = notificationID
        }
        if let typeTwo = try? container.decode(String.self, forKey: .typeTwo) {
            self.typeTwo = typeTwo
        }
        if let stickers = try? container.decode(String.self, forKey: .stickers) {
            self.stickers = stickers
        }
        if let productID = try? container.decode(String.self, forKey: .productID) {
            self.productID = productID
        }
        if let lat = try? container.decode(String.self, forKey: .lat) {
            self.lat = lat
        }
        if let lng = try? container.decode(String.self, forKey: .lng) {
            self.lng = lng
        }
        if let replyID = try? container.decode(String.self, forKey: .replyID) {
            self.replyID = replyID
        }
        if let storyID = try? container.decode(String.self, forKey: .storyID) {
            self.storyID = storyID
        }
        if let broadcastID = try? container.decode(String.self, forKey: .broadcastID) {
            self.broadcastID = broadcastID
        }
        if let forward = try? container.decode(String.self, forKey: .forward) {
            self.forward = forward
        }
        if let listening = try? container.decode(String.self, forKey: .listening) {
            self.listening = listening
        }
        if let messageUser = try? container.decode(MessageUser.self, forKey: .messageUser) {
            self.messageUser = messageUser
        }
        if let onwer = try? container.decode(Int.self, forKey: .onwer) {
            self.onwer = onwer
        }
        if let reaction = try? container.decode(Reaction.self, forKey: .reaction) {
            self.reaction = reaction
        }
        if let timeText = try? container.decode(String.self, forKey: .timeText) {
            self.timeText = timeText
        }
        if let position = try? container.decode(String.self, forKey: .position) {
            self.position = position
        }
        if let type = try? container.decode(String.self, forKey: .type) {
            self.type = type
        }
        if let product = try? container.decode(MessageProductModel.self, forKey: .product) {
            self.product = product
        }
        if let fileSize = try? container.decode(String.self, forKey: .fileSize) {
            self.fileSize = fileSize
        }
        if let chatColor = try? container.decode(String.self, forKey: .chatColor) {
            self.chatColor = chatColor
        }
    }
    
    var _id: String {
        get {
            return self.id ?? ""
        }
    }
    
    var _fromID: String {
        get {
            return self.fromID ?? ""
        }
    }
    
    var _groupID: String {
        get {
            return self.groupID ?? ""
        }
    }
    
    var _pageID: String {
        get {
            return self.pageID ?? ""
        }
    }
    
    var _toID: String {
        get {
            return self.toID ?? ""
        }
    }
    
    var _text: String {
        get {
            return self.text ?? ""
        }
    }
    
    var _media: String {
        get {
            return self.media ?? ""
        }
    }
    
    var _mediaFileName: String {
        get {
            return self.mediaFileName ?? ""
        }
    }
    
    var _mediaFileNames: String {
        get {
            return self.mediaFileNames ?? ""
        }
    }
    
    var _time: String {
        get {
            return self.time ?? ""
        }
    }
    
    var _seen: String {
        get {
            return self.seen ?? ""
        }
    }
    
    var _deletedOne: String {
        get {
            return self.deletedOne ?? ""
        }
    }
    
    var _deletedTwo: String {
        get {
            return self.deletedTwo ?? ""
        }
    }
    
    var _sentPush: String {
        get {
            return self.sentPush ?? ""
        }
    }
    
    var _notificationID: String {
        get {
            return self.notificationID ?? ""
        }
    }
    
    var _typeTwo: String {
        get {
            return self.typeTwo ?? ""
        }
    }
    
    var _stickers: String {
        get {
            return self.stickers ?? ""
        }
    }
    
    var _productID: String {
        get {
            return self.productID ?? ""
        }
    }
    
    var _lat: String {
        get {
            return self.lat ?? ""
        }
    }
    
    var _lng: String {
        get {
            return self.lng ?? ""
        }
    }
    
    var _replyID: String {
        get {
            return self.replyID ?? ""
        }
    }
    
    var _storyID: String {
        get {
            return self.storyID ?? ""
        }
    }
    
    var _broadcastID: String {
        get {
            return self.broadcastID ?? ""
        }
    }
    
    var _forward: String {
        get {
            return self.forward ?? ""
        }
    }
    
    var _listening: String {
        get {
            return self.listening ?? ""
        }
    }
    
    var _onwer: Int {
        get {
            return self.onwer ?? 0
        }
    }
    
    var _timeText: String {
        get {
            return self.timeText ?? ""
        }
    }
    
    var _position: String {
        get {
            return self.position ?? ""
        }
    }
    
    var _type: String {
        get {
            return self.type ?? ""
        }
    }
    
    var _fileSize: String {
        get {
            return self.fileSize ?? "0"
        }
    }
    
    var _chatColor: String {
        get {
            return self.chatColor ?? ""
        }
    }
}

// MARK: - MessageUser
struct MessageUser: Codable {
    var userID, username, email, firstName: String?
    var lastName: String?
    var avatar, cover: String?
    var backgroundImage, relationshipID, address, working: String?
    var workingLink, about, school, gender: String?
    var birthday, countryID, website, facebook: String?
    var google, twitter, linkedin, youtube: String?
    var vk, instagram: String?
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
    var details: ChatDetails?
    var lastAvatarMod, lastCoverMod, points, dailyPoints: String?
    var pointDayExpire, lastFollowID, shareMyData, lastLoginData: String?
    var twoFactor, twoFactorHash, newEmail, twoFactorVerified: String?
    var newPhone, infoFile, city, state: String?
    var zip, schoolCompleted, weatherUnit, paystackRef: String?
    var codeSent: String?
    var timeCodeSent: String?
    var currentlyWorking, banned, bannedReason, coinbaseHash: String?
    var coinbaseCode, yoomoneyHash, conversationID, securionpayKey: String?
    var fortumoHash, aamarpayTranID, ngeniusRef, coinpaymentsTxnID: String?
    var avatarPostID, coverPostID: Int?
    var avatarFull: String?
    var url: String?
    var name: String?
    var isNotifyStopped: Int?
    var lastseenUnixTime, lastseenStatus: String?
    var isReported, isStoryMuted: Bool?
    var isFollowingMe, isReportedUser, isOpenToWork, isProvidingService: Int?
    var providingService: Int?
    var openToWorkData: String?
    
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
        case website, facebook, google, twitter, linkedin, youtube, vk, instagram
        case okru, language
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
        case timeCodeSent = "time_code_sent"
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
        case url, name
        case isNotifyStopped = "is_notify_stopped"
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
    }
}

// MARK: - Reaction
struct Reaction: Codable {
    var isReacted: Bool?
    var type: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case isReacted = "is_reacted"
        case type, count
    }
}

// MARK: - Mute
struct ChatMute: Codable {
    var notify, callChat, archive, fav: String?
    var pin: String?
    
    enum CodingKeys: String, CodingKey {
        case notify
        case callChat = "call_chat"
        case archive, fav, pin
    }
}

