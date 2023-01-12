//
//  GroupInfoViewController.swift
//  WoWonder
//
//  Created by UnikApp on 02/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async
import Kingfisher

class GroupInfoViewController: BaseVC {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupMemberTableView: UITableView!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var exitbutton: UIButton!
    
    var groupImage = ""
    var GroupName = ""
    var groupID = ""
    var window: UIWindow?
    var isBottom = false
    var partsArray = [FetchGroupModel.UserData]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.groupNameLabel.text = GroupName
        let url = URL(string: groupImage)
        self.groupImageView.kf.indicatorType = .activity
        self.groupImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        self.exitbutton.backgroundColor = UIColor.mainColor
        
        
        let XIB = UINib(nibName: "GroupAddParticipantsCell", bundle: nil)
        self.groupMemberTableView.register(XIB, forCellReuseIdentifier: "GroupAddParticipantsCell")
    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func exitGroupButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: NSLocalizedString("Exit Group", comment: "Exit Group"), message: NSLocalizedString("Are you sure you want to Exit Group ?", comment: "Are you sure you want to Exit Group ?"), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
        let logout = UIAlertAction(title: NSLocalizedString("Exit Group", comment: "Exit Group"), style: .destructive) { (action) in
            self.exitGroup()
        }
        alert.addAction(cancel)
        alert.addAction(logout)
        self.present(alert, animated: true, completion: nil)
        
    }
        
    private func exitGroup(){
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupId = groupID
        Async.background({
            GroupChatManager.instance.leaveGroup(group_Id:groupId , session_Token: sessionToken, type: "leave", completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("success = \(success?.apiStatus ?? 0)")
                            self.view.makeToast("you are successfully leaved this group")
                            if self.isBottom == true {
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                self.navigationController?.popViewControllers(viewsToPop: 2)
                            }
                        }
                        
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
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

extension GroupInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupAddParticipantsCell", for: indexPath) as? GroupAddParticipantsCell
        self.setTableViewdata(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func setTableViewdata(cell: GroupAddParticipantsCell?, indexPath: IndexPath) {
        let object = self.partsArray[indexPath.row]
        
        let url = URL.init(string: object.avatar ?? "")
        cell?.userImageView.kf.indicatorType = .activity
        cell?.userImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        cell?.cancleView.isHidden = true
        
        cell?.userNameLabel.text = object.name
        cell?.userSubLabel.text = ControlSettings.WoWonderText
    }
}

