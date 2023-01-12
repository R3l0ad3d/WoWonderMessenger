//
//  RequestViewController.swift
//  WoWonder
//
//  Created by UnikApp on 09/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async

class RequestViewController: BaseVC {
    
    @IBOutlet weak var followButtonC: UIControl!
    @IBOutlet weak var groupRequestLabel: UILabel!
    @IBOutlet weak var followRequestLabel: UILabel!
    @IBOutlet weak var groupButton: UIControl!
    @IBOutlet weak var FollowTableView: UITableView!
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var followRequestView: UIView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var lineFollow: UIView!
    @IBOutlet weak var lineGroup: UIView!
    @IBOutlet weak var followNoUseView: UIView!
    @IBOutlet weak var groupNoUseView: UIView!
    
    @IBOutlet weak var groupEmatyImageview: UIImageView!
    //varilble's
    private var friendRequests = [[String : Any]]()
    var groupsArray = [GroupRequestModel.GroupChatRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRequest()
        self.fetchGroupRequest()
        // Do any additional setup after loading the view.
        self.groupView.isHidden = true
        self.followRequestView.isHidden = false
        self.followRequestLabel.textColor = UIColor.primaryButtonColor
        self.groupRequestLabel.textColor = UIColor.black
        self.lineGroup.backgroundColor = .clear
        self.lineFollow.backgroundColor = UIColor.primaryButtonColor
        
        let XIB = UINib(nibName: "RequestCell", bundle: nil)
        self.FollowTableView.register(XIB, forCellReuseIdentifier: "RequestCell")
        
        let groupXIB = UINib(nibName: "RequestCell", bundle: nil)
        self.groupTableView.register(XIB, forCellReuseIdentifier: "RequestCell")
        
        self.groupEmatyImageview.image = UIImage(systemName: "person.3")?.withRenderingMode(.alwaysTemplate)
        self.groupEmatyImageview.tintColor = UIColor.mainColor
    }
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func groupButtonClick(_ sender: UIControl) {
        self.followRequestView.isHidden = true
        self.groupView.isHidden = false
        self.followRequestLabel.textColor = UIColor.black
        self.groupRequestLabel.textColor = UIColor.primaryButtonColor
        self.lineGroup.backgroundColor = UIColor.primaryButtonColor
        self.lineFollow.backgroundColor = .clear
    }
    
    @IBAction func FollowButtonLClick(_ sender: UIControl) {
        self.groupView.isHidden = true
        self.followRequestView.isHidden = false
        self.followRequestLabel.textColor = UIColor.primaryButtonColor
        self.groupRequestLabel.textColor = UIColor.black
        self.lineGroup.backgroundColor = .clear
        self.lineFollow.backgroundColor = UIColor.primaryButtonColor
    }
    
    private func getRequest() {
        if Connectivity.isConnectedToNetwork() {
            Async.main({
                GetFriendRequestManager.sharedInstance.getFriendRequest { (success, authError, error) in
                    if success != nil {
                        for i in success!.friend_requests {
                            self.friendRequests.append(i)
                        }
                        
                        if self.friendRequests.isEmpty{
                            self.FollowTableView.isHidden = true
                            self.followNoUseView.isHidden = false
                        }else{
                            self.followNoUseView.isHidden = true
                            self.FollowTableView.isHidden = false
                        }
                        self.FollowTableView.reloadData()
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
    
    func fetchGroupRequest(){
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GetFriendRequestManager.sharedInstance.fetchGroupRequest(session_Token: sessionToken, fetchType: "group_chat_requests", offset: 1, setOnline: 1) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.groupChatRequests)")
                            self.groupsArray = success?.groupChatRequests ?? []
                            if self.groupsArray.isEmpty{
                                self.groupTableView.isHidden = true
                                self.groupNoUseView.isHidden = false
                            }else{
                                self.groupTableView.isHidden = false
                                self.groupNoUseView.isHidden = true
                            }
                            self.groupTableView.reloadData()
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
                            log.error("serverError = \(serverError?.errors?.errorText)")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(error?.localizedDescription)
                            log.error("error = \(error?.localizedDescription)")
                        }
                    })
                }
            }
        })
    }
    
    private func accept_declineRequest(user_id: String,action:String){
        if Connectivity.isConnectedToNetwork(){
            FollowRequestActionManager.sharedInstance.followRequestAction(user_Id: user_id, action: action) { (success, authError, error) in
                if success != nil {
                    self.view.makeToast(success.debugDescription)
                }
                else if (authError != nil){
                    self.view.makeToast(authError?.errors.errorText)
                }
                else if (error != nil){
                    self.view.makeToast(error?.localizedDescription)
                }
            }
        }
        else{
            self.view.makeToast(NSLocalizedString("Internet Error", comment: "Internet Error"))
        }
    }
    
    private func accceptGroupRequest(type: String, groupID: Int) {
        let sessionToken = AppInstance.instance.sessionId ?? ""
        GetFriendRequestManager.sharedInstance.accceptGroupRequest(session_Token: sessionToken,
                                                                   type: type,
                                                                   groupID: groupID,
                                                                   userid: AppInstance.instance.userId ?? "") { Success, AuthError, ServerKeyError, error in
            if Success != nil {
                self.view.makeToast(Success?.messageData)
                
            } else if (AuthError != nil){
                self.view.makeToast(AuthError?.errors?.errorText)
                
            } else if (ServerKeyError != nil){
                self.view.makeToast(ServerKeyError?.errors?.errorText)
                
            } else if error != nil {
                self.view.makeToast(error.debugDescription)
            }
        }
        
    }
    
    private func rejectGroupRequest(type: String, groupID: Int) {
        GetFriendRequestManager.sharedInstance.rejectGroupRequest(session_Token: AppInstance.instance.sessionId ?? "",
                                                                  type: type,
                                                                  groupID: groupID,
                                                                  userID: AppInstance.instance.userId ?? "") { Success, AuthError, ServerKeyError, error in
            if Success != nil {
                self.view.makeToast(Success?.messageData)
                
            } else if (AuthError != nil){
                self.view.makeToast(AuthError?.errors?.errorText)
                
            } else if (ServerKeyError != nil){
                self.view.makeToast(ServerKeyError?.errors?.errorText)
                
            } else if error != nil {
                self.view.makeToast(error.debugDescription)
            }
        }
        
    }
}

extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == groupTableView {
            return groupsArray.count
        } else {
            return friendRequests.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == groupTableView {
            let cell = groupTableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as? RequestCell
            self.setGroupTableViewData(cell: cell, indexpath: indexPath)
            return cell ?? UITableViewCell()
        } else {
            let cell = FollowTableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as? RequestCell
            self.setFollowRequestDsta(cell: cell, indexpath: indexPath)
            return cell ?? UITableViewCell()
        }
    }
    
    func setFollowRequestDsta(cell: RequestCell?, indexpath: IndexPath) {
        let obj = friendRequests[indexpath.row]
        if let pro_url = obj["avatar"] as? String{
            let url = URL(string: pro_url)
            cell?.userProfileImageview.kf.indicatorType = .activity
            cell?.userProfileImageview.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        if let lastseen = obj["lastseen"] as? String{
            cell?.lastSeenLabel.text = lastseen
        }
        if let userName = obj["name"] as? String{
            cell?.userNamelabel.text = userName
        }
        cell?.accpetButton.tag =  indexpath.row
        cell?.accpetButton.addTarget(self, action: #selector(friendrequestAccpet), for: .touchUpInside)
        
        cell?.cancleButton.tag =  indexpath.row
        cell?.cancleButton.addTarget(self, action: #selector(friendRequestCancle), for: .touchUpInside)
    }
    
    @objc func friendrequestAccpet(_ sender: UIControl) {
        let obj = friendRequests[sender.tag]
        
        let user_Id = obj["user_id"] as? String
        self.accept_declineRequest(user_id: user_Id ?? "", action: "accept")
        self.friendRequests.remove(at: sender.tag)
        self.FollowTableView.reloadData()
        
    }
    
    @objc func friendRequestCancle(_ sender: UIControl) {
        let obj = friendRequests[sender.tag]
        
        let user_Id = obj["user_id"] as? String
        self.accept_declineRequest(user_id: user_Id ?? "", action: "decline")
        self.friendRequests.remove(at: sender.tag)
        self.FollowTableView.reloadData()
    }
    
    
    func setGroupTableViewData(cell: RequestCell?, indexpath: IndexPath) {
        let obj = groupsArray[indexpath.row]
        let URl = URL(string: obj.groupTab?.avatar ?? "")
        cell?.userProfileImageview.kf.indicatorType = .activity
        cell?.userProfileImageview.kf.setImage(with: URl)
        cell?.userNamelabel.text = obj.groupTab?.groupName
        
        cell?.lastSeenLabel.text = obj.groupTab?.timeText
        cell?.accpetButton.tag =  indexpath.row
        cell?.accpetButton.addTarget(self, action: #selector(groupRequestAccpet), for: .touchUpInside)
        
        cell?.cancleButton.tag =  indexpath.row
        cell?.cancleButton.addTarget(self, action: #selector(groupRequestCancle), for: .touchUpInside)
    }
    
    @objc func groupRequestAccpet(_ sender: UIControl) {
        let obj = groupsArray[sender.tag]
        self.acceptRejectGroupRequest(type: "accept", groupID: obj.groupID ?? 0)
        self.groupTableView.reloadData()
        
    }
    
    @objc func groupRequestCancle(_ sender: UIControl) {
        let obj = groupsArray[sender.tag]
        self.acceptRejectGroupRequest(type: "reject", groupID: obj.groupID ?? 0)
        self.FollowTableView.reloadData()
    }
    
    private func acceptRejectGroupRequest(type:String, groupID: Int){
        //        self.vc?.showProgressDialog(text: NSLocalizedString("Loading...", comment: "Loading..."))
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupID = groupID
        Async.background({
            GroupRequestManager.instance.accceptGroupRequest(session_Token: sessionToken, type: type, groupID: groupID) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.fetchGroupRequest()
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors?.errorText)
                        }
                    })
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(serverError?.errors?.errorText)
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
            }
        })
    }
}
