
import UIKit
import XLPagerTabStrip
import Async
import Alamofire
import SwiftEventBus
import WowonderMessengerSDK
import GoogleMobileAds
import FBAudienceNetwork
import Kingfisher

class ChatVC: BaseVC,StoryBoardVC {
    
    @IBOutlet weak var downTextLabel: UILabel!
    @IBOutlet weak var noMessagesLabel: UILabel!
    @IBOutlet weak var showStack: UIStackView!
    @IBOutlet weak var noChatImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var peopleBtn: UIButton!
    
    /// ios_m_device_id
    
    //Ads
    //Google Ads
    var bannerView: GADBannerView!
    var interstitial: GADInterstitialAd!
    //Facebook Ads
    var fullScreenAd: FBInterstitialAd!
    var bannerAdView: FBAdView!
    
//    private var userObject: GetUserListModel.GetUserListSuccessModel?
    private var refreshControl = UIRefreshControl()
    private var fetchSatus: Bool? = true
    private var timer = Timer()
    private var callId: Int = 0
    private var callingStatus: String = ""
    private var callType: String = ""
    private var friendRequests = [[String : Any]]()
    private var callingAudioPlayer: AVAudioPlayer?
    
    private var callProvider: CallProvider {
        get {
            return ControlSettings.agoraCall == true && ControlSettings.twilloCall == false ? .agora : .twillo
        }
    }
    
    private var array = [Chats]()
    private var requestsGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let storeContainer = self.coreDataManager.context.persistentStoreCoordinator
//
//        //Delete each existing persistent store
//        for store in storeContainer?.persistentStores ?? [] {
//            do {
//                try storeContainer?.destroyPersistentStore(
//                    at: store.url!,
//                    ofType: store.type,
//                    options: nil
//                )
//                print("Success delete")
//
//            } catch {
//                print("ERROR delete")
//            }
//        }
        
        print("Hamad token \(AppInstance.instance._sessionId)")
        
        self.setupUI()
//        self.getRequest()
        self.fetchData()
        
        SwiftEventBus.onMainThread(self, name: EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_CONNECTED) { result in
//            self.getRequest()
            self.fetchData()
        }
        
        SwiftEventBus.onMainThread(self, name: EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_DIS_CONNECTED) { result in
//            log.verbose("Internet dis connected!")
        }
        
//        log.verbose("iosDeviceId = \(AppInstance.instance.userProfile?.iosMDeviceID ?? "")")
//        if ControlSettings.shouldShowAddMobBanner{
//
//            if ControlSettings.googleAds {
//                interstitial = GADInterstitial(adUnitID:  ControlSettings.interestialAddUnitId)
//                let request = GADRequest()
//                interstitial.load(request)
//                interstitial.delegate = self
//            }else if ControlSettings.facebookAds{
//                loadFullViewAdd()
//            }
//        }
    }
    
    deinit {
        SwiftEventBus.unregister(self)
    }
    
//    func CreateAd() -> GADInterstitialAd {
//
//        GADInterstitialAd.load(withAdUnitID:ControlSettings.interestialAddUnitId,
//                               request: GADRequest(),
//                               completionHandler: { (ad, error) in
//            if let error = error {
//                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                return
//            }
//            self.interstitial = ad
//        }
//        )
//        return  self.interstitial
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SwiftEventBus.postToMainThread("settings", sender: 0)
    }
    
    @IBAction func followingPressed(_ sender: Any) {
        let vc = R.storyboard.dashboard.followingVC()
        self.navigationController?.pushViewController(vc!, animated: true)
        AppInstance.instance.addCount = AppInstance.instance.addCount! + 1
    }
}

