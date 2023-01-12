//
//  SettingViewController.swift
//  WoWonder
//
//  Created by Mac on 08/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import WowonderMessengerSDK
import ActionSheetPicker_3_0
import Async
import OneSignal
import Kingfisher

class SettingViewController: BaseVC {
    
    //MARK: - All IBOutlet This ViewController
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var followMeShowLabel: UILabel!
    @IBOutlet weak var accountLogoutView: UIControl!
    @IBOutlet weak var deleteView: UIControl!
    @IBOutlet weak var blockView: UIControl!
    @IBOutlet weak var accountInfomactionView: UIControl!
    @IBOutlet weak var personalInfomationView: UIControl!
    @IBOutlet weak var massageShowLabel: UILabel!
    @IBOutlet weak var brithdayShowLabel: UILabel!
    @IBOutlet weak var onlineStuesChageSwitch: UISwitch!
    
    //MARK: - darkModeCount
    var darkModeCount = 0
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ImageUrl = URL(string: "\(AppInstance.instance.userProfile?._avatar ?? "")")
        self.profileImageVIew.kf.indicatorType = .activity
        self.profileImageVIew.kf.setImage(with: ImageUrl, placeholder: UIImage(named: "user_setting"))
        self.userNameLabel.text = AppInstance.instance.userProfile?.username ?? ""
        self.userIdLabel.text = "@\(AppInstance.instance.userProfile?.username ?? "")"
        // Do any additional setup after loading the view.
    }
    
    func setupScreenUI() {
        let status =   UserDefaults.standard.getNotification(Key: Local.NOTIFICATION_RECEIVE.NotificationReceive)
        if status{
            self.onlineStuesChageSwitch.isOn = true
            self.value = 1
        } else {
            self.onlineStuesChageSwitch.isOn = false
            self.value = 0
        }
    }
    
    
    //MARK: - All buttonAction This ViewController
    @IBAction func personalInfomactionViewClick(_ sender: UIControl) {
        self.view.endEditing(true)
//        let vc = R.storyboard.settings.EditProfileViewController()
//        self.navigationController?.pushViewController(vc!, animated: true)
        let EditProfileVc = EditProfileViewController.initialize(from: .settings)
        self.navigationController?.pushViewController(EditProfileVc, animated: true)
    }
    
    @IBAction func accountInfomactionViewClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.settings.myAccountVC()
        self.mainNavigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func blockviewClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.dashboard.blockedUsersVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func logoutbuttonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.logoutAccount()
    }
    
    @IBAction func themeButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.darkMode()
    }
    
    @IBAction func wallpaperButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func delteButtonClick(_ sender: UIControl) {
        self.deleteAccountAlert()
    }
    
    @IBAction func manageSessionsButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.settings.manageSessionVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func twofactorButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.settings.twoFactorVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func changePasswrodButtonClick(_ sender: UIControl) {self.view.endEditing(true)
        let vc = R.storyboard.settings.changePasswordVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func followMeButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.followPrivacy(Type: "follow")
    }
    
    @IBAction func messageMeButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.messagePrivacy(Type: "message")
    }
    
    @IBAction func brithdayShowButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.birthdayPrivacy(Type: "birthday")
    }
    
    @IBAction func showOnlineUserButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func notifactionSwitchClick(_ sender: UISwitch) {
        self.view.endEditing(true)
        if self.value == 0 {
            self.value = 1
            self.onlineStuesChageSwitch.setOn(true, animated: true)
            UserDefaults.standard.setNotificationStatus(value: true, ForKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
            OneSignal.disablePush(false)
            
        } else {
            self.onlineStuesChageSwitch.setOn(false, animated: true)
            self.value = 0
            UserDefaults.standard.setNotificationStatus(value: false, ForKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
            OneSignal.disablePush(true)
        }
    }
    
    @IBAction func chatHeadsButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func inviteFrinendButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.dashboard.inviteFriendsVC()
        vc?.status = true
        vc?.key = "settings"
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func rateAppsButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func aboutButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func contactButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func privacyPolicyButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func termsOfuseButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    @IBAction func tonesbuttonClick(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    //MARK: - logoutAccount
    private func logoutAccount() {
        let alert = UIAlertController(title: NSLocalizedString("Logout", comment: "Logout"), message: NSLocalizedString("Are you sure you want to logout ?", comment: "Are you sure you want to logout ?"), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
        let logout = UIAlertAction(title: NSLocalizedString("Logout", comment: "Logout"), style: .destructive) { (action) in
            //
            let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        }
        alert.addAction(cancel)
        alert.addAction(logout)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func update() {
        UserDefaults.standard.removeValuefromUserdefault(Key: Local.USER_SESSION.User_Session)
        let vc = R.storyboard.main.main()
        appDelegate.window?.rootViewController = vc
        self.dismiss(animated: true, completion: nil)
    }
    
    private func openLink(Url:String) {
        let url = URL(string: Url)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
    }
    
    //MARK: - DeleteAccount
    private func deleteAccount() {
        //
        let password = UserDefaults.standard.getPassword(Key: Local.USER_SESSION.Current_Password)
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            UserManager.instance.deleteUser(sessionToken: sessionToken, password: password, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main{
                        self.dismissProgressDialog{
                            log.verbose("Success = \(success?.message ?? "")")
                            UserDefaults.standard.clearUserDefaults()
                            let vc = R.storyboard.main.main()
                            self.appDelegate.window?.rootViewController = vc
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }else if sessionError != nil{
                    Async.main{
                        self.dismissProgressDialog {
                            log.verbose("session Error = \(sessionError?.errors?.errorText ?? "")")
                            self.view.makeToast(sessionError?.errors?.errorText ?? "")
                        }
                    }
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            
                            log.verbose("serverError = \(serverError?.errors?.errorText ?? "")")
                            self.view.makeToast(serverError?.errors?.errorText ?? "")
                            
                        }
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            log.verbose("error = \(error?.localizedDescription)")
                            self.view.makeToast(error?.localizedDescription ?? "")
                        }
                    })
                }
            })
        })
    }
    
    //MARK: - DarkMode
    private func darkMode() {
        let status = UserDefaults.standard.getDarkMode(Key: "darkMode")
        if status {
            self.darkModeCount = 0
        } else {
            self.darkModeCount = 1
        }
        ActionSheetMultipleStringPicker.show(withTitle: "Theme", rows: [
            [NSLocalizedString("Dark mode", comment: "Dark mode"), NSLocalizedString("Light mode", comment: "Light mode")]
            
        ], initialSelection: [self.darkModeCount], doneBlock: {
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            if index == 0 {
                self.appDelegate.window?.overrideUserInterfaceStyle = .dark
                UserDefaults.standard.setDarkMode(value: true, ForKey: "darkMode")
                
            } else if  index == 1 {
                self.appDelegate.window?.overrideUserInterfaceStyle = .light
                UserDefaults.standard.setDarkMode(value: false, ForKey: "darkMode")
                
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    //MARK: - DeleteAccount Alert
    private func deleteAccountAlert(){
        let alert = UIAlertController(title: NSLocalizedString("Warning !", comment: ""), message:  NSLocalizedString("Are you sure you want to delete the account from WoWonder Messenger", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
        let logout = UIAlertAction(title: NSLocalizedString("Delete", comment: "Delete"), style: .destructive) { (action) in
            self.deleteAccount()
        }
        alert.addAction(cancel)
        alert.addAction(logout)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - followPrivacy
    
    private func followPrivacy(Type:String) {
        ActionSheetMultipleStringPicker.show(withTitle: NSLocalizedString("Follow Privacy", comment: "Follow Privacy"), rows: [
            [NSLocalizedString("Everyone", comment: "Everyone"), NSLocalizedString("People i Follow", comment: "People i Follow")]
            
        ], initialSelection: [Int(AppInstance.instance.userProfile?.followPrivacy ?? "0")], doneBlock: {
            
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            if index == 0{
                self.followMeShowLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            }else if  index == 1{
                self.followMeShowLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
            }
            self.updateprivacy(Type: Type, value:(indexes![0] as? Int)!)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    //MARK: - MessagePrivacy
    private func messagePrivacy(Type:String) {
        
        ActionSheetMultipleStringPicker.show(withTitle: NSLocalizedString("Message Privacy", comment: "Message Privacy"), rows: [
            [NSLocalizedString("Everyone", comment: "Everyone"), NSLocalizedString("People i Follow", comment: "People i Follow"),NSLocalizedString("Nobody", comment: "Nobody")]
            
        ], initialSelection: [Int(AppInstance.instance.userProfile?.messagePrivacy ?? "0")], doneBlock: {
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            if index == 0{
                self.massageShowLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            } else if  index == 1{
                self.massageShowLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
            } else if  index == 2{
                self.massageShowLabel.text = NSLocalizedString("Nobody", comment: "Nobody")
            }
            
            self.updateprivacy(Type: Type, value:(indexes![0] as? Int)!)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    //MARK: - Birthday Privacy
    private func birthdayPrivacy(Type:String) {
        ActionSheetMultipleStringPicker.show(withTitle: NSLocalizedString("birthday Privacy", comment: "birthday Privacy"), rows: [
            [NSLocalizedString("Everyone", comment: "Everyone"), NSLocalizedString("People i Follow", comment: "People i Follow"),NSLocalizedString("Nobody", comment: "Nobody")]
            
        ], initialSelection: [Int(AppInstance.instance.userProfile?.birthPrivacy ?? "0")], doneBlock: {
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            if index == 0{
                self.brithdayShowLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            }else if  index == 1{
                self.brithdayShowLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
                
            } else if  index == 2{
                self.brithdayShowLabel.text = NSLocalizedString("Nobody", comment: "Nobody")
                
            }
            self.updateprivacy(Type: Type, value:(indexes![0] as? Int)!)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    //MARK: - updateprivacy
    func updateprivacy(Type:String,value:Int) {
        var key:String? = ""
        if Type == "follow"{
            key = "follow_privacy"
        }else if Type == "message"{
            key = "message_privacy"
            
        }else if Type == "birthday"{
            key = "birth_privacy"
        }
        else if Type == "status"{
            key = "message_privacy"
        }
        let sessionToken = AppInstance.instance.sessionId ?? ""
        
        Async.background({
            SettingsManager.instance.updatePrivacy(session_Token: sessionToken, key: key ?? "", value: value) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            
                            AppInstance.instance.fetchUserProfile(pass: nil)
                            self.view.makeToast(success?.message ?? "")
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText ?? "")
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText ?? "")
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription ?? "")
                            log.error("error = \(error?.localizedDescription ?? "")")
                        }
                    })
                }
            }
        })
    }
}
