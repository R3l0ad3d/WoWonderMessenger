//
//  ChatDummyData.swift
//  WoWonder
//
//  Created by Fs on 29/09/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

func ChatBottomSiteDummyData() -> [ChatBottomSite] {
    var objChatBottomSite: [ChatBottomSite] = []
    
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Message Info", nameImage: UIImage(named: "ic_info")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Delete Message", nameImage: UIImage(named: "ic_New_delete")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Reply", nameImage: UIImage(named: "ic_Replay")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Forward", nameImage: UIImage(named: "ic_New_forward")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Pin", nameImage: UIImage(named: "ic_New_pin")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Favorite", nameImage: UIImage(named: "ic_New_star")))
    
    return  objChatBottomSite
}

func groupBottomSiteDummyData() -> [ChatBottomSite] {
    var objChatBottomSite: [ChatBottomSite] = []
    
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Message Info", nameImage: UIImage(named: "ic_info")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Delete Message", nameImage: UIImage(named: "ic_New_delete")))
    objChatBottomSite.append(ChatBottomSite(nameTitle: "Reply", nameImage: UIImage(named: "ic_Replay")))
    
    return  objChatBottomSite
}

// Profile Screen Data
struct Profile {
    var chatTitle: String?
    var chatderipication: String?
}

func generDummyData() -> [Profile] {
    var objProfile: [Profile] = []
    
    objProfile.append(Profile(chatTitle: "Personal Information", chatderipication: "Update your name and personal information on your account"))
    objProfile.append(Profile(chatTitle: "Account Information", chatderipication: "Update the contact information Asociated with your account"))
    objProfile.append(Profile(chatTitle: "Blocked Users", chatderipication: "Review people you previously blocked"))
    objProfile.append(Profile(chatTitle: "Delete Account", chatderipication: "Deleting your account will permanently remove your photos, your profile, and all you progress"))
    objProfile.append(Profile(chatTitle: "Logout Account", chatderipication: "Are you sure want to logout?"))
    
    return objProfile
}

func displayDummydata() -> [Profile] {

    var objProfile: [Profile] = []
    
    objProfile.append(Profile(chatTitle: "Wallpaper", chatderipication: "Change the background color of the conversation"))
    objProfile.append(Profile(chatTitle: "Theme", chatderipication: "Update the contact information Asociated with your account"))
    
    return objProfile
    
}

func SecurityDummyData() -> [Profile] {
    var objProfile: [Profile] = []
    objProfile.append(Profile(chatTitle: "Change Password", chatderipication: "It’s a good idea to use a strong password that you are not using elsewhere"))
    objProfile.append(Profile(chatTitle: "Two - factor authentication", chatderipication: "We will ask for a login code if we give an attempted login from an unrecognized device or browser"))
    objProfile.append(Profile(chatTitle: "Manage Sessions", chatderipication: "Review a lsit of devices where you won’t have to use a login code "))
    return objProfile
}

func mediaDummydata() -> [Profile] {
    var objProfile: [Profile] = []
    objProfile.append(Profile(chatTitle: "When using mobile data", chatderipication: "When using mobile data"))
    objProfile.append(Profile(chatTitle: "When connected on Wi-Fi data", chatderipication: "No Media"))
    
    return objProfile
}

func PrivacyDummyData() -> [Profile] {
    var objProfile: [Profile] = []
    objProfile.append(Profile(chatTitle: "Who can follow me?", chatderipication: "Everyone"))
    objProfile.append(Profile(chatTitle: "Who can message me?", chatderipication: "Everyone"))
    objProfile.append(Profile(chatTitle: "Who can see my birthday?", chatderipication: "Everyone"))
    objProfile.append(Profile(chatTitle: "Show online Users?", chatderipication: "Show when users are online"))
    return objProfile
}

//MARK: - notofactionDummyData
func notofactionDummyData() -> [Profile] {
    var objProfile: [Profile] = []
    objProfile.append(Profile(chatTitle: "Chat Heads", chatderipication: "Turn notifications when you receive message"))
    objProfile.append(Profile(chatTitle: "Notification Popup", chatderipication: "Get sounds for incoming and outgoing messages"))
    objProfile.append(Profile(chatTitle: "Conversation tones", chatderipication: "Play sounds for incoming and outgoing messages"))
    return objProfile
}
