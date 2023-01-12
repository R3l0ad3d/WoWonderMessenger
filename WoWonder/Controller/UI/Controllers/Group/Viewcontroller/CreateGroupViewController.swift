//
//  CreateGroupViewController.swift
//  WoWonder
//
//  Created by Mac on 16/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Async
import WowonderMessengerSDK

protocol participantsCollectionDelegate {
    func selectParticipantsCollection(idsString:String,participantsArray:[AddParticipantModel])
}

class CreateGroupViewController: BaseVC {
    
    @IBOutlet weak var addpeLabel: UILabel!
    @IBOutlet weak var addView: UIControl!
    @IBOutlet weak var CreateGroupListTableView: UITableView!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var selctImg: UIControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addGroupIcone: UIImageView!
    @IBOutlet weak var camreraImage: UIImageView!
    
    private var selectedUsersArray = [AddParticipantModel]()
    private var idsString = ""
    private var idsArray = [0]
    private let imagePickerController = UIImagePickerController()
    private var imageData:Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUpScreenUI()
        self.addView.backgroundColor = UIColor.bgMain
        self.addpeLabel.textColor = UIColor.mainColor
        self.addGroupIcone.image = UIImage(named: "ic_Group_add")?.withRenderingMode(.alwaysTemplate)
        self.selctImg.backgroundColor = UIColor.bgMain
        self.addGroupIcone.tintColor = UIColor.mainColor
        self.saveButton.backgroundColor = UIColor.mainColor
        
        self.camreraImage.image = UIImage(named: "ic_Group_Camera")?.withRenderingMode(.alwaysTemplate)
        self.camreraImage.tintColor = UIColor.mainColor
    }
    
    func setUpScreenUI() {
        let XIB = UINib(nibName: "GroupAddParticipantsCell", bundle: nil)
        self.CreateGroupListTableView.register(XIB, forCellReuseIdentifier: "GroupAddParticipantsCell")
    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancleButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.selectedUsersArray.removeAll()
        self.CreateGroupListTableView.reloadData()
    }
    
    @IBAction func addParticipantsClickButton(_ sender: UIControl) {
        let navigaction = AddParticipantsListViewController.initialize(from: .group)
        if #available(iOS 15.0, *) {
            if let chatBottom = navigaction.sheetPresentationController {
                chatBottom.detents = [.medium(),.large()]
                chatBottom.prefersScrollingExpandsWhenScrolledToEdge = false
                chatBottom.prefersGrabberVisible = true
            }
        } else {
        }
        navigaction.delegate = self
        present(navigaction, animated: true, completion: nil)
    }
    
    @IBAction func createButtonClick(_ sender: UIButton) {
        if imageData == nil{
            let securityAlertVC = R.storyboard.main.securityPopupVC()
            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
            securityAlertVC?.errorText = NSLocalizedString("Please select group avatar.", comment: "Please select group avatar.")
            self.present(securityAlertVC!, animated: true, completion: nil)
        } else if self.groupNameTextField.text!.isEmpty{
            let securityAlertVC = R.storyboard.main.securityPopupVC()
            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
            securityAlertVC?.errorText = NSLocalizedString("Please enter group name.", comment: "Please enter group name.")
            self.present(securityAlertVC!, animated: true, completion: nil)
        } else if self.idsString == ""{
            let securityAlertVC = R.storyboard.main.securityPopupVC()
            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
            securityAlertVC?.errorText = NSLocalizedString("Please select Atleast one participant.", comment: "Please select Atleast one participant.")
            self.present(securityAlertVC!, animated: true, completion: nil)
        } else {
            self.createGroup()
        }
    }
    
    @IBAction func addImageButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "", message: NSLocalizedString("Select Source", comment: "Select Source"), preferredStyle: .alert)
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: "Camera"), style: .default) { (action) in
            self.imagePickerController.delegate = self
            
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: "Gallery"), style: .default) { (action) in
            self.imagePickerController.delegate = self
            
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .destructive, handler: nil)
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    private func createGroup(){
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupName  = self.groupNameTextField.text ?? ""
        let imageData = self.imageData
        let parts = self.idsString
        Async.background({
            GroupChatManager.instance.createGroup(session_Token: sessionToken, groupName: groupName, parts: parts, type: "create", avatar_data: imageData, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("success = \(success?.apiStatus ?? 0)")
                            
                        }
                        self.navigationController?.popViewController(animated: true)
                    })
                } else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                            self.view.makeToast(sessionError?.errors?.errorText ?? "")
                        }
                        
                    })
                } else if serverError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                            self.view.makeToast(serverError?.errors?.errorText ?? "")
                        }
                        
                    })
                } else {
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

extension CreateGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedUsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreateGroupListTableView.dequeueReusableCell(withIdentifier: "GroupAddParticipantsCell", for: indexPath) as? GroupAddParticipantsCell
        self.setTableViewdata(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func setTableViewdata(cell: GroupAddParticipantsCell?, indexPath: IndexPath) {
        let index = self.selectedUsersArray[indexPath.row]
        cell?.userNameLabel.text = index.username
        cell?.userSubLabel.text = ControlSettings.WoWonderText
        cell?.delegate = self
        cell?.selectedParticipantArray = self.selectedUsersArray
        cell?.indexPath = indexPath.row
        let url = URL.init(string:index.profileImage ?? "")
        cell?.userImageView.kf.indicatorType = .activity
        cell?.userImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        //        cell?.cancleView.addTarget(self, action: #selector(removeButtonClick), for: .touchUpInside)
    }
}

//MARK: - participantsCollectionDelegate
extension CreateGroupViewController: participantsCollectionDelegate{
    func selectParticipantsCollection(idsString: String, participantsArray: [AddParticipantModel]) {
        self.selectedUsersArray.removeAll()
        self.selectedUsersArray = participantsArray
        self.idsString = idsString
        log.verbose("Self.idString = \(self.idsString)")
        log.verbose(".idString = \(idsString)")
        
        log.verbose("self.selectedUsersArray = \(self.selectedUsersArray)")
        self.CreateGroupListTableView.reloadData()
        
    }
}

extension CreateGroupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.groupImage.image = image
        self.imageData = image.jpegData(compressionQuality: 0.1)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupViewController: deleteParticipantDelegate {
    
    func deleteParticipant(index: Int, status: Bool, selectedUseArray: [AddParticipantModel]) {
        self.idsString = ""
        self.selectedUsersArray.removeAll()
        self.idsArray.removeAll()
        self.selectedUsersArray = selectedUseArray
        selectedUsersArray.forEach { (it) in
            self.idsArray.append(it.id ?? 0)
        }

        log.verbose("idsArray = \(self.idsArray)")
        var stringArray = self.idsArray.map { String($0) }
        self.idsString = stringArray.joined(separator: ",")

        self.CreateGroupListTableView.reloadData()
    }
}
