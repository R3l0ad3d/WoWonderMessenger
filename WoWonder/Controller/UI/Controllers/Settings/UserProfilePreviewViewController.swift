//
//  UserProfilePreviewViewController.swift
//  WoWonder
//
//  Created by UnikApp on 05/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import DropDown
import Async
import WowonderMessengerSDK


class UserProfilePreviewViewController: BaseVC {
    
    //MARK: - All Outlet This UserProfile Controller
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addFriendView: UIButton!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var friastName: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var wrokLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var aboutTitleLabel: UILabel!
    @IBOutlet weak var facebookView: UIControl!
    @IBOutlet weak var instaimageVIew: UIControl!
    @IBOutlet weak var vkView: UIControl!
    @IBOutlet weak var youtubeView: UIControl!
    @IBOutlet weak var twitterView: UIControl!
    @IBOutlet weak var userFollwingLabel: UILabel!
    @IBOutlet weak var userFollowresLabel: UILabel!
    @IBOutlet weak var studayView: UIView!
    @IBOutlet weak var schollView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var GenderView: UIView!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var soicalMediaLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var relecationShipView: UIView!
    @IBOutlet weak var relecationShiplabel: UILabel!
    
    @IBOutlet weak var wrokImageview: UIImageView!
    
    @IBOutlet weak var bookImageview: UIImageView!
    
    @IBOutlet weak var locationImaheview: UIImageView!
    
    @IBOutlet weak var callImagview: UIImageView!
    
    @IBOutlet weak var genderImaheview: UIImageView!
    
    @IBOutlet weak var wroldVIewIamge: UIImageView!
    
    @IBOutlet weak var relactionship: UIImageView!
    
    var user: Users?
    var chat: Chats?
    var userData : FollowingModel.Following?
    var user_data: UserModel?
    var admin = ""
    var isFollowing = 1
    private var media = [Messages]()
    private let moreDropdown = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookImageview.image = UIImage(named: "ic_profile_book")?.withRenderingMode(.alwaysTemplate)
        self.bookImageview.tintColor = UIColor.mainColor
        
        self.wrokImageview.image = UIImage(named: "ic_wrok_profile")?.withRenderingMode(.alwaysTemplate)
        self.wrokImageview.tintColor = UIColor.mainColor
        
        self.locationImaheview.image = UIImage(named: "ic_profile_Location")?.withRenderingMode(.alwaysTemplate)
        self.locationImaheview.tintColor = UIColor.mainColor
        
        self.callImagview.image = UIImage(named: "ic_profile_Call")?.withRenderingMode(.alwaysTemplate)
        self.callImagview.tintColor = UIColor.mainColor
        
        self.genderImaheview.image = UIImage(named: "ic_profie_gender")?.withRenderingMode(.alwaysTemplate)
        self.genderImaheview.tintColor = UIColor.mainColor
        
        self.wroldVIewIamge.image = UIImage(named: "ic_wlord_profile")?.withRenderingMode(.alwaysTemplate)
        self.wroldVIewIamge.tintColor = UIColor.mainColor
        
