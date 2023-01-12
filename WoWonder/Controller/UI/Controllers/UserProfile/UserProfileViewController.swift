//
//  UserProfileController.swift
//  WoWonder
//
//  Created by Ubaid Javaid on 7/16/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import UIKit
import WowonderMessengerSDK
import Async
import DropDown
import AVFoundation
import AVKit
import Kingfisher

class UserProfileViewController: BaseVC {
    
    //MARK: - All Outlet This UserProfile Controller
    @IBOutlet weak var mediahightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var moreView: UIControl!
    @IBOutlet weak var chatView: UIControl!
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
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutTitleLabel: UILabel!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var facebookView: UIControl!
    @IBOutlet weak var instaimageVIew: UIControl!
    @IBOutlet weak var vkView: UIControl!
    @IBOutlet weak var youtubeView: UIControl!
    @IBOutlet weak var twitterView: UIControl!
    @IBOutlet weak var chatButton: UIControl!
    @IBOutlet weak var userFollwingLabel: UILabel!
    @IBOutlet weak var userFollowresLabel: UILabel!
    @IBOutlet weak var studayView: UIView!
    @IBOutlet weak var schollView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var GenderView: UIView!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var socialMediaLabel: UILabel!
    @IBOutlet weak var viewAllMediaButton: UIButton!
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
    var searchUserObject: SearchModel.User?
    var admin = ""
    var isFollowing = 1
    private var player = AVPlayer()
//    private var media = [Messages]()
    private let moreDropdown = DropDown()
    var isfind = false
    var user_id = ""
    var messageArray: [MessageModel] = []
    var media: [MessageMedia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpscreenUI()
    }
    
    private func setUpscreenUI() {
        self.mediaCollectionView.delegate = self
        self.mediaCollectionView.dataSource = self
        self.mediaCollectionView.registerNib(MediaCollectionViewCell.self)
        self.customizeDropdown()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        self.chatView.backgroundColor = UIColor.mainColor
        self.viewAllMediaButton.setTitleColor(UIColor.mainColor, for: .normal)
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setData() {
        self.mediahightConstraint.constant = 0
        self.viewAllMediaButton.isHidden = true
        //Set image this View Controller
        let url = URL(string: user?._avatar_url ?? "")
        self.profileImage.kf.indicatorType = .activity
        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        self.aboutLabel.text = user_data?.about
        
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
        
//        if let user = user,
//           let myChat = chat {
//            let chatMessages = myChat.getMessages()
//            self.media = chatMessages.filter({ !$0._media.isEmpty }).suffix(15)
//            self.mediahightConstraint.constant = 130
//            self.self.viewAllMediaButton.isHidden = false
//            self.mediaCollectionView.reloadData()
//        }
        
        for index in 0..<messageArray.count {
            let obj = messageArray[index]
            
            if obj.media != "" {
                let Varmedia = MessageMedia(media: obj.media, type: obj.type)
                self.media.append(Varmedia)
                self.mediahightConstraint.constant = 130
                self.self.viewAllMediaButton.isHidden = false
                self.mediaCollectionView.reloadData()
            } else {
            }
        }
        
        if user_data?.twitter?.isEmpty == true && user_data?.vk?.isEmpty == true && user_data?.youtube?.isEmpty == true && user_data?.facebook?.isEmpty == true && user_data?.instagram?.isEmpty == true {
            self.socialMediaLabel.isHidden = true
        } else {
            self.socialMediaLabel.isHidden = false
        }        
    }
}

// MARK: - All Action This View Controler
extension UserProfileViewController {
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func More(_ sender: Any) {
        self.moreDropdown.show()
    }
    
