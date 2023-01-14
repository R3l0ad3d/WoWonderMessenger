

import UIKit
import WowonderMessengerSDK
struct AppConstant {
    //cert key for demo wowonder
    //Demo Key
    /*
     VjFaV2IxVXdNVWhVYTJ4VlZrWndUbHBXVW5OamJHUnpXVE5vYTJFemFERlhhMmhoWVRBeGNXSkVSbGhoTWxKWVdsWldOR1JHVW5WWGJXeFdaVzFqTlNOV1JtUjNVV3N4Vms1SWJGTmlXR2hRVldwR1IwMUdVbFZUYkhCc1ZtNUNSVlJWVWtOWGJWWnlZVE5rVlZKdFVrZFVhMVY0VWxaV1dWVnRSbGRTVlhCNFZrZDRVMVpyTVZkalNFWlRZbGhDYUZaclZYZGtkejA5UURFek1XTTBOekZqT0dJMFpXUm1Oall5WkdRd1pXSm1OMkZrWmpOak0yUTNNelkxT0RNNFlqa2tNVGswTWpVeU16az0=
     
     VjFaV2IxVXdNVWhVYTJ4VlZrWndUbHBXVW5KbGJIQkZWRzF3YTFadVFqRlZNakUwV1ZaWmQwNUlhRmhXZWtaSVdrWmtUMDVWTlZsV2JVWllVbXRWTlNOV01XUjNWakpGZDAxWVJtaFNNbWhRV1ZkNGMwMUdVbGRWYTNCT1VtMTNNVlJWVWtOWlYwcFhVbXBTVlZKdFVreFphMXAzVWxaYVdWVnJPV2hpV0ZFeFZrZDBhMVl5U2xkaVJsWlZWa1ZhYUZaclpHOWtRVDA5UURnNE56SmlaV0psTXpNeE9HWTVaV0k1TkdReU1UQTFORFl3TldJd09XTXhaV0V4WkROak0yWXRPVEU1TkdSbE9EQmtNamM0WkRZMlpqTmtOamt6TkdOaE1ETXdOMlEwT0RVdE5ETTFNRGM1T0RFa01UazNNRE15TVRZPQ==
     
     */
    //WoWonder Key
    static let key =
        "Vm0wd2VFNUdXWGxTV0docFVtMVNWVmxyWkZOaU1WSlZVMjA1V2xadVFsbGFWV1JIVmpKS1IyTkVSbHBOUmxweVdXdGFTMk14WkhWalJtUlhUVEZHTTFaclpEUlRNVnBZVTJ0YWFGSnVRazlWYlhoM1RXeGFjVkZ0Um1oTlZYQXdWa2QwVjFaWFNraFZiVGxWVmpOb1RGVXdXbUZXYkdSeVYyeENWMkV3Y0ZSV1ZWcFNaREpTYzFGc1VtdFNNMmhaV1d0V1MxWXhVblJqUlRWUVZsaFJNVlF4V210VWJGcDFVV3hzV0ZZelFraFdiVEZTWkRBeFYxZHRhRk5pUm5CMlZrWmpNV0l4V1hoWGJsSnJVakJhY2xSV1drdGxiR3QzVjIxMFYySlZjSGxVYkdoTFYyMUZlVlZzVW1GV00yaDZWbTB4UjFKck9WaGhSMnhUWWxoa05sWnRjRXRPUjAxNFYyeG9WR0V5YUc5VmJURnZXVlphYzFkdVpGaFNiRW93V2xWa1IyRXhXbkpqU0hCYVRVZFNkbGxWVlhoa1ZuQkZWMnhrYVZKc2NHOVdWekY2VGxaWmVGSnVUbFJpUlZwWVZXdFdSazVXVFhwaGVsSlFWbXRzTlZscVRuZFpWVEI2VVdzMVZFMHljekJVTVZwaFVqRmFkR1JHV21obGJGcElWa1phWVdJeFpFaFRiR3hTWWtWS1lWbHJXbUZsYkZKelYyeE9WMkpHV25sV1J6RnZZVWRXY2xkc2NGZFdNMmhVVmxSR1UyUkdUbk5YYldoc1lURndWMVpHV210Vk1XeFhZMFZXVTJKck5WaFdiWFIzVFVacmQxWlVSbWxTTUZZelZtMXdUMVl3TVZoVmFrNVhWak5PTkZsNlNrOVNNa1pIVm14a1UyRXpRbTlXYTFwclpXc3hXRlJZYUZaaWJFcHhWVzF6TVdJeGJGbGpSVnBPVm14S1YxbFZZelZXVlRGV1kwVmtWMkpZUWxCV2JHUkxVakZPZFZKdFJsZGlSbFY0VmxkNFlWSXhXbGRUYmtwUVZqTm9jRlZ0ZUZkTk1WcHlXa1JDVmsxVldubFVWbHBoVkRGYVIyTkdWbGRoTVZveldWVmFjMWRIVWtoU2JYUlRZa1Z3V0Zac1pIcE9WMFpIVTI1U2ExSkdXbGhVVjNCR1RVWlplV1ZIUmxOTmF6VktWa2Q0VjFSc1dsVlNXSEJYVW14d1YxcFZWVEZqTVZKelZteE9hR1Z0ZUhaWFYzUlhWMnN4YzFkcmFFOVdNMEpSVm0xMFMxVXhWa2RWV0dScVlUTm5NbFJXYUhOV01ERnhWVmhzVjFaNlJrOVpNblEwVG1zeFYxcEhiRmhTVlhCT1ZtdGtNRmxXV25SV2EyaFVZVEpTYjFWdGVFdGpSbFp4VW10MGEwMVdjRmxVVmxKVFYyeGFjMk5JY0ZkTlYyaHlWMVphUzA1dFNraFNiR1JwVmtWVmQxZHNaRFJYYlZaWVZXdG9hMUpzV25CVmJHaENaREZhYzFsNlJtcE5WMUpKVld4b2IyRnNUa1pqUjBaWFlrZFNWRlpGV2xabFJtUnlXa2R3VGxadVFqWldiVEUwWVRGWmVWSlljRkpoTVhCWVdXeG9RMVJHVW5KWGJrNVhUVlUxTVZaSGVGZGhWMHBHWTBaS1YySlVSVEJYVmxwaFVqSktTVk5zWkdsaVZrcFFWbTB4TkdReFRrZGFTRXBXWWtVMWIxbFljRWRYUm10M1YyMDVWMkY2UmpGWlZXaDNWakpLVlZKcmFGVmlWRVpNVldwS1IxSXhaSFJpUms1cFlUQndXbFpxU2pSV01XeFhZa1prVkdKSFVsUlpiWGhMWTJ4V2RHVkhSbWxOV0VKWldrVmtSMVpHU25OalJXaFhUVzVvY2xsV1ZYaFdNa3BGVld4a1RtSnNTbmxXYlhSclV6RmFjMXBJVG1oU2JrSllWV3hhZG1Wc1dsVlJiVVpXVFdzMWVsVXllRmRoVmtweVYyeGtWMkV4U2tOVWJFVTVVRkU5UFE9PQ==/LHBhc3M9/WVRsR05XNTVNa3gzWjNZeVlWQTJLMVZ5VW1ZMU1tczJKQ3BYYjFkdmJtUmxjaW9rSmxjMU1pTk5hamhBVkZJa0trMWxjM05oYm1kbGNpb2taRFJ3VTNKMFlYVT0="
    
