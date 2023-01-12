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
    @IBOutlet weak var phoneview: UIControl!
    @IBOutlet weak var chatView: UIControl!
    @IBOutlet weak var addFriendView: UIControl!
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
    @IBOutlet weak var instaView: UIImageView!
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var facebookView: UIControl!
    @IBOutlet weak var instaimageVIew: UIControl!
    @IBOutlet weak var vkImageView: UIImageView!
    @IBOutlet weak var vkView: UIControl!
    @IBOutlet weak var youtubeImageVIew: UIImageView!
    @IBOutlet weak var youtubeView: UIControl!
    @IBOutlet weak var twitterImageview: UIImageView!
    @IBOutlet weak var twitterView: UIControl!
    @IBOutlet weak var followBtn: UIImageView!
    
    var user: Users?
    var chat: Chats?
    var userData : FollowingModel.Following?
    var user_data: UserModel?
    var admin = ""
    var isFollowing = 1
    var recipient_ID = ""
    var userProfile = ""
    var userGender = ""
    var mobileNo = ""
    var brithday = ""
    var contryID = ""
    var study = ""
    var wroking = ""
    var website = ""
    var about = ""
    var last_Name = ""
    var frist_Name = ""
    var instagrm = ""
    var twiiter = ""
    var youtube = ""
    var vk = ""
    var facebook = ""
    private var player = AVPlayer()
    private var media = [Messages]()
    private let moreDropdown = DropDown()
    
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
        
        self.setData()
        self.getUserData(user_ID: user?.user_id ?? "")
    }
    
    private func setData() {
        self.mediahightConstraint.constant = 0
        
        //Set image this View Controller
        let url = URL(string: user?._avatar_url ?? "")
        self.profileImage.kf.indicatorType = .activity
        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "ic_No_images"))
        
        self.countryLabel.text = contryID
        self.studyLabel.text = study
        self.wrokLabel.text = wroking
        self.mobileLabel.text = mobileNo
        self.genderLabel.text = userGender
        self.websiteLabel.text = website
        self.aboutLabel.text = about
        self.friastName.text = frist_Name
        self.lastName.text = last_Name
        
        if study.isEmpty == true {
            self.studyLabel.text = "--------"
        } else {
            self.studyLabel.text = user_data?.school
        }
        
        if contryID.isEmpty == true {
            self.countryLabel.text = "--------"
        } else {
            self.countryLabel.text = user_data?.countryID
        }
        
        if wroking.isEmpty == true {
            self.wrokLabel.text = "--------"
        } else {
            self.wrokLabel.text = user_data?.working
        }
        
        if mobileNo.isEmpty == true {
            self.mobileLabel.text = "--------"
        } else {
            self.mobileLabel.text = user_data?.phoneNumber
        }
        
        if website.isEmpty == true {
            self.websiteLabel.text = "--------"
        } else {
            self.websiteLabel.text = user_data?.website
        }
        
        if userGender.isEmpty == true {
            self.genderLabel.text = "--------"
        } else {
            self.genderLabel.text = user_data?.gender
        }
        
        if instagrm.isEmpty == true {
            self.instaView.isHidden = true
            self.instaimageVIew.isHidden = true
        } else {
            self.instaView.isHidden = false
            self.instaimageVIew.isHidden = false
        }
        
        if facebook.isEmpty == true {
            self.facebookView.isHidden = false
            self.facebookImage.isHidden = false
        } else {
            self.facebookView.isHidden = false
            self.facebookImage.isHidden = false
        }
        
        if youtube.isEmpty == true {
            self.youtubeView.isHidden = false
            self.youtubeImageVIew.isHidden = false
        } else {
            self.youtubeView.isHidden = false
            self.youtubeImageVIew.isHidden = false
        }
        
        if vk.isEmpty == true {
            self.vkView.isHidden = false
            self.vkImageView.isHidden = false
        } else {
            self.vkView.isHidden = false
            self.vkImageView.isHidden = false
        }
        
        if twiiter.isEmpty == true {
            self.twitterView.isHidden = false
            self.twitterImageview.isHidden = false
        } else {
            self.twitterView.isHidden = false
            self.twitterImageview.isHidden = false
        }
        
        if let user = user,
           let myChat = chat {
            let chatMessages = myChat.getMessages()
            self.media = chatMessages.filter({ !$0._media.isEmpty }).suffix(15)
            self.mediahightConstraint.constant = 130
            self.mediaCollectionView.reloadData()
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
            let vc = R.storyboard.chat.chatScreenVC()
            vc?.recipientID = self.userData?.userID ?? ""
            vc!.followingUserObject = self.userData ?? nil
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func Add(_ sender: Any) {
        //        self.followRequest()
    }
    
    @IBAction func socialLink(_ sender: UIControl) {
        switch sender.tag {
        case 0:
            if (self.user_data?.facebook != "") {
                let appURL = URL(string: self.user_data?.facebook ?? "")
                let application = UIApplication.shared
                if application.canOpenURL(appURL!) {
                    application.open(appURL!)
                } else {
                    let webURL = URL(string: self.user_data?.facebook ?? "")
                    application.open(webURL!)
                }
            }
        case 1:
            if (self.user_data?.instagram != "") {
                let appURL = URL(string: self.user_data?.instagram ?? "")
                let application = UIApplication.shared
                if application.canOpenURL(appURL!) {
                    application.open(appURL!)
                } else {
                    let webURL = URL(string: self.user_data?.instagram ?? "")
                    application.open(webURL!)
                }
            }
        case 2:
            if (self.user_data?.twitter != "") {
                let appURL = URL(string: self.user_data?.twitter ?? "")
                let application = UIApplication.shared
                if application.canOpenURL(appURL!) {
                    application.open(appURL!)
                } else {
                    let webURL = URL(string: self.user_data?.twitter ?? "")
                    application.open(webURL!)
                }
            }
        case 3:
            if (self.user_data?.youtube != "") {
                let appURL = URL(string: self.user_data?.youtube ?? "")
                let application = UIApplication.shared
                if application.canOpenURL(appURL!) {
                    application.open(appURL!)
                } else {
                    let webURL = URL(string: self.user_data?.google ?? "")
                    application.open(webURL!)
                }
            }
        case 4:
            if (self.user_data?.vk != "") {
                let appURL = URL(string: self.user_data?.vk ?? "")
                let application = UIApplication.shared
                if application.canOpenURL(appURL!) {
                    application.open(appURL!)
                } else {
                    let webURL = URL(string: self.user_data?.vk ?? "")
                    application.open(webURL!)
                }
            }
        case 5:
            if (self.user_data?.youtube != "") {
                let appURL = URL(string: self.user_data?.youtube ?? "")
                let application = UIApplication.shared
                if application.canOpenURL(appURL!) {
                    application.open(appURL!)
                } else {
                    let webURL = URL(string: self.user_data?.youtube ?? "")
                    application.open(webURL!)
                }
            }
            
        default:
            print("Nothing")
        }
    }
    
    @IBAction func viewAllMediaAction(_ sender: UIButton) {
        let vc = self.getStoryboardView(MediaViewController.self)
        vc.chat = self.chat
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
                cell.mediaImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_No_images"))
                
            } else if (extenion == "pdf") {
                cell.mediaImageView.kf.indicatorType = .activity
                cell.mediaImageView.image = UIImage(named: "ic_doc")
                
            } else if (extenion == "mp4"){
                let videoURL = URL(string: object.media ?? "")
                if let thumbnailImage = getThumbnailImage(forUrl: videoURL ?? URL(fileURLWithPath: "")) {
                    cell.mediaImageView.image = thumbnailImage
                }
                let playerController = AVPlayerViewController()
                player.pause()
                
            } else if extenion == "wav" {
                cell.mediaImageView.image = UIImage(named: "ic_audio_setting")
                
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
    
    private func handleMediaClick(with object: Messages, indexpathForCell: IndexPath) {
        guard let type = object._typeObject else { return }
        print("\(object._media)")
        switch type {
        case .leftAudio, .rightAudio:
            self.clickAudio(indexpathForCell: indexpathForCell)
            
        case .leftVideo, .rightVideo:
            self.clickVidowButton(indexpathForCell: indexpathForCell)
            
        case .leftImage, .rightImage:
            self.handleImageClick(indexpathForCell: indexpathForCell)
            
        case .leftFile, .rightFile:
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
    private func getUserData(user_ID: String) {
        
        if Connectivity.isConnectedToNetwork() {
            GetUserDataManager.instance.getUserData(user_id: user_ID,
                                                    session_Token: AppInstance.instance._sessionId,
                                                    fetch_type: API.Params.User_data) { (success, sessionError, serverError, error) in
                if success != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            guard let user = success?.userData else { return }
                            self.user_data = user
                            self.setData()
                            self.admin = self.user_data?.admin ?? ""
                            if self.user_data?.isFollowingMe == 1 {
                                self.followBtn.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
                                self.followBtn.backgroundColor = UIColor.hexStringToUIColor(hex: "984243")
                            }
                            else if (self.user_data?.isFollowingMe == 2) {
                                self.followBtn.setImage(UIImage(named: "log-in-1"), for: .normal)
                                self.followBtn.backgroundColor = UIColor.hexStringToUIColor(hex: "984243")
                            }
                            else {
                                self.followBtn.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)
                                self.followBtn.backgroundColor = UIColor.hexStringToUIColor(hex: "888787")
                            }
                            
                            self.admin = self.user_data?.admin ?? ""
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
