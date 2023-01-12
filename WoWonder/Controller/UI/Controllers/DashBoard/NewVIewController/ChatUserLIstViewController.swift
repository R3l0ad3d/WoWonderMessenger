//
//  ChatUserLIstViewController.swift
//  WoWonder
//
//  Created by UnikaApp on 12/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Async
import Alamofire
import SwiftEventBus
import WowonderMessengerSDK
import GoogleMobileAds
import FBAudienceNetwork
import Kingfisher

class ChatUserLIstViewController: BaseVC {
    
    //MARK: - All IBOutlet This ViewController
    @IBOutlet weak var navigactionView: UIView!
    @IBOutlet weak var locationButton: UIControl!
    @IBOutlet weak var profilrButton: UIControl!
    @IBOutlet weak var moduleVIew: UIView!
    @IBOutlet weak var searchButton: UIControl!
    @IBOutlet weak var groupButton: UIControl!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var chatButton: UIControl!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var userChatLIstTableView: UITableView!
    @IBOutlet weak var userChatLIstView: UIView!
    @IBOutlet weak var archivedButton: UIControl!
    @IBOutlet weak var archivedLabel: UILabel!
    @IBOutlet weak var archivedTitleLabel: UILabel!
    @IBOutlet weak var archivedTableVIew: UITableView!
    @IBOutlet weak var archivedView: UIView!
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var archiedImageview: UIImageView!
    @IBOutlet weak var tittleNameLabel: UILabel!
    @IBOutlet weak var imagePin: UIImageView!
    @IBOutlet weak var isEmtyViewArchives: UIView!
    @IBOutlet weak var groupNewImageview: UIImageView!
    //MARK: Varblie's
    
    private var fetchSatus: Bool? = true
    private var requestsGroup = DispatchGroup()
    var refreshControl = UIRefreshControl()
    private var callId: Int = 0
    private var callingStatus: String = ""
    private var callType: String = ""
    private var timer = Timer()
    private var callProvider: CallProvider {
        get {
            return ControlSettings.agoraCall == true && ControlSettings.twilloCall == false ? .agora : .twillo
        }
    }
    var groupfetchSatus:Bool? = true
    var groupChatRequestArray = [GroupRequestModel.GroupChatRequest]()
    var groupsArray = [FetchGroupModel.Datum]()
    var groupsArrayMessage: [GroupChatModel.DataClass] = []
    var userListArray: [UserModel] = []
    var saveDataArray: [Chats] = []
    var archive: [ArchivedModel.ArchivedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SocketHelper.shared.connectSocket { (success) in
            print("success ==> \(success)")
        }
        
        self.archiedImageview.image = UIImage(named: "ic_Archive")?.withRenderingMode(.alwaysTemplate)
        self.archiedImageview.tintColor = UIColor.mainColor
        self.moduleVIew.backgroundColor = UIColor.bgMain
        self.setUpScreenUI()
        self.fetchData()
        self.groupViewFetchData()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.addTarget(self, action: #selector(self.groupsrefresh(_:)), for: .valueChanged)
        userChatLIstTableView.addSubview(refreshControl)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chatUserListClick))
        self.userChatLIstTableView.addGestureRecognizer(longPressRecognizer)
        