// MARK: - TABLE VIEW DELEGATE

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return self.array.count
        }
        else {
            return self.friendRequests.count > 0 ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestcell") as! FriendRequestCell
            
            let index = self.friendRequests[indexPath.row]
            if (self.friendRequests.count == 1) {
                cell.image2.isHidden = true
                cell.image3.isHidden = true
                
                if let pro_url = index["avatar"] as? String {
                    let url = URL(string: pro_url)
                    cell.image1.kf.indicatorType = .activity
                    cell.image1.kf.setImage(with: url, placeholder: UIImage(named: ""))
                }
            }
            else if (self.friendRequests.count == 2) {
                cell.image3.isHidden = true
                if let pro_url1 = index["avatar"] as? String {
                    let url = URL(string: pro_url1)
                    cell.image1.kf.indicatorType = .activity
                    cell.image1.kf.setImage(with: url, placeholder: UIImage(named: ""))
                }
                if let pro_url2 = self.friendRequests[1]["avatar"] as? String {
                    let url = URL(string: pro_url2)
                    cell.image1.kf.indicatorType = .activity
                    cell.image1.kf.setImage(with: url, placeholder: UIImage(named: ""))
                }
            }
            else if (self.friendRequests.count == 0) {
                print("Nothing")
            }
            else {
                if let pro_url1 = self.friendRequests[0]["avatar"] as? String {
                    let url = URL(string: pro_url1)
                    cell.image1.kf.indicatorType = .activity
                    cell.image1.kf.setImage(with: url, placeholder: UIImage(named: ""))
                }
                if let pro_url2 = self.friendRequests[1]["avatar"] as? String {
                    let url = URL(string: pro_url2)
                    cell.image3.kf.indicatorType = .activity
                    cell.image3.kf.setImage(with: url, placeholder: UIImage(named: ""))
                }
                if let pro_url3 = self.friendRequests[2]["avatar"] as? String {
                    let url = URL(string: pro_url3)
                    cell.image3.kf.indicatorType = .activity
                    cell.image3.kf.setImage(with: url, placeholder: UIImage(named: ""))
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chats_TableCell.identifier) as! Chats_TableCell
            
            let chat = self.array[indexPath.row]
            guard let object = chat.getChatUsers().first?.user else { return cell }
            let lastMsg = chat.getMessages().last
            
            cell.usernameLabel.text = chat._name
            
            let url = URL(string: object._avatar_url)
            cell.profileImage.kf.indicatorType = .activity
            cell.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
            cell.profileImage.cornerRadiusV = (cell.profileImage.frame.height) / 2
            
            if object._last_seen_status == "off" {
                cell.timeLabel.isHidden = true
                cell.showOnlineView.isHidden = true
            } else {
                cell.timeLabel.isHidden = false
                cell.timeLabel.text = setTimestamp(epochTime: (object._last_seen))
                cell.showOnlineView.backgroundColor = UIColor.green
                cell.showOnlineView.isHidden = false
            }
//        cell.seenCheckImage.image = cell!.seenCheckImage.image?.withRenderingMode(.alwaysTemplate)
            
            let lightFont = UIFont(name: "Poppins-Regular", size: 17)
            
            if lastMsg?._to_id == AppInstance.instance._userId &&
                lastMsg?._from_id == AppInstance.instance._userId {
                if lastMsg?._seen == "0" || (lastMsg?._seen ?? "").isEmpty {
                    cell.usernameLabel.font = lightFont
                    cell.messageLabel.font = UIFont(name: "Poppins-Regular", size: 13)
//                cell.seenCheckImage.isHidden = true
                }else {
                    cell.usernameLabel.font = lightFont
                    cell.messageLabel.font = UIFont(name: "Poppins-Regular", size: 13)
//                cell.seenCheckImage.isHidden = false
//                cell.seenCheckImage.tintColor = .darkGray
                }
                
            } else if lastMsg?.to_id == AppInstance.instance._userId &&
                        lastMsg?.from_id != AppInstance.instance._userId {
                
                if lastMsg?.seen == "0" || lastMsg?.seen == "" {
//                cell.seenCheckImage.isHidden = false
                    cell.usernameLabel.font = UIFont(name: "Poppins-SemiBold", size: 17)
                    cell.messageLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
//                cell.seenCheckImage.tintColor = .darkGray
                    
                }else {
//                cell.seenCheckImage.isHidden = false
                    cell.usernameLabel.font = lightFont
                    cell.messageLabel.font = UIFont(name: "Poppins-Regular", size: 13)
//                cell.seenCheckImage.tintColor = UIColor.hexStringToUIColor(hex: "#B46363")
                }
            }
//            cell?.messageLabel.text = lastMsg?.text?.htmlAttributedString  ?? ""
            
            let filename = lastMsg?._media_file_name
            let lat = Double(lastMsg?.lat ?? "0.0") ?? 0.0
            let lng = Double(lastMsg?.lng ?? "0.0") ?? 0.0
            
            if !(lastMsg?._product_id ?? "").isEmpty && lastMsg?._product_id != "0" {
                cell.messageLabel.text = "Sent Product to you"
            }
            else {
                if lastMsg?._media_file_name == "image.jpg" {
                    cell.messageLabel.text = NSLocalizedString("image", comment: "image")
                }
                else if !(lastMsg?.stickers ?? "").isEmpty {
                    cell.messageLabel.text = NSLocalizedString("GIF", comment: "GIF")
                }
                else if filename?.contains(".mp4") == true {
                    cell.messageLabel.text = NSLocalizedString("video", comment: "video")
                }
                else if filename?.contains(".wav") == true {
                    cell.messageLabel.text = NSLocalizedString("audio", comment: "audio")
                }
                else if lat > 0.0 || lng > 0.0 {
                    cell.messageLabel.text = "Location"
                }
                else {
                    var text = self.decryptionAESModeECB(messageData: lastMsg?.text?.decodeHtmlEntities() ?? "",
                                                         key: lastMsg?.time ?? "")
                    if let range = text?.range(of: "<br>") {
                        text?.removeSubrange(range)
                    }
                    
                    cell.messageLabel.text = text
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if AppInstance.instance.addCount == ControlSettings.interestialCount {
            if ControlSettings.facebookAds {
                if let ad = interstitial {
                    fullScreenAd = FBInterstitialAd(placementID: ControlSettings.facebookPlacementID)
                    fullScreenAd?.delegate = self
                    fullScreenAd?.load()
                } else {
                    print("Ad wasn't ready")
                }
                
            }else if ControlSettings.googleAds {
//                    interstitial.present(fromRootViewController: self)
//                    interstitial = CreateAd()
                AppInstance.instance.addCount = 0
            }
        }
        
        if (indexPath.section == 0) {
            let Storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = Storyboard.instantiateViewController(withIdentifier: "FollowRequestVC") as! FollowRequestController
            vc.friend_Requests = self.friendRequests
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let model = self.array[indexPath.row]
            guard let object = model.getChatUsers().first else { return }
            guard let object1 = model.getChatUsers().first?.user else { return }
            AppInstance.instance.addCount = AppInstance.instance.addCount! + 1
            let vc = ChatViewController.initialize(from: .chat)
//            vc?.recipientID = object._user_id
//            vc!.chatModel = model
////            vc?.chatColorHex = object.user?.last_message?._chat_color ?? ""
//            vc?.object_LatSeen = object1._last_seen_status
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.deleteChat(UserID: self.array[indexPath.row].getChatUsers().first?._user_id ?? "")
        }
        editAction.backgroundColor = .red
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "More") { (rowAction, indexPath) in
            self.showControls(Index: indexPath.row)
        }
        
        deleteAction.backgroundColor = .lightGray
        
        return [editAction,deleteAction]
    }
}

extension ChatVC:FBInterstitialAdDelegate {
    
    //Place your placementID here to see the Facebook ads
    func loadFullViewAdd() {
        fullScreenAd = FBInterstitialAd(placementID: ControlSettings.facebookPlacementID)
        fullScreenAd.delegate = self
        fullScreenAd.load()
    }
    
    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
//        print(error.localizedDescription)
    }
    
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        interstitialAd.show(fromRootViewController: self)
//        print("AddLoaded")
    }
    
    func interstitialAdWillClose(_ interstitialAd: FBInterstitialAd) {
        
    }
}

