//
//  AddParticipantsListViewController.swift
//  WoWonder
//
//  Created by Mac on 16/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async

protocol didSelectParticipantDelegate {
    func selectParticipant(Image:UIButton,status:Bool,idsArray:[AddParticipantModel],Index:Int)
}

class AddParticipantsListViewController: BaseVC {

    @IBOutlet weak var pepoleListTableView: UITableView!
    @IBOutlet weak var groupAddPeopleCountLabel: UILabel!
    
    private var followingsArray = [FollowingModel.Following]()
    private var participantsArray = [AddParticipantModel]()
    private var idsArray = [Int]()
    private var idsString = ""
    var delegate:participantsCollectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpScreeen()
        self.fetchData()
    }
    
    func setUpScreeen() {
        self.pepoleListTableView.register( UINib(nibName: R.reuseIdentifier.addParticipants_TableCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.addParticipants_TableCell.identifier)       
    }
    
    private func fetchData(){
        self.followingsArray.removeAll()
        self.pepoleListTableView.reloadData()
        //
        Async.background({
            FollowingManager.instance.getFollowings(user_id: AppInstance.instance.userId ?? "", session_Token: AppInstance.instance.sessionId ?? "", fetch_type: "following") { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.following ?? nil)")
                            if (success?.following?.isEmpty)!{
                                self.pepoleListTableView.isHidden = true
                            }else {
                                self.pepoleListTableView.isHidden = false
                                self.followingsArray = success?.following ?? []
                                self.pepoleListTableView.reloadData()
                            }
                            
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
    
}

//MARK: - TableVeiew Delegate and DataSorece Method's
extension AddParticipantsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followingsArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.addParticipants_TableCell.identifier) as? AddParticipants_TableCell
        self.setTableVIewData(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func setTableVIewData(cell: AddParticipants_TableCell?, indexPath: IndexPath) {
        cell?.indexPath = indexPath.row
        cell?.delegate = self
        cell?.userArray = self.followingsArray
        cell?.checkBtn.tintColor = .ButtonColor
        cell?.checkBtn.setImage(UIImage(named: "ic_uncheckgey")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        let object = followingsArray[indexPath.row]
        cell?.usernameLabel.text = object.name ?? ""
        cell?.timeLabel.text = ControlSettings.WoWonderText
        
        let url = URL.init(string:object.avatar ?? "")
        cell?.profileImage.kf.indicatorType = .activity
        cell?.profileImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        cell?.profileImage.cornerRadiusV = (cell?.profileImage.frame.height)! / 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72;
    }
    
}

extension AddParticipantsListViewController: didSelectParticipantDelegate{
    func selectParticipant(Image: UIButton, status: Bool, idsArray: [AddParticipantModel], Index: Int) {
        if status{
            Image.setImage(R.image.ic_checkRed()?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.idsArray.append(idsArray[Index].id ?? 0)
            log.verbose("genresIdArray = \(self.idsArray)")
            self.participantsArray.append(idsArray[Index])
            
            let stringArray = self.idsArray.map { String($0) }
            self.idsString = stringArray.joined(separator: ",")
            log.verbose("genresString = \(self.idsString )")
            log.verbose("genresIdArray = \(self.idsArray)")
            self.groupAddPeopleCountLabel.text = "\(participantsArray.count) Selected"
            self.delegate?.selectParticipantsCollection(idsString: self.idsString , participantsArray: participantsArray)
        }else{
            Image.setImage(UIImage(named: "ic_uncheckgey")?.withRenderingMode(.alwaysTemplate), for: .normal)
            for (index,values) in self.idsArray.enumerated(){
                if values == idsArray[Index].id{
                    self.idsArray.remove(at: index)
                    self.participantsArray.remove(at: Index)
                    break
                }
                let stringArray = self.idsArray.map { String($0) }
                self.idsString = stringArray.joined(separator: ",")
                log.verbose("genresString = \(self.idsString)")
                log.verbose("genresIdArray = \(self.idsArray)")
                self.groupAddPeopleCountLabel.text = "\(participantsArray.count) Selected"
                self.delegate?.selectParticipantsCollection(idsString: self.idsString , participantsArray: participantsArray)
            }
        }
    }
}