        self.relactionship.image = UIImage(named: "ic_Profile_Heart")?.withRenderingMode(.alwaysTemplate)
        self.relactionship.tintColor = UIColor.mainColor
        self.addFriendView.setTitleColor(UIColor.mainColor, for: .normal)
        self.addFriendView.borderColorV = UIColor.mainColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setData() {
        
        //Set image this View Controller
        let url = URL(string: AppInstance.instance.userProfile?.avatar ?? "")
        self.profileImage.kf.indicatorType = .activity
        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        self.aboutLabel.text = user_data?.about
        
        if user_data?.about?.isEmpty == true {
            self.aboutTitleLabel.isHidden = true
        } else {
            self.aboutTitleLabel.isHidden = false
        }
        
        if user_data?.school?.isEmpty == true {
            self.schollView.isHidden = true
        } else {
            self.schollView.isHidden = false
            self.studyLabel.text = user_data?.school
        }
        
        if user_data?.address?.isEmpty == true {
            self.locationView.isHidden = true
        } else {
            self.locationView.isHidden = false
            self.countryLabel.text = user_data?.address
        }
        
        if user_data?.working?.isEmpty == true {
            self.studayView.isHidden = true
        } else {
            self.studayView.isHidden = false
            self.wrokLabel.text = user_data?._working
        }
        
        if user_data?.phoneNumber?.isEmpty == true {
            self.contactView.isHidden = true
        } else {
            self.contactView.isHidden = false
            self.mobileLabel.text = user_data?.phoneNumber
        }
        
        if user_data?.website?.isEmpty == true {
            self.webView.isHidden = true
        } else {
            self.webView.isHidden = false
            self.websiteLabel.text = user_data?.website
        }
        
        if user_data?.gender?.isEmpty == true {
            self.GenderView.isHidden = true
        } else {
            self.GenderView.isHidden = false
            self.genderLabel.text = user_data?.gender
        }
        
        if user_data?.relationshipID == "1" {
            self.relecationShipView.isHidden = false
            self.relecationShiplabel.text = "Single"
            
        } else if user_data?.relationshipID == "2" {
            self.relecationShipView.isHidden = false
            self.relecationShiplabel.text = "In a reationship"
            
        } else if user_data?.relationshipID == "3" {
            self.relecationShipView.isHidden = false
            self.relecationShiplabel.text = "Married"
            
        } else if user_data?.relationshipID == "4" {
            self.relecationShipView.isHidden = false
            self.relecationShiplabel.text = "Engaged"
            
        }else if user_data?.relationshipID == "0" {
            self.relecationShipView.isHidden = false
            self.relecationShiplabel.text = "Non"
            
        } else {
            self.relecationShipView.isHidden = false
            self.relecationShiplabel.text = "Non"
        }
        
        if user_data?.instagram?.isEmpty == true {
            self.instaimageVIew.isHidden = true
        } else {
            self.instaimageVIew.isHidden = false
        }
        
        if user_data?.facebook?.isEmpty == true {
            self.facebookView.isHidden = true
        } else {
            self.facebookView.isHidden = false
        }
        
        if user_data?.youtube?.isEmpty == true {
            self.youtubeView.isHidden = true
        } else {
            self.youtubeView.isHidden = false
        }
        
        if user_data?.vk?.isEmpty == true {
            self.vkView.isHidden = true
        } else {
            self.vkView.isHidden = false
        }
        
        if user_data?.twitter?.isEmpty == true {
            self.twitterView.isHidden = true
        } else {
            self.twitterView.isHidden = false
        }
        
        if user_data?.twitter?.isEmpty == true && user_data?.vk?.isEmpty == true && user_data?.youtube?.isEmpty == true && user_data?.facebook?.isEmpty == true && user_data?.instagram?.isEmpty == true {
            self.soicalMediaLabel.isHidden = true
        } else {
            self.soicalMediaLabel.isHidden = false
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Add(_ sender: Any) {
        let EditProfileVc = EditProfileViewController.initialize(from: .settings)
        self.navigationController?.pushViewController(EditProfileVc, animated: true)
    }
    
    @IBAction func facebookClick(_ sender: UIControl) {
        let appURL = URL(string: self.user_data?.facebook ?? "")
        let application = UIApplication.shared
        if application.canOpenURL(appURL ?? URL(fileURLWithPath: "")) {
            application.open(appURL ?? URL(fileURLWithPath: ""))
        } else {
            let webURL = URL(string: self.user_data?.facebook ?? "")
            application.open(webURL!)
        }
    }
    
    @IBAction func vkButtonClick(_ sender: UIControl) {
        let appURL = URL(string: self.user_data?.vk ?? "")
        let application = UIApplication.shared
        if application.canOpenURL(appURL!) {
            application.open(appURL!)
        } else {
            let webURL = URL(string: self.user_data?.vk ?? "")
            application.open(webURL!)
        }
    }
    
    @IBAction func instaButtonClick(_ sender: UIControl) {
        let appURL = URL(string: self.user_data?.instagram ?? "")
        let application = UIApplication.shared
        if application.canOpenURL(appURL!) {
            application.open(appURL!)
        } else {
            let webURL = URL(string: self.user_data?.instagram ?? "")
            application.open(webURL!)
        }
    }
    
    @IBAction func youtubeButtonClick(_ sender: UIControl) {
        let appURL = URL(string: self.user_data?.youtube ?? "")
        let application = UIApplication.shared
        if application.canOpenURL(appURL!) {
            application.open(appURL!)
        } else {
            let webURL = URL(string: self.user_data?.youtube ?? "")
            application.open(webURL!)
        }
    }
    
    @IBAction func twitterButtonClick(_ sender: UIControl) {
        let appURL = URL(string: self.user_data?.twitter ?? "")
        let application = UIApplication.shared
        if application.canOpenURL(appURL!) {
            application.open(appURL!)
        } else {
            let webURL = URL(string: self.user_data?.twitter ?? "")
            application.open(webURL!)
        }
    }
            
    //MARK: - GetUserData Calling Api
    func getUserData(user_ID: String) -> Bool {
        
        let test = true
        
        if Connectivity.isConnectedToNetwork() {
            self.showProgressDialog(text: "")
            GetUserDataManager.instance.getUserData(user_id: user_ID,
                                                    session_Token: AppInstance.instance._sessionId,
                                                    fetch_type: API.Params.User_data) { (success, sessionError, serverError, error) in
                if success != nil {
                    
                    Async.main({
                        self.dismissProgressDialog {
                            guard let user = success?.userData else { return }
                            self.user_data = user
                            self.setData()
                            self.userFollowresLabel.text = self.user_data?.details?.followersCount
                            self.userFollwingLabel.text = self.user_data?.details?.followingCount
                            self.admin = self.user_data?.admin ?? ""
                            
                            self.admin = self.user_data?.admin ?? ""
                            self.friastName.text = self.user_data?.name ?? ""
                            self.lastName.text = "\("@")\(self.user_data?.name ?? "")"
                            if self.user_data?.gender == "male" {
                                self.genderLabel.text = "Male"
                            } else {
                                self.genderLabel.text = "Female"
                            }
                        }
                        
                    })
                }
                else if sessionError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                        }
                    })
                }
                else if serverError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                        }
                    })
                }
                else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                        }
                    })
                }
            }
        }
        else {
            self.dismissProgressDialog {
                self.view.makeToast(NSLocalizedString("Internet Error", comment: "Internet Error"))
            }
        }
        return test
    }
}