    //Customer test Key
//    static let key =
//        "Vm0wd2VHUXhSWGhYV0d4VFYwZDRWRll3WkRSV2JGbDNXa1pPYWxac1ducFdNakZIVm14S2MxTnNhRmRpVkVaSVZteFZlRmRHVm5OaFJuQlhWakpvZVZacVNqUlhiVkYzVGxac2FGSnNjRTlXYlhSM1UxWmFkR1JIUmxSTlZYQjVWR3hhYTFsV1NYZFhiR2hhWWtkU2RsWnJXbUZXYkdSeVYyeENWMkV3Y0ZSV1ZWcFNaREpTYzFGc1VtdFNNMmhaV1d0V1MxWXhVblJqUlRWUVZsaFJNVlF4V210VWJGcDFVV3hzV0ZZelFraFdiVEZTWkRBeFYxZHRhRk5pUm5CMlZrWmpNV0l4V1hoWGJsSnJVakJhY2xSV1drdGxiR3QzVjIxMFYySlZjSGxaTUdoUFYyMUZlV0ZGVWxaaVdHaG9WVEJWZUZkV2NFaGhSVFZYWWxoa05sWnJXbUZWTVd4WFYxaHNWR0pHV2xoWmExcExXVlphZEdWSVpGcFdia0pZVjJ0YVMySkhTa2xSYTJoYVZsWndjbFpVUmxwbGJGSnhWV3hrVG1Kc1NtOVhWbEpIVkcxV1YxWnVTbUZTYldod1dXdFdkMlZHV2xoalJUbFdUVlpXTkZrd1dtOWlSa2wzVjI1S1ZWWnRVbFJXTUZwYVpWZFNTRkpzV2xOaVNFSTFWbFJLTkZReFduTlRiazVUWVdzMVYxVnRkRlpPVmxaSFZHNXdhMkpGU2xkWGEyaEhWR3N4ZEZWVVNsZFNWVFUyV2tkNFExWXhjRWxUYkZwcFVsUldkbGRXYUhkV01VcHpWMWhzVGxaRlNsWlVWVkpIWlZaYWRHTkhSbGRXVkVaSVZUSXhiMWRzV25OalNIQlhZa1p3YUZwRlpGZFNhelZZWVVkc1UxWnNhM2xXYlhCS1pESldSMU5ZYkZSaE1sSnZWRlJLTkZkV2JITmhSemxvVW14d2VGVnROV3RoTVVwMFZXeHNXazFIYUV4WmExcExWbFphY1ZGc1pHbFNhMWw2VmxWYVQyVnRVbk5SYkd4VVlrZG9jRmxYZUhkV1JtUlpZa2h3YTJKRlNsaFdNalZUWVRGSmVsRnVUbFpoYTFwSVZHeGFWMlJGTlZaa1JsWnBVbTVCZDFac1l6RlJNVnB5VFZWa1dHSlhhRmhVVmxwM1lVWnJlV1ZIUm10U2EzQXdXVlZhVDJGV1RrWlRWRVpYWWxSQ00xUldXbEpsUmxaMVZHeFNhV0pGY0ZoWFZ6QjRUa1prUjFkdVJsVmlWR3hXVlcxNGQxTldjRlphUldSb1RWWndlVll5Y0VkWFIwVjRZMFpvVjJGcldtaFpNakZQVW14YWMxcEhhR2hOYm1OM1ZtMHhkMU14VlhoVWEyUllZbXR3Y0ZWdGVFdGpSbFowWlVoa1YxWnRVbGxhVldSSFZrVXhWMU5yYUZoaE1taFFWMVphUzFJeFRuVlRiRlpYVFRKb1RWWlVRbUZaVm1SSVZtdHNWV0pIVW5CV2JHaERVekZhVjFsNlJsVk5WMUo2VmpKMFlWUXhXbGRUYkZwWFlrWndNMWRXV25kV2JHUjFXa1pTVjJKclNrbFdiVEI0WXpGWmVWTnJiRkppU0VKWVZGWmFTMUpHV25GU2JIQnNVbTVDUjFsVldsTmhWa2w2WVVaU1dGWXphRmhYVmxwelZqSktTVk5zYUdsaVZrcFdWbGN4TkZNd01VZGFSbXhxVTBVMVYxWnRlR0ZXYkZKV1ZXNUtVVlZVTURrPQ==/LHBhc3M9/WVRsR05XNTVNa3gzWjNZeVlWQTJLMVZ5VW1ZMU1tczJKQ3BYYjFkdmJtUmxjaW9rSmxjMU1pTk5hamhBVkZJa0trMWxjM05oYm1kbGNpb2taRFJ3VTNKMFlYVT0="
}