    @IBAction func Message(_ sender: Any) {
        if self.isFollowing == 1 {
            let chatColor = UserDefaults.standard.getChatColorHex(Key: Local.CHAT_COLOR_HEX.ChatColorHex)
            let vc = ChatViewController.initialize(from: .chat)
            vc.recipientID = self.user_data?.userID ?? ""
            vc.searchUserObject = self.searchUserObject
            self.navigationController?.pushViewController(vc, animated: true)
        } else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func Add(_ sender: Any) {
        self.setSendRquest()
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
    
    @IBAction func viewAllMediaAction(_ sender: UIButton) {
        let vc = self.getStoryboardView(MediaViewController.self)
        vc.media = self.media
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - getThumbnailImage
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    
    func setSendRquest() {
        
        if isfind == false {
            FollowRequestActionManager.sharedInstance.followRequest(user_Id: user?.user_id ?? "",
                                                                    ServerKey: AppInstance.instance._sessionId) { Success, error in
                if Success != "" {
                    if Success ==  "followed" {
                        self.addFriendView.setTitle("Request", for: .normal)
                        self.addFriendView.setTitleColor(UIColor.mainColor, for: .normal)
                    } else {
                        self.addFriendView.setTitle("Follow", for: .normal)
                        self.addFriendView.setTitleColor(UIColor.mainColor, for: .normal)
                    }
                } else {
                    print("\(error?.localizedDescription ?? "" )")
                }
            }
        } else {
            FollowRequestActionManager.sharedInstance.followRequest(user_Id: user_id,
                                                                    ServerKey: AppInstance.instance._sessionId) { Success, error in
                if Success != "" {
                    if Success ==  "followed" {
                        self.addFriendView.setTitle("Request", for: .normal)
                        self.addFriendView.setTitleColor(UIColor.mainColor, for: .normal)
                    } else {
                        self.addFriendView.setTitle("Follow", for: .normal)
                        self.addFriendView.setTitleColor(UIColor.mainColor, for: .normal)
                    }
                } else {
                    print("\(error?.localizedDescription ?? "" )")
                }
            }
        }
    }
}

// MARK: - COLLECTION VIEW DELEGATE, DataSource & DelegateFlowLayout Method's
extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mediaCollectionView {
            return self.media.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.mediaCollectionView {
            let cell = collectionView.dequeueCell(MediaCollectionViewCell.self, for: indexPath)
            let object = self.media[indexPath.row]
            
            let url = URL(string: object.media ?? "")
            let extenion =  url?.pathExtension
            if (extenion == "jpg") || (extenion == "png") || (extenion == "JPG") || (extenion == "PNG"){
                cell.mediaImageView.isHidden = false
                cell.mediaImageView.kf.indicatorType = .activity
                cell.mediaImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
                cell.viewImage.isHidden = true
                cell.imageName.isHidden = true
                
            } else if (extenion == "pdf") {
                cell.viewImage.isHidden = false
                cell.imageName.isHidden = false
                cell.imageName.isHidden = false
                cell.imageName.image = UIImage(named: "ic_media_Doc")
                
            } else if (extenion == "mp4"){
                let videoURL = URL(string: object.media ?? "")
                if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
                    cell.mediaImageView.image = thumbnailImage
                    cell.viewImage.isHidden = false
                    cell.imageName.isHidden = false
                    cell.imageName.image = UIImage(named: "ic_media_play")
                }
                let playerController = AVPlayerViewController()
                player.pause()
                
            } else if extenion == "wav" {
                cell.viewImage.isHidden = false
                cell.imageName.isHidden = false
                cell.imageName.image = UIImage(named: "ic_audio_media")
                
            } else {}
            
            return cell
        }
        
        let cell = collectionView.dequeueCell(UserInfoCollectionViewCell.self, for: indexPath)
        let mutableString = NSMutableAttributedString(string: "Gender: ",
                                                      attributes: [
                                                        .font : UIFont.systemFont(ofSize: 14).bold,
                                                      ])
        mutableString.append(NSAttributedString(string: self.chat?.getChatUsers().first?.user?._gender ?? "",
                                                attributes: [:]))
        cell.model = UserInfoCollectionViewCell.Model(attributedString: mutableString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.mediaCollectionView {
            let object = self.media[indexPath.row]
            self.handleMediaClick(with: object, indexpathForCell: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.mediaCollectionView {
            let collectionHeight = collectionView.height
            return CGSize(width: collectionHeight, height: collectionHeight)
        }
        return CGSize(width: collectionView.width, height: 40)
    }
}

// MARK: - CUSTOM FUNCTIONS
extension UserProfileViewController {
    
    private func handleMediaClick(with object: MessageMedia, indexpathForCell: IndexPath) {
        guard let type = object.type else { return }
        switch type {
        case "left_audio", "right_Adioes":
            self.clickAudio(indexpathForCell: indexpathForCell)
            
        case "left_video", "right_video":
            self.clickVidowButton(indexpathForCell: indexpathForCell)
            
        case "left_image", "right_image":
            self.handleImageClick(indexpathForCell: indexpathForCell)
            
        case "left_file", "right_file":
            self.clickFile(indexpathForCell: indexpathForCell)
            
        default:
            break
        }
    }
    
    private func handleImageClick(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageController
        vc.imageURL = object.media ?? ""
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - clickVidowButton
    func clickVidowButton(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        let player = AVPlayer(url: URL(string: object.media ?? "")!)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //MARK: - clickFile
    @objc func clickFile(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        if let url = URL(string: object.media ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    //MARK: - clickFile
    @objc func clickAudio(indexpathForCell: IndexPath) {
        let object = self.media[indexpathForCell.row]
        if let url = URL(string: object.media ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    
    //MARK: - GetUserData Calling Api
    func getUserData(user_ID: String) {
        
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
                            
                            
                            let url = URL(string: user.avatar ?? "")
                            self.profileImage.kf.indicatorType = .activity
                            self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
                            self.aboutLabel.text = user.about
                            
                            
                            self.admin = self.user_data?.admin ?? ""
//                            if self.user_data?.isFollowingMe == 1 {
//                                self.addFriendView.setTitle("Accept", for: .normal)
//                            }
//                            else if (self.user_data?.isFollowingMe == 2) {
//                                self.addFriendView.setTitle("Request", for: .normal)
//                            }
//                            else {
//                                self.addFriendView.setTitle("Follow", for: .normal)
//                            }
                            if self.user_data?.isFollowingMe == 0 {
                                self.addFriendView.backgroundColor = UIColor.white
                                self.addFriendView.borderColorV = UIColor.ButtonColor
                                self.addFriendView.borderWidthV = 1
                                self.addFriendView.setTitleColor(UIColor.ButtonColor, for: .normal)
                                if AppInstance.instance.connectivity_setting == "0"{
                                    self.addFriendView.setTitle(NSLocalizedString("follow", comment: "follow"), for: .normal)
                                }
                                else{
                                    self.addFriendView.setTitle(NSLocalizedString("AddFriend", comment: "AddFriend"), for: .normal)
                                }
                                
                            }else{
                                self.addFriendView.backgroundColor = UIColor.bgMain
                                self.addFriendView.setTitleColor(UIColor.white, for: .normal)
                                if AppInstance.instance.connectivity_setting == "0"{
                                    self.addFriendView.setTitle(NSLocalizedString("following", comment: "following"), for: .normal)
                                }
                                else{
                                    self.addFriendView.setTitle(NSLocalizedString("AddFriend", comment: "AddFriend"), for: .normal)
                                }
                            }

                            
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
    }
    
    //MARK: - CustomizeDropdown
    private func customizeDropdown() {
        moreDropdown.dataSource = [NSLocalizedString("Block", comment: "Block"),NSLocalizedString("Copy Link To Profile", comment: "Copy Link To Profile"), NSLocalizedString("Share", comment: "Share")]
        moreDropdown.backgroundColor = UIColor.hexStringToUIColor(hex: "454345")
        moreDropdown.textColor = UIColor.white
        moreDropdown.width = 200
        moreDropdown.direction = .any
        moreDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                self.blockUser()
            }else if index == 1 {
                UIPasteboard.general.string = self.user_data?.url ?? ""
                self.view.makeToast(NSLocalizedString("Copied to clipboard", comment: "Copied to clipboard"))
            }else if index == 2{
                let textToShare = [ self.user_data?.url ?? "" ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.assignToContact,UIActivity.ActivityType.mail,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.message,UIActivity.ActivityType.postToFlickr,UIActivity.ActivityType.postToVimeo,UIActivity.ActivityType.init(rawValue: "net.whatsapp.WhatsApp.ShareExtension"),UIActivity.ActivityType.init(rawValue: "com.google.Gmail.ShareExtension"),UIActivity.ActivityType.init(rawValue: "com.toyopagroup.picaboo.share"),UIActivity.ActivityType.init(rawValue: "com.tinyspeck.chatlyio.share")]
                self.present(activityViewController, animated: true, completion: nil)
                
            }
        }
    }
    
    //MARK: - BlockUser Api call
    private func blockUser() {
        if self.admin == "1" {
            let alert = UIAlertController(title: "", message: NSLocalizedString("You cannot block this user because it is administrator", comment: "You cannot block this user because it is administrator"), preferredStyle: .alert)
            let okay = UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: .default, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion:nil)
        }else {
            //            //
            let sessionToken = AppInstance.instance.sessionId ?? ""
            Async.background({
                BlockUsersManager.instanc.blockUnblockUser(session_Token: sessionToken, blockTo_userId: self.user_data?.userID ?? "", block_Action: "block", completionBlock: { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                //                                log.debug("userList = \(success?.blockStatus ?? "")")
                                self.view.makeToast(NSLocalizedString("User has been unblocked!!", comment: "User has been unblocked!!"))
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                        
                    }else if sessionError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(sessionError?.errors?.errorText)
                            }
                        })
                        
                    }else if serverError != nil {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(serverError?.errors?.errorText)
                            }
                        })
                        
                    }else {
                        Async.main({
                            self.dismissProgressDialog {
                                self.view.makeToast(error?.localizedDescription)
                            }
                        })
                    }
                })
            })
        }
    }
}

final class UserInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var model: Model! {
        willSet {
            self.label.attributedText = newValue.attributedString
        }
    }
    
    struct Model {
        var icon: UIImage?
        var attributedString: NSAttributedString
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
