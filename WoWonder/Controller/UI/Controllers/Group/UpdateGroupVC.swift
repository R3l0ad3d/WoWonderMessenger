

import UIKit
import Kingfisher
import Async
import WowonderMessengerSDK


class UpdateGroupVC: BaseVC  {
    
    @IBOutlet weak var deleteGroupBtn: UIButton!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var userMenmberTableVIew: UITableView!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var exitGroupBtn: UIButton!
    
    private var selectedUsersArray = [AddParticipantModel]()
    var partsArray = [FetchGroupModel.UserData]()
    var selectedIsArray = [Int]()
    var groupName = ""
    var groupImageString:String? = ""
    var groupID:String? = ""
    var groupOwner:Bool? = false
    private var idsString:String? = ""
    private var idsArray = [Int]()
    private let imagePickerController = UIImagePickerController()
    private var imageData:Data? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        log.verbose("group id = \(self.groupID ?? "")")
        
        let XIB = UINib(nibName: "GroupAddParticipantsCell", bundle: nil)
        self.userMenmberTableVIew.register(XIB, forCellReuseIdentifier: "GroupAddParticipantsCell")
        
        
        for index in 0..<partsArray.count {
            let obj = partsArray[index]
            let objadd = AddParticipantModel(id: Int(obj.userID ?? ""), profileImage: obj.avatar ?? "", username: obj.name ?? "")
            self.selectedUsersArray.append(objadd)
        }
    }
    
    @IBAction func addParticipantPressed(_ sender: UIControl) {
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
    
    @IBAction func exitGroupPressed(_ sender: Any) {
        self.exitGroup()
    }
    
    @IBAction func deleteGroupPressed(_ sender: Any) {
        self.deleteGroup()
    }
    
    @IBAction func selectImagePressed(_ sender: UIControl) {
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
    private func setupUI(){
        self.exitGroupBtn.setTitle(NSLocalizedString("Exit Group", comment: "Exit Group"), for: .normal)
        self.deleteGroupBtn.setTitle(NSLocalizedString("Delete Group", comment: "Delete Group"), for: .normal)
                
        self.groupNameTextField.text = self.groupName ?? ""
        
        let url = URL.init(string:groupImageString ?? "")
        self.groupImage.kf.indicatorType = .activity
        self.groupImage.kf.setImage(with: url, placeholder: UIImage(named: ""))
        
        var stringArray = self.selectedUsersArray.map { String($0.id ?? 0) }
        self.idsString = stringArray.joined(separator: ",")
        log.verbose("genresString = \(idsString)")
        log.verbose("self.selectedUsersArray = \(self.selectedUsersArray)")
        
        self.imageData = self.groupImage.image?.jpegData(compressionQuality: 0.1)
        
        if groupOwner!{
            self.deleteGroupBtn.isHidden = false
        }else{
            self.deleteGroupBtn.isHidden = false
        }
    }
    
    func saveNewUserAdd(){
        if imageData == nil{
            let securityAlertVC = R.storyboard.main.securityPopupVC()
            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
            securityAlertVC?.errorText = NSLocalizedString("Please select group avatar.", comment: "Please select group avatar.")
            self.present(securityAlertVC!, animated: true, completion: nil)
        }else if self.groupNameTextField.text!.isEmpty{
            let securityAlertVC = R.storyboard.main.securityPopupVC()
            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
            securityAlertVC?.errorText = NSLocalizedString("Please enter group name.", comment: "Please enter group name.")
            self.present(securityAlertVC!, animated: true, completion: nil)
        } else {
            self.addParticipants()
            
        }
    }
    private func exitGroup(){
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupId = self.groupID ?? ""
        Async.background({
            GroupChatManager.instance.leaveGroup(group_Id:groupId , session_Token: sessionToken, type: "leave", completionBlock: { (success, sessionError, serverError, error) in
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
    private func deleteGroup(){
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupId = self.groupID ?? ""
        Async.background({
            GroupChatManager.instance.deleteGroup(group_Id: groupId, session_Token: sessionToken, type: "delete", completionBlock: { (success, sessionError, serverError, error) in
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
    
    private func updateGroup(){
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let groupName  = self.groupNameTextField.text ?? ""
        let imageData = self.imageData ?? Data()
        let groupId = self.groupID ?? ""
        Async.background({
            GroupChatManager.instance.updateGroup(session_Token: sessionToken, groupName: groupName, groupId: groupId, type: "edit", avatar_data: imageData, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            log.debug("success = \(success?.apiStatus ?? 0)")
                            self.navigationController?.popViewController(animated: true)
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
    private func addParticipants(){
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let part = self.idsString ?? ""
        let groupId = self.groupID ?? ""
        Async.background({
            GroupChatManager.instance.addParticipants(group_Id: groupId, session_Token: sessionToken, type: "add_user", part: part, completionBlock: { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        
                        log.debug("success = \(success?.apiStatus ?? 0)")
                        self.updateGroup()
                        
                        
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
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        self.saveNewUserAdd()
    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension UpdateGroupVC: participantsCollectionDelegate{
    func selectParticipantsCollection(idsString: String, participantsArray: [AddParticipantModel]) {
        participantsArray.forEach { (it) in
            self.selectedUsersArray.forEach({ (it1) in
                if it1.id == it.id {
                    return
                }
            })
            let object = AddParticipantModel(id: it.id ?? 0, profileImage: it.profileImage ?? "", username: it.username)

            self.selectedUsersArray.append(object)
        }
        self.selectedUsersArray.forEach { (it) in
            self.selectedIsArray.append(it.id ?? 0)
        }
        let stringArray = self.selectedIsArray.map { String($0) }
        self.idsString = stringArray.joined(separator: ",")
        log.verbose("genresString = \(idsString)")
        log.verbose("self.selectedUsersArray = \(self.selectedUsersArray)")
        self.userMenmberTableVIew.reloadData()

    }
}

extension UpdateGroupVC: deleteParticipantDelegate{
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

        self.userMenmberTableVIew.reloadData()
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension  UpdateGroupVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.groupImage.image = image
        self.imageData = image.jpegData(compressionQuality: 0.1)
        self.dismiss(animated: true, completion: nil)


    }
}

//MARK: - UITableView Delegate & DataSource
extension UpdateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedUsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupAddParticipantsCell", for: indexPath) as? GroupAddParticipantsCell
        self.setTableViewdata(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func setTableViewdata(cell: GroupAddParticipantsCell?, indexPath: IndexPath) {
        let object = self.selectedUsersArray[indexPath.row]
        
        let url = URL.init(string: object.profileImage ?? "")
        cell?.delegate = self
        cell?.selectedParticipantArray = self.selectedUsersArray
        cell?.indexPath = indexPath.row
        cell?.userImageView.kf.indicatorType = .activity
        cell?.userImageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
        cell?.userNameLabel.text = object.username
        cell?.userSubLabel.text = ControlSettings.WoWonderText
    }
    
    
}

