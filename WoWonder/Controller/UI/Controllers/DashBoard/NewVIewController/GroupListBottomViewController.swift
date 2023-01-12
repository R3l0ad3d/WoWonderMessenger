//
//  GroupListBottomViewController.swift
//  WoWonder
//
//  Created by UnikApp on 09/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async

protocol GroupListBottomDelegate {
    func ButtonClickName(name: String, groupID: String, indexPath: IndexPath)
}

class GroupListBottomViewController: UIViewController {
    
    @IBOutlet weak var archiveImgeView: UIImageView!
    @IBOutlet weak var deleteImageview: UIImageView!
    @IBOutlet weak var pinImageview: UIImageView!
    @IBOutlet weak var muteImagview: UIImageView!
    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var infoImagview: UIImageView!
    @IBOutlet weak var exitImageview: UIImageView!
    @IBOutlet weak var ViewProfile: UIImageView!
    
    var delegate: GroupListBottomDelegate?
    var groupID = ""
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteImageview.image = UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate)
        self.deleteImageview.tintColor = UIColor.mainColor
        
        self.pinImageview.image = UIImage(systemName: "pin.fill")?.withRenderingMode(.alwaysTemplate)
        self.pinImageview.tintColor = UIColor.mainColor
        
        self.muteImagview.image = UIImage(named: "ic_Mute_chat")?.withRenderingMode(.alwaysTemplate)
        self.muteImagview.tintColor = UIColor.mainColor
        
        self.archiveImgeView.image = UIImage(named: "ic_Archive")?.withRenderingMode(.alwaysTemplate)
        self.archiveImgeView.tintColor = UIColor.mainColor
        
        self.infoImagview.image = UIImage(systemName: "info.circle.fill")?.withRenderingMode(.alwaysTemplate)
        self.infoImagview.tintColor = UIColor.mainColor
        
        self.exitImageview.image = UIImage(named: "ic_logout_setting")?.withRenderingMode(.alwaysTemplate)
        self.exitImageview.tintColor = UIColor.mainColor
        
        self.ViewProfile.image = UIImage(named: "user_setting")?.withRenderingMode(.alwaysTemplate)
        self.ViewProfile.tintColor = UIColor.mainColor
        
        self.markImageView.image = UIImage(named: "ic_read_chat")?.withRenderingMode(.alwaysTemplate)
        self.markImageView.tintColor = UIColor.mainColor
    }
    
    
    @IBAction func archiveButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "1", groupID: groupID, indexPath: indexPath)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "2", groupID: groupID, indexPath: indexPath)
    }
    
    @IBAction func pinButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "3", groupID: groupID, indexPath: indexPath)
    }
    
    @IBAction func muteButtonButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "4", groupID: groupID, indexPath: indexPath)
        
    }
    
    @IBAction func markChatReadButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "5", groupID: groupID, indexPath: indexPath)
    }
    
    @IBAction func infoButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "6", groupID: groupID, indexPath: indexPath)
    }
    
    @IBAction func buttonClickDown(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func exitButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "7", groupID: groupID, indexPath: indexPath)
    }
    
    @IBAction func addmembersButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.ButtonClickName(name: "6", groupID: groupID, indexPath: indexPath)
    }
    
}

extension ChatUserLIstViewController: GroupListBottomDelegate {
    func ButtonClickName(name: String, groupID: String, indexPath: IndexPath) {
        let Group = groupsArray[indexPath.row]
        switch name {
        case "1":
            self.deleteGroup(groupId: Group.groupID ?? "")
            
        case "2":
            print("2")
            break
            
        case "3":
            print("3")
            break
            
        case "4":
            print("4")
            break
            
        case "5":
            print("5")
            break
            
        case "6":
            let groupInfo = GroupInfoViewController.initialize(from: .group)
            groupInfo.partsArray = Group.parts ?? []
            groupInfo.groupImage = Group.avatar ?? ""
            groupInfo.GroupName = Group.groupName ?? ""
            groupInfo.groupID = Group.groupID ?? ""
            groupInfo.isBottom = true
            self.navigationController?.pushViewController(groupInfo, animated: true)
            break
            
        case "7":
            self.exitGroup(groupID: Group.groupID ?? "")
            break
            
        case "8":
            print("8")
            let updateGroup = UpdateGroupVC.initialize(from: .group)
            updateGroup.partsArray = Group.parts ?? []
            updateGroup.groupID = Group.groupID ?? ""
            updateGroup.groupName = Group.groupName ?? ""
            updateGroup.groupImageString = Group.avatar ?? ""
            self.navigationController?.pushViewController(updateGroup, animated: true)
            break
            
        default:
            break
        }
    }
}

extension ChatUserLIstViewController {
    private func deleteGroup(groupId:String){
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.deleteGroup(group_Id: groupId, session_Token: sessionToken, type: "delete", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("success = \(success?.apiStatus ?? 0)")
                            self.groupViewFetchData()
                        }
                        
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            self.view.makeToast(sessionError?.errors?.errorText ?? "")
                        }
                        
                    })
                    
                    
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                            self.view.makeToast(serverError?.errors?.errorText ?? "")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("error = \(error?.localizedDescription)")
                            self.view.makeToast(error?.localizedDescription ?? "")
                        }
                    })
                }
            })
        })
    }
    
    private func exitGroup(groupID: String){
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            GroupChatManager.instance.leaveGroup(group_Id: groupID , session_Token: sessionToken, type: "leave", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("success = \(success?.apiStatus ?? 0)")
                            self.navigationController?.popViewControllers(viewsToPop: 2)
                        }
                        
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("sessionError = \(sessionError?.errors?.errorText)")
                            self.view.makeToast(sessionError?.errors?.errorText ?? "")
                        }
                        
                    })
                    
                    
                }else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                            self.view.makeToast(serverError?.errors?.errorText ?? "")
                        }
                        
                    })
                    
                }else {
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("error = \(error?.localizedDescription)")
                            self.view.makeToast(error?.localizedDescription ?? "")
                        }
                        
                    })
                    
                }
            })
        })
    }
}