extension ChatVC:IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("CHATS", comment: "CHATS"))
    }
}

extension ChatVC: FollowRequestDelegate {
    
    func follow_request(index: Int) {
        self.friendRequests.remove(at: index)
        self.tableView.reloadData()
    }
}

extension ChatVC {
    
    private func setupUI() {
        self.noChatImage.tintColor = .mainColor
        self.peopleBtn.backgroundColor = .ButtonColor
        self.noMessagesLabel.text = NSLocalizedString("No more Messages", comment: "")
        self.downTextLabel.text = NSLocalizedString("Start new conversations by going to contact", comment: "")
        self.noChatImage.isHidden = true
        self.showStack.isHidden = true
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: R.reuseIdentifier.chats_TableCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.chats_TableCell.identifier)
        self.tableView.register(UINib(nibName: "FriendRequestCell", bundle: nil), forCellReuseIdentifier: "FriendRequestcell")
    }
    
    @objc func refresh(sender: AnyObject) {
        fetchSatus = true
        self.array.removeAll()
        self.friendRequests.removeAll()
        self.tableView.reloadData()
        self.fetchData()
        self.getRequest()
    }
    
    private func getRequest() {
        if Connectivity.isConnectedToNetwork() {
            Async.main({
                GetFriendRequestManager.sharedInstance.getFriendRequest { (success, authError, error) in
                    if success != nil {
                        for i in success!.friend_requests {
                            self.friendRequests.append(i)
                        }
                        self.tableView.reloadData()
                    }
                    else if (authError != nil) {
                        self.view.makeToast(authError?.errors.errorText)
                    }
                    else if (error != nil) {
                        self.view.makeToast(error?.localizedDescription)
                    }
                }
            })
        }
        else {
            self.view.makeToast(NSLocalizedString("Internet Error", comment: "Internet Error"))
        }
    }
    
    private func fetchData() {
        
        let chats = Chats.getChats()
        
        if !chats.isEmpty {
            self.array = chats
            self.tableView.reloadData()
            
            self.getUserList { [weak self] (response) in
                guard let self = self else { return }
                guard let list = response.data else { return }
                
                for user in list {
                    if let chatUser = ChatUsers.getChatUserByUserID(user._userID) {
                        chatUser.updateUser(user)
                    } else {
                        let localChat = Chats(user: user)
                        localChat.save()
                        self.array.append(localChat)
                    }
                }
                self.tableView.reloadData()
            }
            
        } else {
            
            self.getUserList { model in
                Async.main({
                    self.dismissProgressDialog {
                        guard let data = model.data else { return }
                        self.array.removeAll()
                        
                        self.noChatImage.isHidden = !data.isEmpty
                        self.showStack.isHidden = !data.isEmpty
                        
                        for item in data {
                            if let chat = Chats.getChatByUserID(item._userID) {
                                self.array.append(chat)
                                
                            } else {
                                let chat = Chats(user: item)
                                chat.save()
                                self.array.append(chat)
                            }
                        }
                        
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                })
            }
        }
    }
    
    private func getUserList(_ completion: @escaping (UserModelResponse) -> Void) {
        let userID = AppInstance.instance._userId
        
        if fetchSatus! {
            fetchSatus = false
//            //
        }else {
            //            log.verbose("will not show Hud more...")
        }
        
        Async.background({
            
            self.requestsGroup.enter()
            GetUserListManager.instance.getUserList(user_id: userID,
                                                    session_Token: AppInstance.instance._sessionId) { result in
                
                switch result {
                case .success(let model):
                    self.dismissProgressDialog {
                        completion(model)
                        
                        guard let agoraCall = model.agoraCall else { return }
                        guard let videoCall = model.videoCall else { return }
                        guard let audioCall = model.audioCall else { return }
                        
                        self.callId = Int(model.agoraCallData?.data?._id ?? "") ?? 0
                        let roomName = model.agoraCallData?.data?._roomName ?? ""
//                        let senderName = model.agoraCallData?.name ?? ""
//                        let callingType = model.agoraCallData?.data?._type ?? ""
                        let accessToken = model.agoraCallData?.data?._accessToken ?? ""
//                        let senderProfileImage = model.agoraCallData?._avatar ?? ""
                        
//                        let message = "\(senderName) sends you an \(String(describing: callingType)) request.."
                        
//                        let alert = UIAlertController(title: "Calling".localize(),
//                                                      message: message,
//                                                      preferredStyle: .alert)
                        
                        switch self.callProvider {
                        case .agora:
                            if agoraCall == true {
                                self.callingStatus = "agora"
//                                self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                                  target: self,
//                                                                  selector: #selector(self.update),
//                                                                  userInfo: nil,
//                                                                  repeats: true)
                                
                                let vc = R.storyboard.call.agoraCallVC()
                                vc?.usernameString = model.agoraCallData?._name
                                vc?.profileImageUrlString = model.agoraCallData?._avatar
                                vc?.callDirection = .incoming
                                vc?.callId = self.callId
                                vc?.roomName = roomName
                                vc?.callToken = accessToken
                                self.present(vc!, animated: true)
                            }
                            break
                            
                        case .twillo:
                            self.callingStatus = "twillo"
                            
                            if videoCall == true {
                                self.callType = "video"
                                
                                self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                                                  target: self,
                                                                  selector: #selector(self.update),
                                                                  userInfo: nil,
                                                                  repeats: true)
                                
//                                let answer = UIAlertAction(title: NSLocalizedString("Answer", comment: "Answer"), style: .default, handler: { (action) in
//                                    self.TwilloVideoCallAnswer(callID: self.callId,
//                                                               senderCalling: senderName,
//                                                               callingType: "video",
//                                                               roomId: roomName,
//                                                               profileImage: senderProfileImage,
//                                                               accessToken2: accessToken)
//                                })
//
//                                let decline = UIAlertAction(title: NSLocalizedString("Decline", comment: "Decline"), style: .default, handler: { (action) in
//                                    self.callingAudioPlayer?.stop()
//                                    self.twilloDeclineVideoCall(callID: self.callId)
//                                })
//
//                                alert.addAction(answer)
//                                alert.addAction(decline)
//                                self.playReceiveCallingSound()
//                                self.present(alert, animated: true, completion: nil)
                                
                            }else if audioCall == true {
                                
                                self.callType = "audio"
                                self.timer = Timer.scheduledTimer(timeInterval: 0.6,
                                                                  target: self,
                                                                  selector: #selector(self.update),
                                                                  userInfo: nil,
                                                                  repeats: true)
                                
                                let vc = R.storyboard.call.agoraCallVC()
                                vc?.usernameString = model.agoraCallData?._name
                                vc?.profileImageUrlString = model.agoraCallData?._avatar
                                vc?.callDirection = .incoming
                                self.present(vc!, animated: true)
                                
//                                let answer = UIAlertAction(title: NSLocalizedString("Answer", comment: "Answer"), style: .default, handler: { (action) in
//
//                                    self.twilloAudioCallAnswer(callID: self.callId,
//                                                               senderCalling: senderName,
//                                                               callingType: "audio",
//                                                               roomId: roomName,
//                                                               profileImage: senderProfileImage,
//                                                               accessToken2: accessToken)
//                                })
//
//                                let decline = UIAlertAction(title: NSLocalizedString("Decline", comment: "Decline"), style: .default, handler: { (action) in
//                                    self.callingAudioPlayer?.stop()
//                                    self.twilloDeclineAudioCall(callID: self.callId)
//                                })
//
//                                alert.addAction(answer)
//                                alert.addAction(decline)
//                                self.playReceiveCallingSound()
//                                self.present(alert, animated: true, completion: nil)
                                
                            }else {
//                                alert.dismiss(animated: true, completion: nil)
                            }
                            break
                        }
                        
                        self.requestsGroup.leave()
                    }
                    break
                    
                case .failure(let error):
                    Async.main {
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                            self.requestsGroup.leave()
                        }
                    }
                    break
                }
            }
            
            self.requestsGroup.enter()
            GetGeneralDataManager.instance.getUserList(session_Token: AppInstance.instance._sessionId) { result in
                switch result {
                case .success(_):
                    self.requestsGroup.leave()
                    break
                case .failure(_):
                    self.requestsGroup.leave()
                    break
                }
            }
        })
    }
    
    private func agoraDeclineCall(callID: String) {
        self.timer.invalidate()
//        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            CallManager.instance.agoraCallAction(access_token: sessionID,
                                                 call_id: callID,
                                                 action: "decline", completionBlock: { (result) in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
            })
        })
    }
        
    private func twilloDeclineVideoCall(callID: Int) {
        
        self.timer.invalidate()
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.twilloVideoCallAction(user_id: userId, session_Token: sessionID, call_id: "\(callID)", answer_type: "decline", completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main {
                        self.dismissProgressDialog {
                        }
                    }
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
            })
        })
    }
    
    private func twilloDeclineAudioCall(callID: Int){
        
        self.timer.invalidate()
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.twilloAudioCallAction(user_id: userId, session_Token: sessionID, call_id: "\(callID)", answer_type: "decline", completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main({
                        self.dismissProgressDialog {
                        }
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
            })
        })
    }
    
    private func agoraAnswerCall(callID: String, senderCalling: String, callingType: String, roomId: String, profileImage: String) {
//        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            CallManager.instance.agoraCallAction(access_token: sessionID,
                                                 call_id: callID,
                                                 action: "answer", completionBlock: { (result) in
                switch result {
                case .success(_):
                    Async.main({
                        self.dismissProgressDialog {
                            if callingType == "video" {
                                let vc  = R.storyboard.call.videoCallVIewController()
                                vc?.callId = Int(callID)
                                vc?.roomID = roomId
                                self.navigationController?.pushViewController(vc!, animated: true)
                                
                            }else {
                                let vc = R.storyboard.call.agoraCallVC()
                                vc?.callId = Int(callID) ?? 0
                                vc?.roomID = roomId
                                vc?.usernameString = senderCalling
                                vc?.profileImageUrlString = profileImage
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
                        }
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
                
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
////                            log.debug("userList = \(success?.status ?? nil)")
//
//                            if callingType == "video" {
//                                let vc  = R.storyboard.call.videoCallVC()
//                                vc?.callId = Int(callID)
//                                vc?.roomID = roomId
//                                self.navigationController?.pushViewController(vc!, animated: true)
//
//                            }else {
//                                let vc  = R.storyboard.call.agoraCallVC()
//                                vc?.callId = Int(callID)
//                                vc?.roomID = roomId
//                                vc?.usernameString = senderCalling
//                                vc?.profileImageUrlString = profileImage
//                                self.navigationController?.pushViewController(vc!, animated: true)
//                            }
//                        }
//                    })
//
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
////                            log.error("sessionError = \(sessionError?.errors?.errorText)")
//                        }
//                    })
//
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
////                            log.error("serverError = \(serverError?.errors?.errorText)")
//                        }
//                    })
//
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
////                            log.error("error = \(error?.localizedDescription)")
//                        }
//                    })
//                }
            })
        })
    }
    
    private func twilloAudioCallAnswer(callID: Int, senderCalling: String, callingType: String, roomId: String, profileImage: String, accessToken2: String) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.twilloVideoCallAction(user_id: userId, session_Token: sessionID, call_id: "\(callID)", answer_type: "answer", completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main({
                        self.dismissProgressDialog {
                            let vc  = R.storyboard.call.twilloAudioCallVC()
                            vc?.accessToken = accessToken2
                            vc?.roomId = roomId
                            
                            vc?.profileImageUrlString = profileImage
                            vc?.usernameString = senderCalling
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
                
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
////                            log.debug("userList = \(success?.status ?? nil)")
//
//                            //                            let vc  = R.storyboard.call.agoraCallVC()
//                            //                            vc?.callId = Int(callID)
//                            //                            vc?.roomID = roomId
//                            //                            vc?.usernameString = senderCalling
//                            //                            vc?.profileImageUrlString = profileImage
//                            //                            self.navigationController?.pushViewController(vc!, animated: true)
//
//                            let vc  = R.storyboard.call.twilloAudioCallVC()
//                            //                            vc?.callId = callId
//                            ////                            vc?.roomID = RoomId
//                            //                            //vc?.usernameString = senderCalling
//                            //                            //vc?.profileImageUrlString = profileImage
//                            //                            vc?.accessToken = sessionID ?? ""
//                            //                            vc?.usernameLabel.text = user
//                            vc?.accessToken = accessToken2
//                            vc?.roomId = roomId
//
//                            vc?.profileImageUrlString = profileImage
//                            vc?.usernameString = senderCalling
//                            self.navigationController?.pushViewController(vc!, animated: true)
//                        }
//                    })
//
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
////                            log.error("sessionError = \(sessionError?.errors?.errorText)")
//                        }
//                    })
//
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
////                            log.error("serverError = \(serverError?.errors?.errorText)")
//                        }
//                    })
//
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
////                            log.error("error = \(error?.localizedDescription)")
//                        }
//                    })
//                }
            })
        })
    }
    
    private func TwilloVideoCallAnswer(callID: Int, senderCalling: String, callingType: String, roomId: String, profileImage: String, accessToken2: String) {
        
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.twilloVideoCallAction(user_id: userId, session_Token: sessionID, call_id: "\(callID)", answer_type: "answer", completionBlock: { (result) in
                
                switch result {
                case .success(_):
                    Async.main({
                        self.dismissProgressDialog {
                            if callingType == "video" {
                                if self.navigationController?.viewControllers.last is TwilloVideoCallVC {
                                }else {
                                    let vc = R.storyboard.call.twilloVideoCallVC()
                                    vc?.accessToken = accessToken2
                                    vc?.roomId = roomId
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                                
                            }else{
                                let vc  = R.storyboard.call.agoraCallVC()
                                vc?.callId = Int(callID)
                                vc?.roomID = roomId
                                vc?.usernameString = senderCalling
                                vc?.profileImageUrlString = profileImage
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
                        }
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
                
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
////                            log.debug("userList = \(callID)")
//                            if callingType == "video" {
////                                let storyboard = UIStoryboard(name: "Call", bundle: nil)
////                                let vc  = R.storyboard.call.videoCallVC()
////                                vc?.callId = self.callId
////                                vc?.roomID = roomId
////                                self.navigationController?.pushViewController(vc!, animated: true)
//
//                                if self.navigationController?.viewControllers.last is TwilloVideoCallVC {
////                                    log.verbose("Video call controller is already presented")
//                                }else {
//                                    let vc = R.storyboard.call.twilloVideoCallVC()
//                                    vc?.accessToken = accessToken2
//                                    vc?.roomId = roomId
//                                    self.navigationController?.pushViewController(vc!, animated: true)
//                                }
//
//                            }else{
//                                let vc  = R.storyboard.call.agoraCallVC()
//                                vc?.callId = Int(callID)
//                                vc?.roomID = roomId
//                                vc?.usernameString = senderCalling
//                                vc?.profileImageUrlString = profileImage
//                                self.navigationController?.pushViewController(vc!, animated: true)
//                            }
//                        }
//                    })
//
//                }else if sessionError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
////                            log.error("sessionError = \(sessionError?.errors?.errorText)")
//                        }
//                    })
//
//                }else if serverError != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
////                            log.error("serverError = \(serverError?.errors?.errorText)")
//                        }
//                    })
//
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
////                            log.error("error = \(error?.localizedDescription)")
//                        }
//                    })
//                }
            })
        })
    }
    
    private func agoraCheckForAction(callID: Int) {
        
//        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            CallManager.instance.checkForAgoraCall(access_token: sessionID, call_id: callID, completionBlock: { (result) in
                
                switch result {
                case .success(let model):
                    Async.main({
                        self.dismissProgressDialog {
                            
                            switch model._callStatusObject {
                            case .answered:
                                self.timer.invalidate()
                                break
                            case .declined:
                                self.timer.invalidate()
                                break
                            case .no_answer:
                                self.dismiss(animated: true, completion: nil)
                                self.timer.invalidate()
                                break
                            case .calling:
                                break
                            case .unknown:
                                break
                            }
                        }
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
            })
        })
    }
    
    private func twilloCheckForAction(callID: Int, callType: String) {
        let userId = AppInstance.instance._userId
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            TwilloCallmanager.instance.checkForTwilloCall(user_id: userId, session_Token: sessionID, call_id: callID, call_Type: callType, completionBlock: { (result) in
                
                switch result {
                case .success(let model):
                    Async.main({
                        self.dismissProgressDialog {
                            switch model._callStatusObject {
                            case .answered:
                                self.timer.invalidate()
                                break
                            case .calling:
                                break
                            case .declined:
                                self.dismiss(animated: true, completion: nil)
                                self.timer.invalidate()
                                break
                            case .no_answer:
                                break
                            }
                            
//                            if model.callStatus == 400 {
//                                self.dismiss(animated: true, completion: nil)
//                                self.timer.invalidate()
//
//                            }else if model.callStatus == 200 {
//                                self.timer.invalidate()
//
//                            }else if model.callStatus == 300 {
//                            }
                        }
                    })
                    break
                    
                case .failure(let error):
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error.localizedDescription)
                        }
                    })
                    break
                }
                
//                if success != nil {
//                    Async.main({
//                        self.dismissProgressDialog {
////                            log.debug("userList = \(success?.callStatus ?? nil)")
//
//                            if success?.callStatus == 400{
//                                self.dismiss(animated: true, completion: nil)
//                                self.timer.invalidate()
//                                log.verbose("Call Has Been Declined")
//                            }else if success?.callStatus == 200{
//                                log.verbose("Call Has Been Answered")
//                                self.timer.invalidate()
//                            }else if  success?.callStatus == 300{
//                                log.verbose("Calling")
//                            }
//                        }
//                    })
//                }else if sessionError != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(sessionError?.errors?.errorText)
////                            log.error("sessionError = \(sessionError?.errors?.errorText)")
//
//                        }
//                    })
//                }else if serverError != nil{
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(serverError?.errors?.errorText)
////                            log.error("serverError = \(serverError?.errors?.errorText)")
//                        }
//                    })
//
//                }else {
//                    Async.main({
//                        self.dismissProgressDialog {
//                            self.view.makeToast(error?.localizedDescription)
////                            log.error("error = \(error?.localizedDescription)")
//                        }
//                    })
//                }
            })
        })
    }
    
    @objc func update() {
        if self.callingStatus == "agora" {
            self.agoraCheckForAction(callID: self.callId)
        }else {
            self.twilloCheckForAction(callID: self.callId, callType:  self.callType)
        }
    }
    
    private func blockUser(userId: String) {
        //
        let sessionToken = AppInstance.instance._sessionId
        
        Async.background({
            BlockUsersManager.instanc.blockUnblockUser(session_Token: sessionToken, blockTo_userId: userId, block_Action: "block", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil {
                    Async.main({
                        self.dismissProgressDialog {
//                            log.debug("userList = \(success?.blockStatus ?? "")")
                            self.view.makeToast(NSLocalizedString("User has been blocked!!", comment: "User has been blocked!!"))
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                    
                }else if sessionError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
//                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            
                        }
                    })
                    
                }else if serverError != nil {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
//                            log.error("serverError = \(serverError?.errors?.errorText)")
                        }
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
//                            log.error("error = \(error?.localizedDescription)")
                        }
                    })
                }
            })
        })
    }
    
    private func deleteChat(UserID:String){
        //
        let sessionID = AppInstance.instance._sessionId
        
        Async.background({
            BotttomSiteUserList.instance.deleteChat(user_id: UserID, session_Token: sessionID, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.message ?? "")")
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
//                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
//                            log.error("serverError = \(serverError?.errors?.errorText)")
                        }
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
//                            log.error("error = \(error?.localizedDescription)")
                        }
                    })
                }
            })
        })
    }
    
    func convertDate(Unix:Double) -> Date {
        let timestamp = Unix
        
        var dateFromTimeStamp = Date(timeIntervalSinceNow: timestamp as! TimeInterval / 1000)
        return dateFromTimeStamp
    }
    
    private func showControls(Index: Int) {
        let model = self.array[Index]
        let object = model.getChatUsers().first
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let viewProfile = UIAlertAction(title: NSLocalizedString("View Profile", comment: "View Profile"), style: .default) { (action) in
//            log.verbose("view profile")
            let vc = R.storyboard.chat.viewProfileVC()
            vc?.profileId = object?._user_id ?? ""
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        let block = UIAlertAction(title: NSLocalizedString("Block", comment: "Block"), style: .default) { (action) in
//            log.verbose("message Info")
            self.blockUser(userId: object?._user_id ?? "")
        }
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .destructive, handler: nil)
        alert.addAction(viewProfile)
        alert.addAction(block)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}

