//
//  SettingProfileViewController.swift
//  WoWonder
//
//  Created by Mac on 14/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import WowonderMessengerSDK
import ActionSheetPicker_3_0
import Async
import OneSignal
import Kingfisher

class SettingProfileViewController: BaseVC {

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var accountTableViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var accountTableVIew: UITableView!
    @IBOutlet weak var mediaTableVIewConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaTableVIew: UITableView!
    @IBOutlet weak var generalTabelView: UITableView!
    @IBOutlet weak var messageNotificationsTableVIewConstraint: NSLayoutConstraint!
    @IBOutlet weak var notifactionTableView: UITableView!
    @IBOutlet weak var privacyTableVIewConstraint: NSLayoutConstraint!
    @IBOutlet weak var privacyTableVIew: UITableView!
    @IBOutlet weak var securityTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var securityTableView: UITableView!
    @IBOutlet weak var displayTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var generalTableVIewConstraint: NSLayoutConstraint!
    @IBOutlet weak var displayTableView: UITableView!
    
    var displayArray: [Profile] = []
    var securityArray: [Profile] = []
    var generalArray: [Profile] = []
    var mediaArray: [Profile] = []
    var privacyArray: [Profile] = []
    var notifactionArray: [Profile] = []
    var isNotifaction = false
    var isConversation = false
    private var birthday = ""
    private var Follow = ""
    private var message = ""
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.XIBregister()
        self.titleNameLabel.textColor = UIColor.mainColor
    }
    
    func XIBregister() {
        
        let account = UINib(nibName: "UserProfileTableViewCell", bundle: nil)
        self.accountTableVIew.register(account, forCellReuseIdentifier: "UserProfileTableViewCell")
        
        let GeneralXIB = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        self.generalTabelView.register(GeneralXIB, forCellReuseIdentifier: "GeneralTableViewCell")
        
        let mediaTableXIB = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        self.mediaTableVIew.register(mediaTableXIB, forCellReuseIdentifier: "GeneralTableViewCell")
        
        let messageNotificationsXIB = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        self.notifactionTableView.register(messageNotificationsXIB, forCellReuseIdentifier: "GeneralTableViewCell")
        
        let privacyXIB = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        self.privacyTableVIew.register(privacyXIB, forCellReuseIdentifier: "GeneralTableViewCell")
        
        let securityXIB = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        self.securityTableView.register(securityXIB, forCellReuseIdentifier: "GeneralTableViewCell")
        
        let displayXIB = UINib(nibName: "GeneralTableViewCell", bundle: nil)
        self.displayTableView.register(displayXIB, forCellReuseIdentifier: "GeneralTableViewCell")
        
        self.displayArray = displayDummydata()
        self.generalArray = generDummyData()
        self.mediaArray = mediaDummydata()
        self.privacyArray = PrivacyDummyData()
        self.securityArray = SecurityDummyData()
        self.notifactionArray = notofactionDummyData()
        
        self.message = AppInstance.instance.userProfile?._messagePrivacy ?? ""
        self.Follow = AppInstance.instance.userProfile?._followPrivacy ?? ""
        self.birthday = AppInstance.instance.userProfile?._birthPrivacy ?? ""
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.accountTableViewHightConstraint.constant = self.accountTableVIew.contentSize.height
        self.generalTableVIewConstraint.constant = self.generalTabelView.contentSize.height
        self.mediaTableVIewConstraint.constant = self.mediaTableVIew.contentSize.height
        self.messageNotificationsTableVIewConstraint.constant = self.notifactionTableView.contentSize.height
        self.privacyTableVIewConstraint.constant = self.privacyTableVIew.contentSize.height
        self.securityTableViewConstraint.constant = self.securityTableView.contentSize.height
        self.displayTableViewConstraint.constant = self.displayTableView.contentSize.height
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
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
    
    //MARK: - DeleteAccount APi Calling
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
                            log.verbose("error = \(error?.localizedDescription ?? "")")
                            self.view.makeToast(error?.localizedDescription ?? "")
                        }
                    })
                }
            })
        })
    }
    
    //MARK: - showActionSheetContoller
    private func showActionSheetContoller (Type:String) {
        if Type == "follow"{
            self.followPrivacy(Type: Type)
        }else if Type == "message"{
            self.messagePrivacy(Type: Type)
        }else if Type == "birthday"{
            self.birthdayPrivacy(Type: Type)
        }
    }
    
    private func followPrivacy(Type:String) {
        
        ActionSheetMultipleStringPicker.show(withTitle: NSLocalizedString("Follow Privacy", comment: "Follow Privacy"), rows: [
            [NSLocalizedString("Everyone", comment: "Everyone"), NSLocalizedString("People i Follow", comment: "People i Follow")]
        ], initialSelection: [Int(AppInstance.instance.userProfile?.followPrivacy ?? "0")!], doneBlock: {
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            if index == 0{
                self.Follow = "Everyone"
            }else if  index == 1{
                self.Follow = "People i Follow"
            }
            self.updateprivacy(Type: Type, value:(indexes![0] as? Int)!)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    private func messagePrivacy(Type:String) {
        
        ActionSheetMultipleStringPicker.show(withTitle: NSLocalizedString("Message Privacy", comment: "Message Privacy"), rows: [
            [NSLocalizedString("Everyone", comment: "Everyone"), NSLocalizedString("People i Follow", comment: "People i Follow"),NSLocalizedString("Nobody", comment: "Nobody")]
            
        ], initialSelection: [Int(AppInstance.instance.userProfile?.messagePrivacy ?? "0") as Any], doneBlock: {
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            let cell = self.privacyTableVIew.cellForRow(at: IndexPath(row: 1, section: 3)) as? GeneralTableViewCell
            if index == 0{
                cell?.decrepitationLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            }else if  index == 1{
                cell?.decrepitationLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
                
            }else if  index == 2{
                cell?.decrepitationLabel.text = NSLocalizedString("Nobody", comment: "Nobody")
                
            }
            self.updateprivacy(Type: Type, value:(indexes![0] as? Int)!)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    private func birthdayPrivacy(Type:String) {
        ActionSheetMultipleStringPicker.show(withTitle: NSLocalizedString("birthday Privacy", comment: "birthday Privacy"), rows: [
            [NSLocalizedString("Everyone", comment: "Everyone"), NSLocalizedString("People i Follow", comment: "People i Follow"),NSLocalizedString("Nobody", comment: "Nobody")]
            
        ], initialSelection: [Int(AppInstance.instance.userProfile?.birthPrivacy ?? "0") as Any], doneBlock: {
            picker, indexes, values in
            let index =  (indexes![0] as? Int)!
            if index == 0{
                self.birthday = "Everyone"
            } else if  index == 1 {
                self.birthday = "People i Follow"
                
            } else if  index == 2 {
                self.birthday = "Nobody"
                
            }
            self.updateprivacy(Type: Type, value:(indexes![0] as? Int)!)
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    //MARK: - updateprivacy
    func updateprivacy(Type:String, value:Int) {
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
                            self.privacyTableVIew.reloadData()
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
    
    private func logout() {
        let alert = UIAlertController(title: NSLocalizedString("Logout", comment: "Logout"), message: NSLocalizedString("Are you sure you want to logout ?", comment: "Are you sure you want to logout ?"), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
        let logout = UIAlertAction(title: NSLocalizedString("Logout", comment: "Logout"), style: .destructive) { (action) in
            //
            _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
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
}

extension SettingProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case accountTableVIew:
            return 1
            
        case generalTabelView:
            return generalArray.count
            
        case mediaTableVIew:
            return mediaArray.count
            
        case notifactionTableView:
            return notifactionArray.count
            
        case privacyTableVIew:
            return privacyArray.count
            
        case securityTableView:
            return securityArray.count
            
        case displayTableView:
            return displayArray.count
            
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
            
        case accountTableVIew:
            let cell = accountTableVIew.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell", for: indexPath) as? UserProfileTableViewCell
            self.setUpAccountName(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        case generalTabelView:
            let cell = generalTabelView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell
            self.setgeneralTableViewData(cell: cell, indexPathForCell: indexPath)
            
            return cell ?? UITableViewCell()
            
        case mediaTableVIew:
            let cell = mediaTableVIew.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell
            self.setMediaTableViewData(cell: cell, indexPathForCell: indexPath)
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            return cell ?? UITableViewCell()
            
        case notifactionTableView:
            let cell = notifactionTableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell
            self.setmediaNotifaction(cell: cell, indexPathForCell: indexPath)
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            return cell ?? UITableViewCell()
            
        case privacyTableVIew:
            let cell = privacyTableVIew.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell
            self.setPrivacyTableViewData(cell: cell, indexPathForCell: indexPath)
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            return cell ?? UITableViewCell()
            
        case securityTableView:
            let cell = securityTableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell
            self.setSecurityTableViewData(cell: cell, indexPathForCell: indexPath)
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            return cell ?? UITableViewCell()
            
        case displayTableView:
            let cell = displayTableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell
            self.setDisplayTableViewData(cell: cell, indexPathForCell: indexPath)
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
            
        }
    }
    
    //MARK: - setUpAccountName
    func setUpAccountName(cell: UserProfileTableViewCell?, indexPathForCell: IndexPath) {
        let ImageUrl = URL(string: "\(AppInstance.instance.userProfile?._avatar ?? "")")
        cell?.profileImage.kf.indicatorType = .activity
        cell?.profileImage.kf.setImage(with: ImageUrl, placeholder: UIImage(named: "user_setting"))
        cell?.profileName.text = AppInstance.instance.userProfile?.username ?? ""
        cell?.userIdprofileName.text = "@\(AppInstance.instance.userProfile?.username ?? "")"
    }
    
    //MARK: - setmediaNotifaction
    func setmediaNotifaction(cell: GeneralTableViewCell?, indexPathForCell: IndexPath) {
        if indexPathForCell.row == 0 {
            cell?.switchStutes.isHidden = false
            cell?.rightArroeView.isHidden = true
            cell?.Actionbutton.isHidden = true
        } else {
            cell?.switchStutes.isHidden = true
            cell?.rightArroeView.isHidden = true
            cell?.Actionbutton.isHidden = false
        }
        let objData = notifactionArray[indexPathForCell.row]
        cell?.decrepitationLabel.text = objData.chatderipication
        cell?.titleNameLabel.text = objData.chatTitle
        
        
        if objData.chatTitle == "Notification Popup" {
            let isAction = UserDefaults.standard.bool(forKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
            if isAction == false {
                cell?.Actionbutton.isSelected = false
                cell?.chackMarkImageView.image = UIImage(named: "")
                self.isNotifaction = true
                
            } else {
                cell?.Actionbutton.isSelected = true
                cell?.chackMarkImageView.image = UIImage(named: "ic_checkbox")?.withRenderingMode(.alwaysTemplate)
                cell?.chackMarkImageView.tintColor = UIColor.mainColor
                
                self.isNotifaction = false
            }
        } else {
            let isAction = UserDefaults.standard.bool(forKey: Local.CONVERSATION_TONE.ConversationTone)
            if isAction == false {
                cell?.Actionbutton.isSelected = false
                cell?.chackMarkImageView.image = UIImage(named: "")
                self.isNotifaction = true
                
            } else {
                cell?.Actionbutton.isSelected = true
                cell?.chackMarkImageView.image = UIImage(named: "ic_checkbox")?.withRenderingMode(.alwaysTemplate)
                cell?.chackMarkImageView.tintColor = UIColor.mainColor
                self.isNotifaction = false
            }
        }
        cell?.Actionbutton.tag = indexPathForCell.row
        cell?.Actionbutton.addTarget(self, action: #selector(actionButtonClick), for: .touchUpInside)
        
    }
    
    //MARK: - SetDisplayTableViewData
    func setDisplayTableViewData(cell: GeneralTableViewCell?, indexPathForCell: IndexPath) {
        cell?.Actionbutton.isHidden = true
        cell?.rightArroeView.isHidden = false
        cell?.switchStutes.isHidden = true
        let objData = displayArray[indexPathForCell.row]
        cell?.decrepitationLabel.text = objData.chatderipication
        cell?.titleNameLabel.text = objData.chatTitle
    }
    
    //MARK: - SetMediaTableViewData
    func setMediaTableViewData(cell: GeneralTableViewCell?, indexPathForCell: IndexPath) {
        let objData = mediaArray[indexPathForCell.row]
        cell?.Actionbutton.isHidden = true
        cell?.rightArroeView.isHidden = false
        cell?.switchStutes.isHidden = true
        cell?.decrepitationLabel.text = objData.chatderipication
        cell?.titleNameLabel.text = objData.chatTitle
    }
    
    //MARK: - SetgeneralTableViewData
    func setgeneralTableViewData(cell: GeneralTableViewCell?, indexPathForCell: IndexPath) {
        cell?.Actionbutton.isHidden = true
        cell?.rightArroeView.isHidden = false
        cell?.switchStutes.isHidden = true
        let objData = generalArray[indexPathForCell.row]
        cell?.decrepitationLabel.text = objData.chatderipication
        cell?.titleNameLabel.text = objData.chatTitle
    }
    
    //MARK: - SetSecurityTableViewData
    func setSecurityTableViewData(cell: GeneralTableViewCell?, indexPathForCell: IndexPath) {
        cell?.Actionbutton.isHidden = true
        cell?.rightArroeView.isHidden = false
        cell?.switchStutes.isHidden = true
        let objData = securityArray[indexPathForCell.row]
        cell?.decrepitationLabel.text = objData.chatderipication
        cell?.titleNameLabel.text = objData.chatTitle
    }
    
    //MARK: - SetPrivacyTableViewData
    func setPrivacyTableViewData(cell: GeneralTableViewCell?, indexPathForCell: IndexPath) {
        
        if indexPathForCell.row == 3 {
            cell?.Actionbutton.isHidden = true
            cell?.rightArroeView.isHidden = true
            cell?.switchStutes.isHidden = false
        } else {
            cell?.Actionbutton.isHidden = true
            cell?.rightArroeView.isHidden = false
            cell?.switchStutes.isHidden = true
        }
        let objData = privacyArray[indexPathForCell.row]
        cell?.decrepitationLabel.text = objData.chatderipication
        cell?.titleNameLabel.text = objData.chatTitle
        
        let status = UserDefaults.standard.getNotification(Key: Local.NOTIFICATION_RECEIVE.NotificationReceive)
        if status{
            cell?.switchStutes.isOn = true
            self.value = 1
        }else{
            cell?.switchStutes.isOn = false
            self.value = 0
        }
        
        if cell?.titleNameLabel.text == "Who can follow me?" {
            if AppInstance.instance.userProfile?.followPrivacy == "0"{
                cell?.decrepitationLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            }else if  AppInstance.instance.userProfile?.followPrivacy == "1"{
                cell?.decrepitationLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
            }
            
        } else if cell?.titleNameLabel.text == "Who can message me?" {
            
            if AppInstance.instance.userProfile?.messagePrivacy == "0"{
                cell?.decrepitationLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            } else if  AppInstance.instance.userProfile?.messagePrivacy == "1"{
                cell?.decrepitationLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
            } else if  AppInstance.instance.userProfile?.messagePrivacy == "2"{
                cell?.decrepitationLabel.text = NSLocalizedString("Nobody", comment: "Nobody")
            }
                        
        } else if cell?.titleNameLabel.text == "Who can see my birthday?" {
            if AppInstance.instance.userProfile?.birthPrivacy == "0"{
                cell?.decrepitationLabel.text = NSLocalizedString("Everyone", comment: "Everyone")
            } else if  AppInstance.instance.userProfile?.birthPrivacy == "1" {
                cell?.decrepitationLabel.text = NSLocalizedString("People i Follow", comment: "People i Follow")
            } else if AppInstance.instance.userProfile?.birthPrivacy == "2" {
                cell?.decrepitationLabel.text = NSLocalizedString("Nobody", comment: "Nobody")
            }
            
        }
        cell?.switchStutes.tag = indexPathForCell.row
        cell?.switchStutes.addTarget(self, action: #selector(onlineStutesSwitch), for: .touchUpInside)
    }
    
    @objc func onlineStutesSwitch(_ sender: UISwitch) {
        let cell = privacyTableVIew.dequeueReusableCell(withIdentifier: "GeneralTableViewCell") as? GeneralTableViewCell
        if self.value == 0 {
            self.value = 1
            cell?.switchStutes.setOn(true, animated: true)
            UserDefaults.standard.setNotificationStatus(value: true, ForKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
            OneSignal.disablePush(false)
        } else {
            cell?.switchStutes.setOn(false, animated: true)
            self.value = 0
            UserDefaults.standard.setNotificationStatus(value: false, ForKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
            OneSignal.disablePush(true)
        }
        self.privacyTableVIew.reloadData()
        
    }
    
    @objc func actionButtonClick(_ sender: UIButton) {
        let Notifaction = notifactionArray[sender.tag]
        if Notifaction.chatTitle == "Notification Popup" {
            if self.isNotifaction == true {
                self.isNotifaction = false
                UserDefaults.standard.setNotificationStatus(value: true, ForKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
                OneSignal.disablePush(false)
                self.notifactionTableView.reloadData()
            } else {
                self.isNotifaction = true
                UserDefaults.standard.setNotificationStatus(value: false, ForKey: Local.NOTIFICATION_RECEIVE.NotificationReceive)
                OneSignal.disablePush(true)
                self.notifactionTableView.reloadData()
            }
        } else {
            if self.isConversation == true {
                self.isConversation = false
                UserDefaults.standard.setNotificationStatus(value: true, ForKey: Local.CONVERSATION_TONE.ConversationTone)
                OneSignal.disablePush(false)
                self.notifactionTableView.reloadData()
            } else {
                self.isConversation = true
                UserDefaults.standard.setNotificationStatus(value: false, ForKey: Local.CONVERSATION_TONE.ConversationTone)
                OneSignal.disablePush(true)
                self.notifactionTableView.reloadData()
            }
        }
    }
    
    //MARK: - TableView didSelect Method's
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
            
        case accountTableVIew:
            switch indexPath.row {
            case 0:
                break
                
            default:
                break
            }
            
        case generalTabelView:
            switch indexPath.row {
            case 0:
                let UserviewProfile = UserProfilePreviewViewController.initialize(from: .settings)
                if UserviewProfile.getUserData(user_ID: AppInstance.instance.userId ?? "") {}
                
                let seconds = 2.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    // Put your code which should be executed with a delay here
                    self.navigationController?.pushViewController(UserviewProfile, animated: true)
                }
                
            case 1:
                let vc = MyAccountVC.initialize(from: .settings)
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                let vc = R.storyboard.dashboard.blockedUsersVC()
                self.navigationController?.pushViewController(vc!, animated: true)
                
            case 3:
                self.deleteAccountAlert()
                
            case 4:
                self.logout()
                
            default:
                break
            }
            
        case mediaTableVIew:
            switch indexPath.row {
            case 0:
                break
                
            case 1:
                break
            case 2:
                break
            case 3:
                break
                
            default:
                break
            }
            
        case notifactionTableView:
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            case 3:
                break
                
            default:
                break
            }
            
        case privacyTableVIew:
            switch indexPath.row {
            case 0:
//                self.showActionSheetContoller(Type: "follow")
                let messsagePrivacy = FollowPrivacyViewController.initialize(from: .settings)
                messsagePrivacy.modalPresentationStyle = .overCurrentContext
                messsagePrivacy.delagate = self
                self.navigationController?.present(messsagePrivacy, animated: true)
                
            case 1:
                let messsagePrivacy = MessagePrivacyViewController.initialize(from: .settings)
                messsagePrivacy.modalPresentationStyle = .overCurrentContext
                messsagePrivacy.delagate = self
                self.navigationController?.present(messsagePrivacy, animated: true)
                
            case 2:
                
                let messsagePrivacy = BrithdayPrivacyViewController.initialize(from: .settings)
                messsagePrivacy.modalPresentationStyle = .overCurrentContext
                messsagePrivacy.delagate = self
                self.navigationController?.present(messsagePrivacy, animated: true)
//                self.showActionSheetContoller(Type: "birthday")
                
            default:
                break
            }
            
        case securityTableView:
            switch indexPath.row {
            case 0:
                let changePasswordVC = ChangePasswordVC.initialize(from: .settings)
                self.navigationController?.pushViewController(changePasswordVC, animated: true)
                
            case 1:
                let twoFactorVC = TwoFactorVC.initialize(from: .settings)
                self.navigationController?.pushViewController(twoFactorVC, animated: true)
                
            case 2:
                let vc = R.storyboard.settings.manageSessionVC()
                self.navigationController?.pushViewController(vc!, animated: true)
                
            default:
                break
            }
            
        case displayTableView:
            switch indexPath.row {
            case 0:
                let WallpaperVC = WallpaperViewController.initialize(from: .settings)
                self.navigationController?.pushViewController(WallpaperVC, animated: true)
                
                
            case 1:
                let ThemeVC = ThemeViewController.initialize(from: .settings)
                ThemeVC.delagete = self
                self.navigationController?.present(ThemeVC, animated: true)
                
            case 2:
                break
            case 3:
                break
                
            default:
                break
            }
            
        default:
            break
        }
    }
}

//MARK: - MessagePrivacyDelegate
extension SettingProfileViewController: MessagePrivacyDelegate {
    func ButtonClickName(name: String) {
        if name == "Everyone" {
            self.updateprivacy(Type: "message", value: 0)
        } else if name == "People i Follow" {
            self.updateprivacy(Type: "message", value: 1)
        } else if  name == "Nobody"  {
            self.updateprivacy(Type: "message", value: 2)
        }
    }
}

//MARK: - FollowPrivacyDelegate
extension SettingProfileViewController: FollowPrivacyDelegate {
    func ButtonClick(name: String) {
        if name == "Everyone" {
            self.updateprivacy(Type: "follow", value: 0)
        } else if name == "People i Follow" {
            self.updateprivacy(Type: "follow", value: 1)
        }
    }
}


//MARK: - FollowPrivacyDelegate
extension SettingProfileViewController: BrithdayPrivacyDelegate {
    func BrithdayPrivacy(name: String) {
        if name == "Everyone" {
            self.updateprivacy(Type: "birthday", value: 0)
        } else if name == "People i Follow" {
            self.updateprivacy(Type: "birthday", value: 1)
        } else if  name == "Nobody"  {
            self.updateprivacy(Type: "birthday", value: 2)
        }
    }
}


extension SettingProfileViewController: ThemeDelegate {
    func ThemeType(typeName: String) {
        if typeName == "Dark" {
            self.appDelegate.window?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.setDarkMode(value: true, ForKey: "darkMode")
            
        } else if  typeName == "Light" {
            self.appDelegate.window?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.setDarkMode(value: false, ForKey: "darkMode")
        }
    }        
}
