//
//  FindFriendsViewController.swift
//  WoWonder
//
//  Created by UnikApp on 05/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async

class FindFriendsViewController: BaseVC {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var emtyView: UIView!
    @IBOutlet weak var fiterView: UIControl!
    
    private var userArray = [SearchModel.User]()
    private var color = UIColor.primaryButtonColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let XIB = UINib(nibName: "FindFriendsCell", bundle: nil)
        self.userCollectionView.register(XIB, forCellWithReuseIdentifier: "FindFriendsCell")
        self.emtyView.isHidden = true
        self.fiterView.backgroundColor = UIColor.mainColor
        self.emtyView.isHidden = true

    }
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonClick(_ sender: UIControl) {
        let vc = R.storyboard.dashboard.searchFilterVC()
        vc?.filterSearch = self
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true, completion: nil)
    }
    
    //MARK: - fetchData User List
    func fetchData(status:String,
                   gender: String,
                   distace: String,
                   relationships:String) {
        self.userArray.removeAll()
        let sessionToken = AppInstance.instance.sessionId ?? ""
        self.showProgressDialog(text: "loading..")
        SearchManager.instance.searchUserByFilter(session_Token: sessionToken,
                                                  status: status,
                                                  distance: distace,
                                                  gender: gender,
                                                  relationships: relationships) {(success, sessionError, serverError, error) in
            if success != nil{
                Async.main({
                    self.dismissProgressDialog {
                        log.debug("userList = \(success?.users ?? [])")
                        
                        self.userArray = success?.users ?? []

                        if self.userArray.isEmpty {
                            self.userCollectionView.isHidden = true
                            self.emtyView.isHidden = false
                        }else {
                            self.emtyView.isHidden = true
                            self.userCollectionView.isHidden = false
                            self.userArray = success?.users ?? []                            
                        }
                        self.userCollectionView.reloadData()
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
    }
}

extension FindFriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: "FindFriendsCell", for: indexPath) as? FindFriendsCell
        self.setDataUser(cell: cell, indexpathForCell: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func setDataUser(cell: FindFriendsCell?, indexpathForCell: IndexPath) {
        let obj = userArray[indexpathForCell.row]
        let url = URL(string: obj.avatar ?? "")
        cell?.delegate = self
        cell?.indexPath = indexpathForCell.row
        cell?.userId  = obj.userID ?? ""
        cell?.userImagevIew.kf.indicatorType = .activity
        cell?.userImagevIew.kf.setImage(with: url)
        cell?.userNameLabel.text = obj.name
        
        cell?.followButton.setTitleColor(UIColor.mainColor, for: .normal)
        cell?.followButton.borderColorV = UIColor.mainColor
        
        let timeResposse = setTimestamp(epochTime: obj.lastseen ?? "")
        cell?.lastStutesLabek.text = setTimestamp(epochTime: obj.lastseen ?? "")
        
        if  timeResposse == "1 minute ago" || timeResposse == "2 mintes ago" || timeResposse == "3 mintes ago" || timeResposse == "4 mintes ago" || timeResposse == "5 mintes ago" {
            cell?.stutesView.backgroundColor = UIColor(hex: "68D48F")

        } else {
            cell?.stutesView.backgroundColor = UIColor(hex: "DDDDDD")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (userCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = userArray[indexPath.row]
        let vc = R.storyboard.dashboard.userProfileVC()
        vc?.user_id =  object.userID ?? ""
        vc?.isFollowing = 1
        vc?.isfind = true
        vc?.getUserData(user_ID: object.userID ?? "")
        vc?.searchUserObject = object
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.navigationController?.pushViewController(vc!, animated: true)
        }        
    }
}

//MARK: - FilterSearchDelegate
extension FindFriendsViewController: FilterSearchDelegate {
    func getFilterData(gender: String, _status: String, distnce: String, relationships: String) {
        self.fetchData(status: _status,
                       gender: gender,
                       distace: distnce,
                       relationships: relationships)
    }
}

extension FindFriendsViewController:FollowUnFollowDelegate{
    
    func followUnfollow(user_id: String, index: Int, cellBtn: UIButton) {
        //        self.showProgressDialog(text: "Loading...")
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            FollowingManager.instance.followUnfollow(user_id: user_id, session_Token: sessionToken, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("userList = \(success?.followStatus ?? "")")
                            self.view.makeToast(success?.followStatus ?? "")
                            if success?.followStatus  ?? "" == "followed"{
                                cellBtn.backgroundColor = self.color
                                cellBtn.setTitleColor(UIColor.white, for: .normal)
                                if (AppInstance.instance.connectivity_setting == "0"){
                                    self.userArray[index].isFollowing = 1
                                    cellBtn.setTitle(NSLocalizedString("following", comment: "following"), for: .normal)
                                }
                                else{
                                    if (self.userArray[index].isFollowing == 0){
                                        cellBtn.backgroundColor = UIColor.white
                                        cellBtn.borderColorV = self.color
                                        cellBtn.borderWidthV = 2
                                        cellBtn.setTitleColor(self.color, for: .normal)
                                        self.userArray[index].isFollowing = 2
                                        cellBtn.setTitle(NSLocalizedString("Requested", comment: "Requested"), for: .normal)
                                    }
                                    else{
                                        self.userArray[index].isFollowing = 1
                                        cellBtn.setTitle(NSLocalizedString("MyFriend", comment: "MyFriend"), for: .normal)
                                    }
                                }
                                
                            }else{
                                cellBtn.backgroundColor = UIColor.white
                                cellBtn.borderColorV = self.color
                                cellBtn.borderWidthV = 2
                                cellBtn.setTitleColor(self.color, for: .normal)
                                if (AppInstance.instance.connectivity_setting == "0"){
                                    self.userArray[index].isFollowing = 0
                                    cellBtn.setTitle(NSLocalizedString("follow", comment: "follow"), for: .normal)
                                }
                                else{
                                    self.userArray[index].isFollowing = 0
                                    cellBtn.setTitle(NSLocalizedString("AddFriend", comment: "AddFriend"), for: .normal)
                                }
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
                
            })
        })
    }
}