struct ControlSettings {
    static let showSocicalLogin = false
    static let googleClientKey = "497109148599-u0g40f3e5uh53286hdrpsj10v505tral.apps.googleusercontent.com"
    static let googleApiKey = "AIzaSyDo-tKjkOFkb5yl2n_dxPNJngDdFWNrFMk"
    //    AIzaSyDo-tKjkOFkb5yl2n_dxPNJngDdFWNrFMk
    static let oneSignalAppId = "08606730-c50f-46ce-8203-a7da19aa8c3a"
    static let agoraCallingToken = "cea80c3b9a744f69ba90a68d07ca9167"
    static let addUnitId = "ca-app-pub-3940256099942544/2934735716"
    static let interestialAddUnitId = "ca-app-pub-3940256099942544/4411468910"
    static let facebookPlacementID = "250485588986218_554026125298828" //Change this ID with your facebook placement ID
    static let HelpLink = "\(API.baseURL)/contact-us"
    static let reportlink = "\(API.baseURL)/contact-us"
    static let termsOfUse = "\(API.baseURL)/terms/terms"
    static let privacyPolicy = "\(API.baseURL)/terms/privacy-policy"
    static let socketPort = "449"
    
    static let inviteFriendText = "Please vist our website \(API.baseURL)"
    static let AppName = NSLocalizedString("WoWonder Messenger", comment: "WoWonder Messenger")
    static let WoWonderText = "\(NSLocalizedString("Hi! there i am using", comment: "Hi! there i am using")) \(AppName)"
    
    static let socketChat = true
    
    static let twilloCall = true
    static let agoraCall = false
    
    static let facebookAds = false//true
    static let googleAds = true
    
    static let googleMapKey = "AIzaSyAR6R-G3VEcrIKEA09yYb0UyMSESw4u4Y8"
    static let ShowSettingsGeneralAccount = true
    static let ShowSettingsAccountPrivacy = true
    static let ShowSettingsPassword = true
    static let ShowSettingsBlockedUsers = true
    static let ShowSettingsNotifications = false
    static let ShowSettingsDeleteAccount = true
    static var shouldShowAddMobBanner:Bool = true
    static var interestialCount:Int? = 3
}

extension UIColor {
    
    @nonobjc class var mainColor: UIColor {
        return UIColor.hexStringToUIColor(hex: "#C83747")
    }
    
    @nonobjc class var ButtonColor: UIColor {
        return UIColor.hexStringToUIColor(hex: "#C83747")
    }

    @nonobjc class var primaryButtonColor: UIColor {
        return UIColor.hexStringToUIColor(hex: "#C83747")
    }
    
    @nonobjc class var bgMain: UIColor {
        return UIColor.hexStringToUIColor(hex: "#C83747").withAlphaComponent(0.1)
    }
    
}