        let grouplongPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GroupListLongClick))
        self.groupTableView.addGestureRecognizer(grouplongPressRecognizer)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setUpScreenUI()
    }
    
    //MARK: - setUpScreenUi
    private func setUpScreenUI() {
        
        //SetupScreen ImageView
        let profileImageURL = URL.init(string:AppInstance.instance.userProfile?.avatar ?? "")
        self.profileImageView.kf.indicatorType = .activity
        self.profileImageView.kf.setImage(with: profileImageURL, placeholder: UIImage(named: ""))
        self.groupNewImageview.backgroundColor = UIColor.mainColor
        
        let XIB = UINib(nibName: "UserListChatCell", bundle: nil)
        self.userChatLIstTableView.register(XIB, forCellReuseIdentifier: "UserListChatCell")
        
        let archivedXIB = UINib(nibName: "UserListChatCell", bundle: nil)
        self.archivedTableVIew.register(archivedXIB, forCellReuseIdentifier: "UserListChatCell")
        
        let groupXIB = UINib(nibName: "UserListChatCell", bundle: nil)
        self.groupTableView.register(groupXIB, forCellReuseIdentifier: "UserListChatCell")
        self.userChatLIstTableView.isHidden = false
        self.userChatLIstView.isHidden = false
        self.groupView.isHidden = true
        self.groupTableView.isHidden = true
        self.archivedView.isHidden = true
        self.archivedTableVIew.isHidden = true
        self.archivedButton.backgroundColor = UIColor.clear
        self.archivedLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
        self.groupButton.backgroundColor = UIColor.clear
        self.groupLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
        self.chatButton.backgroundColor = UIColor.mainColor
        self.chatLabel.textColor = UIColor.white
        self.tittleNameLabel.textColor = UIColor.mainColor
   
//        imagePin.originalImage.imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
//        imagePin.image = templateImage
//        imagePin.tintColor = UIColor.mainColor
        
        imagePin.image = UIImage(named: "ic_New_locationpin")?.withRenderingMode(.alwaysTemplate)
        imagePin.tintColor = UIColor.mainColor


    }
    
    @objc func chatUserListClick(sender: UILongPressGestureRecognizer) {
        let objSender = sender.location(in: self.userChatLIstTableView)
        let bottomsite = ChatUserListBottomVC.initialize(from: .dashboard)
        let indexPath = self.userChatLIstTableView.indexPathForRow(at: objSender)
        let model = self.userListArray[indexPath?.row ?? 0]
        bottomsite.recipientID = model._userID
        bottomsite.chatUser = model
        bottomsite.delegate = self
        bottomsite.indexpath = indexPath ?? IndexPath()
        self.present(bottomsite, animated: true)
        
    }
    
    @objc func GroupListLongClick(sender: UILongPressGestureRecognizer) {
        let objSender = sender.location(in: self.groupTableView)
        let bottomsite = GroupListBottomViewController.initialize(from: .dashboard)
        let indexPath = self.groupTableView.indexPathForRow(at: objSender)
        let model = self.groupsArray[indexPath?.row ?? 0]
        bottomsite.indexPath = indexPath ?? IndexPath()
        bottomsite.groupID = model.groupID ?? ""
        bottomsite.modalPresentationStyle = .overCurrentContext
        bottomsite.delegate = self
        self.navigationController?.present(bottomsite, animated: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        self.fetchData()
    }
    
    @objc func groupsrefresh(_ sender: AnyObject) {
        // Code to refresh table view
        self.groupsArrayMessage.removeAll()
        self.groupViewFetchData()
        self.groupViewFetchData()
        
    }
    
        private func fetchData() {
            let chats = Chats.getChats()
            if !chats.isEmpty {
                self.userListArray.removeAll()
                self.saveDataArray = chats
                self.userChatLIstTableView.reloadData()
                self.getUserList { [weak self] (response) in
                    guard let self = self else { return }
                    guard let list = response.data else { return }
    
                    for user in list {
                        if let chatUser = ChatUsers.getChatUserByUserID(user._userID) {
                            chatUser.updateUser(user)
                        } else {
                            let localChat = Chats(user: user)
                            localChat.save()
                            self.saveDataArray.append(localChat)
                        }
                    }
                    self.refreshControl.endRefreshing()
                    self.userChatLIstTableView.reloadData()
                }
            } else {
                self.getUserList { model in
                    Async.main({
                        self.dismissProgressDialog {
                            guard let data = model.data else { return }
                            self.userListArray.removeAll()
                            for item in data {
                                if let chat = Chats.getChatByUserID(item._userID) {
                                    self.saveDataArray.append(chat)
                                } else {
                                    let chat = Chats(user: item)
                                    chat.save()
                                    self.saveDataArray.append(chat)
                                }
                            }
                            self.userChatLIstTableView.reloadData()
                            self.refreshControl.endRefreshing()
                        }
                    })
                }
            }
        }
    
//    MARK: - GetUserList
        func getUserList(_ completion: @escaping (UserModelResponse) -> Void) {
            let userID = AppInstance.instance._userId
    
            if fetchSatus! {
                fetchSatus = false
                //
            }else {
            }
    
            Async.background({
    
                self.requestsGroup.enter()
                GetUserListManager.instance.getUserList(user_id: userID,
                                                        session_Token: AppInstance.instance._sessionId) { result in
    
                    switch result {
                    case .success(let model):
    
                        print("Model => \(model)")
                        self.userListArray = model.data ?? []
                        self.dismissProgressDialog {
                            completion(model)
    
                            guard let agoraCall = model.agoraCall else { return }
                            guard let videoCall = model.videoCall else { return }
                            guard let audioCall = model.audioCall else { return }
    
                            self.callId = Int(model.agoraCallData?.data?._id ?? "") ?? 0
                            let roomName = model.agoraCallData?.data?._roomName ?? ""
                            let accessToken = model.agoraCallData?.data?._accessToken ?? ""
    
                            switch self.callProvider {
                            case .agora:
                                if videoCall == true {
                                    print("Vidoecall")
                                } else {
                                    if agoraCall == true {
                                        self.callingStatus = "agora"
                                        let vc = R.storyboard.call.agoraCallVC()
                                        vc?.usernameString = model.agoraCallData?._name
                                        vc?.profileImageUrlString = model.agoraCallData?._avatar
                                        vc?.callDirection = .incoming
                                        vc?.callId = self.callId
                                        vc?.roomName = roomName
                                        vc?.callToken = accessToken
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                    }
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
                                } else if audioCall == true {
    
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
                                } else {
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
    
    
//    func fecthUserListData() {
//        guard let userId = AppInstance.instance.userId else { return }
//        guard let sessionToken = AppInstance.instance.sessionId else { return }
//        GetUserListManager.instance.getUserList(user_id: userId,
//                                                session_Token: sessionToken) { result in
//            switch result {
//
//            case .success(let data):
//                self.refreshControl.endRefreshing()
//                self.userListArray = data.data ?? []
//                guard let agoraCall = data.agoraCall else { return }
//                guard let videoCall = data.videoCall else { return }
//                guard let audioCall = data.audioCall else { return }
//
//                self.callId = Int(data.agoraCallData?.data?._id ?? "") ?? 0
//                let roomName = data.agoraCallData?.data?._roomName ?? ""
//                let accessToken = data.agoraCallData?.data?._accessToken ?? ""
//
//                switch self.callProvider {
//                case .agora:
//                    if videoCall == true {
//                        print("Vidoecall")
//                    } else {
//                        if agoraCall == true {
//                            self.callingStatus = "agora"
//                            let vc = R.storyboard.call.agoraCallVC()
//                            vc?.usernameString = data.agoraCallData?._name
//                            vc?.profileImageUrlString = data.agoraCallData?._avatar
//                            vc?.callDirection = .incoming
//                            vc?.callId = self.callId
//                            vc?.roomName = roomName
//                            vc?.callToken = accessToken
//                            self.navigationController?.pushViewController(vc!, animated: true)
//                        }
//                    }
//                    break
//
//                case .twillo:
//                    self.callingStatus = "twillo"
//
//                    if videoCall == true {
//                        self.callType = "video"
//
//                        self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                          target: self,
//                                                          selector: #selector(self.update),
//                                                          userInfo: nil,
//                                                          repeats: true)
//                    } else if audioCall == true {
//
//                        self.callType = "audio"
//                        self.timer = Timer.scheduledTimer(timeInterval: 0.6,
//                                                          target: self,
//                                                          selector: #selector(self.update),
//                                                          userInfo: nil,
//                                                          repeats: true)
//
//                        let vc = R.storyboard.call.agoraCallVC()
//                        vc?.usernameString = data.agoraCallData?._name
//                        vc?.profileImageUrlString = data.agoraCallData?._avatar
//                        vc?.callDirection = .incoming
//                        self.present(vc!, animated: true)
//                    } else {
//                    }
//                    break
//                }
//                self.userChatLIstTableView.reloadData()
//                break
//
//            case .failure(let error):
//                self.view.makeToast(error.localizedDescription)
//                break
//            }
//        }
//    }
    
    //MARK: - Update
    @objc func update() {
        if self.callingStatus == "agora" {
            self.agoraCheckForAction(callID: self.callId)
        }else {
            self.twilloCheckForAction(callID: self.callId, callType:  self.callType)
        }
    }
    
    //MARK: - twilloCheckForAction
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
    
    
    private func getArchivedChats() {
//        ArchivedManager.instance.getArchivedChats(session_Token: AppInstance.instance._sessionId, completionBlock: <#(ArchivedModel?, Error?) -> ()#>)
        ArchivedManager.instance.getArchivedChats(session_Token: AppInstance.instance._sessionId) { response, error in
            if response?.api_status == 200 {
                self.archive = response?.data ?? []
                if self.archive.isEmpty {
                    self.isEmtyViewArchives.isHidden = false
                    self.archivedTableVIew.reloadData()
                } else {
                    self.isEmtyViewArchives.isHidden = true
                    self.archivedTableVIew.reloadData()
                }
            } else {
                print("error => \(error?.localizedDescription)")
            }
        }
    }
    
    //MARK: - AgoraCheckForAction
    private func agoraCheckForAction(callID: Int) {
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
    
    //MARK: - All IBAction This ViewController
    @IBAction func archivedButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.getArchivedChats()
        self.userChatLIstTableView.isHidden = true
        self.userChatLIstView.isHidden = true
        self.groupView.isHidden = true
        self.groupTableView.isHidden = true
        self.archivedView.isHidden = false
        self.archivedTableVIew.isHidden = false
        self.archivedButton.backgroundColor = UIColor.mainColor
        self.archivedLabel.textColor = UIColor.white
        self.groupButton.backgroundColor = UIColor.clear
        self.groupLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
        self.chatButton.backgroundColor = UIColor.clear
        self.chatLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
    }
    
    @IBAction func createGroupButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        
        let vc = CreateGroupViewController.initialize(from: .group)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func groupButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.userChatLIstTableView.isHidden = true
        self.userChatLIstView.isHidden = true
        self.groupView.isHidden = false
        self.groupTableView.isHidden = false
        self.archivedView.isHidden = true
        self.archivedTableVIew.isHidden = true
        self.archivedButton.backgroundColor = UIColor.clear
        self.archivedLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
        self.groupButton.backgroundColor = UIColor.mainColor
        self.groupLabel.textColor = UIColor.white
        self.chatButton.backgroundColor = UIColor.clear
        self.chatLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
    }
    
    @IBAction func chatButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.userChatLIstTableView.isHidden = false
        self.userChatLIstView.isHidden = false
        self.groupView.isHidden = true
        self.groupTableView.isHidden = true
        self.archivedView.isHidden = true
        self.archivedTableVIew.isHidden = true
        self.archivedButton.backgroundColor = UIColor.clear
        self.archivedLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
        self.groupButton.backgroundColor = UIColor.clear
        self.groupLabel.textColor = UIColor(red: 0.383, green: 0.383, blue: 0.383, alpha: 1)
        self.chatButton.backgroundColor = UIColor.mainColor
        self.chatLabel.textColor = UIColor.white
    }
    
    @IBAction func searchButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let vc = R.storyboard.dashboard.searchRandomVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func profileButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let VC = RequestViewController.initialize(from: .dashboard)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func locationButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let finedFrined = FindFriendsViewController.initialize(from: .dashboard)
        finedFrined.fetchData(status: "all",
                              gender: "all",
                              distace: "1",
                              relationships: "all")
        self.navigationController?.pushViewController(finedFrined, animated: true)
    }
}

//MARK: - UITableViewDelegate & DataSource Method's
extension ChatUserLIstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userChatLIstTableView == tableView {
            return self.saveDataArray.count
            
        } else if archivedTableVIew == tableView {
            return archive.count
            
        } else if groupTableView == tableView {
            return groupsArrayMessage.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userChatLIstTableView == tableView {
            let cell = userChatLIstTableView.dequeueReusableCell(withIdentifier: "UserListChatCell") as? UserListChatCell
            self.UserListChatDatSave(cell: cell, indexPathForCell: indexPath)
            return cell ?? UITableViewCell()
            
        } else if archivedTableVIew == tableView {
            let cell = archivedTableVIew.dequeueReusableCell(withIdentifier: "UserListChatCell") as? UserListChatCell
            return cell ?? UITableViewCell()
            
        } else if groupTableView == tableView {
            let cell = groupTableView.dequeueReusableCell(withIdentifier: "UserListChatCell") as? UserListChatCell
            self.groupsTableViewSetData(cell: cell, IndexPathForCell: indexPath)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    func archiveDataset(cell: UserListChatCell?, indexPathForCell: IndexPath) {
        let UserData = archive[indexPathForCell.count]
        let url = URL(string: UserData.avatar ?? "")
        cell?.userimageView.kf.indicatorType = .activity
        cell?.userimageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        cell?.timelabel.text = setTimestamp(epochTime: (UserData.lastseen_unix_time ?? ""))
        cell?.countView.isHidden = false
        cell?.onlineImageView.isHidden = false
        cell?.countLabel.text = UserData.message_count
        cell?.userNameLabel.text = UserData.name
        
        if UserData.mute?.notify == "yes" {
            cell?.muteImageVIew.isHidden = false
        } else {
            cell?.muteImageVIew.isHidden = true
        }
        
        if UserData.mute?.pin == "yes" {
            cell?.pinmasage.isHidden = false
            cell?.pinmasageWith.constant = 20
            
            guard let firstVisibleIndexPath = userChatLIstTableView.indexPathsForVisibleRows?.first else { return }
            self.userChatLIstTableView.moveRow(at: indexPathForCell, to: firstVisibleIndexPath)
            
        } else {
            cell?.muteImageVIew.isHidden = true
            cell?.pinmasageWith.constant = 0
        }                
        
        if UserData.message_count == "0" {
            cell?.countLabel.isHidden = true
            cell?.countView.isHidden = true
            cell?.isLastSeenImage.isHidden = false
            cell?.isLastSeenImage.image = UIImage(named: "ic_not_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.isLastSeenImage.tintColor = UIColor.mainColor
            
        } else if UserData.message_count == "1" {
            cell?.countLabel.isHidden = true
            cell?.countView.isHidden = true
            cell?.isLastSeenImage.isHidden = false
            cell?.isLastSeenImage.image = UIImage(named: "ic_seen")?.withRenderingMode(.alwaysTemplate)
            cell?.isLastSeenImage.tintColor = UIColor.mainColor
            
        } else {
            cell?.isLastSeenImage.isHidden = true
            cell?.countLabel.isHidden = false
            cell?.countView.isHidden = false
            cell?.countView.backgroundColor = UIColor.mainColor
            cell?.countLabel.text = UserData.message_count
        }
        
        let lastmeddageTyep = UserData.last_message?.type ?? ""
        
        if lastmeddageTyep == "left_text" {
            cell?.lastMassageLabel.text = "Text"
            cell?.withLayoutConstraintimage.constant = 0
            cell?.lastMessageIcone.isHidden = true
            cell?.lastMessageIcone.image = UIImage(named: "")
            
            
        } else if lastmeddageTyep == "right_text" {
            cell?.withLayoutConstraintimage.constant = 0
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Text"
            cell?.lastMessageIcone.image = UIImage(named: "")
            
        } else if lastmeddageTyep == "right_contact" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Contact Number"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_phone")
            
        } else if lastmeddageTyep == "left_contact" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Contact Number"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_phone")
            
        } else if lastmeddageTyep == "right_Gif" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Gif"
            cell?.lastMessageIcone.image = UIImage(named: "ic_gift_last")
            
        }  else if lastmeddageTyep == "Left_Gif" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Gif"
            cell?.lastMessageIcone.image = UIImage(named: "ic_gift_last")
            
        } else if lastmeddageTyep == "left_audio" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Audio"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_mic")
            
        } else if lastmeddageTyep == "right_audio" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Audio"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_mic")
            
        } else if lastmeddageTyep == "left_Video" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Video"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Vidoe")
            
        } else if lastmeddageTyep == "right_video" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Video"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Vidoe")
            
        } else if lastmeddageTyep == "left_image" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Image"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_image")
            
        } else if lastmeddageTyep == "right_image" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Image"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_image")
            
        } else if lastmeddageTyep == "right_file" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "File"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_document")
            
        } else if lastmeddageTyep == "left_file" {
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "File"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_document")
        }
        
        if UserData.lastseen_status == "off" {
            cell?.onlineImageView.isHidden = true
            cell?.stutesView.isHidden = true
        } else {
            cell?.onlineImageView.isHidden = false
            cell?.stutesView.isHidden = false
        }
        
    }
    //MARK: UserListChatDatSave
    func UserListChatDatSave(cell: UserListChatCell?, indexPathForCell: IndexPath) {
        let objarray = saveDataArray[indexPathForCell.row]
        guard let object = objarray.getChatUsers().first?.user else { return }
        let url = URL(string: object._avatar_url)
        cell?.userimageView.kf.indicatorType = .activity
        cell?.userimageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_No_images"))
        
        cell?.timelabel.text = setTimestamp(epochTime: (object._last_seen))
        cell?.countView.isHidden = false
        cell?.onlineImageView.isHidden = false
        cell?.countLabel.text = object.message_count
        cell?.userNameLabel.text = objarray._name
        
        let lastmeddageTyep = objarray.getMessages().last?.type ?? ""
        
        if object.message_count == "0" {
            cell?.countLabel.isHidden = true
            cell?.countView.isHidden = true
            cell?.isLastSeenImage.isHidden = false
            cell?.isLastSeenImage.image = UIImage(named: "ic_seen")
            
        } else if object.message_count == "1" {
            cell?.countLabel.isHidden = true
            cell?.countView.isHidden = true
            cell?.isLastSeenImage.isHidden = false
            cell?.isLastSeenImage.image = UIImage(named: "ic_not_seen")
            
        } else {
            cell?.isLastSeenImage.isHidden = true
            cell?.countLabel.isHidden = false
            cell?.countView.isHidden = false
            cell?.countView.backgroundColor = UIColor(hex: "C83747")
            cell?.countLabel.text = object.message_count ?? ""
        }
        
        
        if lastmeddageTyep == "left_text" {
            cell?.lastMassageLabel.text = "Text"
            cell?.lastMessageIcone.isHidden = true
            cell?.lastMessageIcone.image = UIImage(named: "")
            
        } else if lastmeddageTyep == "right_text" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Text"
            cell?.lastMessageIcone.image = UIImage(named: "")
            
        } else if lastmeddageTyep == "right_contact" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Contact Number"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_phone")
            
        } else if lastmeddageTyep == "left_contact" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Contact Number"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_phone")
            
        } else if lastmeddageTyep == "right_Gif" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Gif"
            cell?.lastMessageIcone.image = UIImage(named: "ic_gift_last")
            
        }  else if lastmeddageTyep == "Left_Gif" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Gif"
            cell?.lastMessageIcone.image = UIImage(named: "ic_gift_last")
            
        } else if lastmeddageTyep == "left_audio" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Audio"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_mic")
            
        } else if lastmeddageTyep == "right_audio" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Audio"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_mic")
            
        } else if lastmeddageTyep == "left_Video" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Video"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Vidoe")
            
        } else if lastmeddageTyep == "right_video" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Video"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Vidoe")
            
        } else if lastmeddageTyep == "left_image" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Image"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_image")
            
        } else if lastmeddageTyep == "right_image" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Image"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_image")
            
        } else if lastmeddageTyep == "right_file" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "File"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_document")
            
        } else if lastmeddageTyep == "left_file" {
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "File"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_document")
        }
        
        if object.last_seen_status == "off" {
            cell?.onlineImageView.isHidden = true
            cell?.stutesView.isHidden = true
        } else {
            cell?.onlineImageView.isHidden = false
            cell?.stutesView.isHidden = false
        }
        
        if object.user_mute?.pin == "1" {
            cell?.pinmasage.isHidden = false
        } else {
            cell?.pinmasage.isHidden = true
        }
        
        if object.user_mute?.notify == "1" {
            cell?.muteImageVIew.isHidden = false
        } else {
            cell?.muteImageVIew.isHidden = true
        }
    }
    
    //MARK: groups Chat List
    func groupsTableViewSetData(cell: UserListChatCell?, IndexPathForCell: IndexPath) {
        let objectGroups = self.groupsArrayMessage[IndexPathForCell.row]
        let url = URL(string: objectGroups.avatar ?? "")
        cell?.userimageView.kf.indicatorType = .activity
        cell?.userimageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        cell?.timelabel.text = setTimestamp(epochTime: (objectGroups.time ?? ""))
        cell?.onlineImageView.isHidden = true
        cell?.userNameLabel.text = objectGroups.groupName
        cell?.stutesView.isHidden = true
        
        cell?.muteImageVIew.isHidden = true
        cell?.pinmasage.isHidden = true
        
        let type = objectGroups.messages?.last?.type
        switch type {
        case "left_text":
            cell?.withLayoutConstraintimage.constant = 0
            cell?.lastMassageLabel.text = "Text"
            cell?.lastMessageIcone.isHidden = true
            cell?.lastMessageIcone.image = UIImage(named: "")
            
        case "right_text":
            cell?.withLayoutConstraintimage.constant = 0
            cell?.lastMassageLabel.text = "Text"
            cell?.lastMessageIcone.isHidden = true
            cell?.lastMessageIcone.image = UIImage(named: "")
            
        case "right_image":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Image"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_image")
            
        case "left_Image":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Image"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_image")
            
        case "left_Video":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Video"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Vidoe")
            
        case "right_video":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Video"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Vidoe")
            
        case "right_Gif":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Gif"
            cell?.lastMessageIcone.image = UIImage(named: "ic_gift_last")
            
        case "left_Gif":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Gif"
            cell?.lastMessageIcone.image = UIImage(named: "ic_gift_last")
            
        case "left_contact":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Contact Number"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_phone")
            
        case "right_contact":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Contact Number"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_phone")
            
        case "right_file":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "File"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_document")
            
        case "left_file":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "File"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_document")
            
        case "left_audio":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Audio"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_mic")
            
        case "right_audio":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Audio"
            cell?.lastMessageIcone.image = UIImage(named: "ic_last_mic")
            
        case "right_map":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Location"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Location")
            
        case "left_map":
            cell?.withLayoutConstraintimage.constant = 18
            cell?.lastMessageIcone.isHidden = false
            cell?.lastMassageLabel.text = "Location"
            cell?.lastMessageIcone.image = UIImage(named: "ic_Last_Location")
            
        default:
            break
        }
    }
    
    //MARK: didSelectRowAt TableView Method's
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userChatLIstTableView == tableView {
            let model = self.saveDataArray[indexPath.row]
            guard let object = model.getChatUsers().first else { return }
            AppInstance.instance.addCount = AppInstance.instance.addCount! + 1
            let vc = ChatViewController.initialize(from: .chat)
            vc.recipientID = object._user_id
            vc.chatModel = model
            vc.toUserID = object.user_id ?? ""
            vc.object_LatSeen = object.user?._last_seen_status ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if archivedTableVIew == tableView {
            
        } else if groupTableView == tableView {
            self.groupTableView.deselectRow(at: indexPath, animated: true)
            let objectGroups = self.groupsArrayMessage[indexPath.row]
            let groupcahatVC = ChatGroupViewController.initialize(from: .group)
            groupcahatVC.groupsArray = groupsArray
            groupcahatVC.isProfileImage = objectGroups.avatar ?? ""
            groupcahatVC.isGroupName = objectGroups.groupName ?? ""
            groupcahatVC.groupId = self.groupsArrayMessage[indexPath.row].groupID ?? ""
            self.navigationController?.pushViewController(groupcahatVC, animated: true)
        }
    }
}

extension ChatUserLIstViewController: SearchDelegate {
    func filterSearch(gender: String, countryId: String, ageTo: String, ageFrom: String, verified: String, status: String, profilePic: String, filterByAge: String) {
        print("gender => \(gender)")
        print("countryId ==> \(countryId)")
        print("ageTo => \(ageTo)")
        print("ageFrom ==> \(ageFrom)")
        print("verified => \(verified)")
        print("status ==> \(status)")
        print("profilePic => \(profilePic)")
        print("filterByAge ==> \(filterByAge)")
    }
    
    func locationSearch(location: String, countryId: String) {
        print("location => \(location)")
        print("countryId ==> \(countryId)")
    }
}
