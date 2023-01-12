//
//  EditProfileViewController.swift
//  WoWonder
//
//  Created by Mac on 08/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import Kingfisher
import Async
import WowonderMessengerSDK

class EditProfileViewController: BaseVC {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var fristNameTextFiled: UITextField!
    @IBOutlet weak var aboutUsTextView: UITextView!
    @IBOutlet weak var lastNameTextFiled: UITextField!    
    @IBOutlet weak var websiteTextFiled: UITextField!
    @IBOutlet weak var genderTextFiled: UITextField!
    @IBOutlet weak var mobileTextFiled: UITextField!
    @IBOutlet weak var contryTextFiled: UITextField!
    @IBOutlet weak var studayTextFiled: UITextField!
    @IBOutlet weak var wrokTextFiled: UITextField!
    @IBOutlet weak var youtubeTextFiled: UITextField!
    @IBOutlet weak var vkTextFiled: UITextField!
    @IBOutlet weak var instagramTextFiled: UITextField!
    @IBOutlet weak var twitterTextFiled: UITextField!
    @IBOutlet weak var faceBookTextFiled: UITextField!
    @IBOutlet weak var relationshipTextFiled: UITextField!
    @IBOutlet weak var screenNamelabel: UILabel!
    @IBOutlet weak var wrokImageview: UIImageView!
    
    @IBOutlet weak var bookImageview: UIImageView!
    
    @IBOutlet weak var locationImaheview: UIImageView!
    
    @IBOutlet weak var callImagview: UIImageView!
    
    @IBOutlet weak var genderImaheview: UIImageView!
    
    @IBOutlet weak var wroldVIewIamge: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var relactionship: UIImageView!
    
    //Variable's
    private var avatarImage:UIImage? = nil
    private let imagePickerController = UIImagePickerController()
    private var type = "0"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.saveButton.backgroundColor = UIColor.mainColor
        self.wrokImageview.image = UIImage(named: "ic_wrok_profile")?.withRenderingMode(.alwaysTemplate)
        self.wrokImageview.tintColor = UIColor.mainColor
        
        self.locationImaheview.image = UIImage(named: "ic_profile_Location")?.withRenderingMode(.alwaysTemplate)
        self.locationImaheview.tintColor = UIColor.mainColor
        
        self.callImagview.image = UIImage(named: "ic_profile_Call")?.withRenderingMode(.alwaysTemplate)
        self.callImagview.tintColor = UIColor.mainColor
        
        self.genderImaheview.image = UIImage(named: "ic_profie_gender")?.withRenderingMode(.alwaysTemplate)
        self.genderImaheview.tintColor = UIColor.mainColor
        
        self.wroldVIewIamge.image = UIImage(named: "ic_wlord_profile")?.withRenderingMode(.alwaysTemplate)
        self.wroldVIewIamge.tintColor = UIColor.mainColor
        
        self.relactionship.image = UIImage(named: "ic_Profile_Heart")?.withRenderingMode(.alwaysTemplate)
        self.relactionship.tintColor = UIColor.mainColor
        
        self.bookImageview.image = UIImage(named: "ic_profile_book")?.withRenderingMode(.alwaysTemplate)
        self.bookImageview.tintColor = UIColor.mainColor
        
        self.screenNamelabel.textColor = UIColor.mainColor
        
        self.setUpScreenUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setUpScreenUI() {
        let userProfileURL = URL(string: AppInstance.instance.userProfile?._avatar ?? "")
        self.userProfileImageView.kf.indicatorType = .activity
        self.userProfileImageView.kf.setImage(with: userProfileURL, placeholder: UIImage(named: ""))
        self.fristNameTextFiled.text = AppInstance.instance.userProfile?.firstName
        self.lastNameTextFiled.text = AppInstance.instance.userProfile?.lastName
        self.aboutUsTextView.text = AppInstance.instance.userProfile?.about
        self.faceBookTextFiled.text = AppInstance.instance.userProfile?.facebook
        self.twitterTextFiled.text = AppInstance.instance.userProfile?.twitter
        self.instagramTextFiled.text = AppInstance.instance.userProfile?.instagram
        self.vkTextFiled.text = AppInstance.instance.userProfile?.vk
        self.youtubeTextFiled.text = AppInstance.instance.userProfile?.youtube
        self.wrokTextFiled.text = AppInstance.instance.userProfile?.working
        self.studayTextFiled.text = AppInstance.instance.userProfile?.school
        self.contryTextFiled.text = AppInstance.instance.userProfile?.address
        self.mobileTextFiled.text = AppInstance.instance.userProfile?.phoneNumber
        self.genderTextFiled.text = AppInstance.instance.userProfile?.gender
        self.websiteTextFiled.text = AppInstance.instance.userProfile?.website
        
        let relationship = AppInstance.instance.userProfile?.relationshipID
        
        if relationship == "1" {
            self.relationshipTextFiled.text = "Single"
            
        } else if relationship == "2" {
            self.relationshipTextFiled.text = "In a reationship"
            
        } else if relationship == "3" {
            self.relationshipTextFiled.text = "Married"
            
        } else if relationship == "4" {
            self.relationshipTextFiled.text = "Engaged"
            
        }else if relationship == "0" {
            self.relationshipTextFiled.text = "Non"
            
        } else {
            self.relationshipTextFiled.text = "Non"
        }
        
        
        //MARK: ProfileImage TapGestureRecognizer
        let profileImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        self.userProfileImageView.isUserInteractionEnabled = true
        self.userProfileImageView.addGestureRecognizer(profileImageTapGestureRecognizer)

    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.updateUserProfile()
        
    }
    
    @objc func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
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
    
    @IBAction func locationButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        let locationSearchVC = LocationSearchViewController.initialize(from: .settings)
        locationSearchVC.delegate = self
        self.navigationController?.pushViewController(locationSearchVC, animated: true)
    }
    
    @IBAction func genderButtonClick(_ sender: UIControl) {
        let vc = GenderViewController.initialize(from: .settings)
        vc.delegate = self
        vc.gender = genderTextFiled.text ?? ""
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func RelationshipButtonClick(_ sender: UIControl) {
        let vc = RelationshipViewController.initialize(from: .settings)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @objc func Save(){
        log.verbose("savePressed!!")
        self.updateUserProfile()
    }
    
    //MARK: - updateUserProfile Api Calling
    private func updateUserProfile(){
//        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let firstname = self.fristNameTextFiled.text ?? ""
        let lastname = self.lastNameTextFiled.text ?? ""
        let gender = self.genderTextFiled.text  ?? ""
        let location = self.contryTextFiled.text ?? ""
        let mobile = self.mobileTextFiled.text ?? ""
        let website = self.websiteTextFiled.text ?? ""
        let workspace = self.wrokTextFiled.text ?? ""
        let facebook = self.faceBookTextFiled.text ?? ""
        let instagram = self.instagramTextFiled.text ?? ""
        let VK = self.vkTextFiled.text ?? ""
        let twitter = self.twitterTextFiled.text ?? ""
        let youtube = self.youtubeTextFiled.text ?? ""
        
        Async.background({
            if self.avatarImage == nil {
                SettingsManager.instance.updateUserProfile(session_Token:sessionToken ,
                                                           firstname: firstname,
                                                           lastname: lastname,
                                                           gender: gender,
                                                           location: location,
                                                           phone: mobile,
                                                           website: website,
                                                           school: workspace,
                                                           facebook: facebook,
                                                           google: "",
                                                           twitter: twitter,
                                                           youtube: youtube,
                                                           VK: VK,
                                                           instagram: instagram,
                                                           relationship: self.type) { (success, sessionError, serverError, error) in
                    if success != nil{
                        Async.main({
                            self.dismissProgressDialog {
                                log.debug("success = \(success?.message ?? "")")
                                self.view.makeToast(success?.message ?? "")
                                // Call in Soket Update User Profile
                                let Data = ["from_id": AppInstance.instance.sessionId as Any] as [String : Any]
                                SocketHelper.shared.emit(emitName: "on_avatar_changed", params: Data)
                                
                                // Call in Soket Update User Name
                                SocketHelper.shared.emit(emitName: "on_name_changed", params: Data)
                                AppInstance.instance.fetchUserProfile(pass: nil)
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
                    
                }
                
            }else{
                
                if self.avatarImage != nil {
                    let avatarData = self.avatarImage?.jpegData(compressionQuality: 0.2)
                    SettingsManager.instance.updateUserDataWithCandA(session_Token:sessionToken , firstname: firstname, lastname: lastname, gender: gender, location: location, phone: mobile, website: website, school: workspace, facebook: facebook, google: "", twitter: twitter, youtube: youtube, VK: VK, instagram: instagram, type: "avatar", avatar_data: avatarData, cover_data: nil) { (success, sessionError, serverError, error) in
                        if success != nil{
                            Async.main({
                                self.dismissProgressDialog {
                                    log.debug("success = \(success?.message ?? "")")
                                    self.view.makeToast(success?.message ?? "")
                                    AppInstance.instance.fetchUserProfile(pass: nil)
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
                        
                    }
                    
                }else if self.avatarImage == nil {
//                    let coverImageData = self.coverImageVar?.jpegData(compressionQuality: 0.2)
                    SettingsManager.instance.updateUserDataWithCandA(session_Token:sessionToken , firstname: firstname, lastname: lastname, gender: gender, location: location, phone: mobile, website: website, school: workspace, facebook: facebook, google: "", twitter: twitter, youtube: youtube, VK: VK, instagram: instagram, type: "cover", avatar_data: nil, cover_data: nil) { (success, sessionError, serverError, error) in
                        if success != nil{
                            Async.main({
                                self.dismissProgressDialog {
                                    log.debug("success = \(success?.message ?? "")")
                                    self.view.makeToast(success?.message ?? "")
                                   AppInstance.instance.fetchUserProfile(pass: nil)
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
                        
                    }
                    
                }else{
                    let avatarData = self.avatarImage?.jpegData(compressionQuality: 0.2)
                    
                    SettingsManager.instance.updateUserDataWithCandA(session_Token:sessionToken , firstname: firstname, lastname: lastname, gender: gender, location: location, phone: mobile, website: website, school: workspace, facebook: facebook, google: "", twitter: twitter, youtube: youtube, VK: VK, instagram: instagram, type: "all", avatar_data: avatarData, cover_data: nil) { (success, sessionError, serverError, error) in
                        if success != nil{
                            Async.main({
                                self.dismissProgressDialog {
                                    log.debug("success = \(success?.message ?? "")")
                                    self.view.makeToast(success?.message ?? "")
                                    AppInstance.instance.fetchUserProfile(pass: nil)
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
                        
                    }
                    
                }
                
            }
            
        })
    }
}

//MARK: - UIImagePickerController & UINavigationController Delegate Method's
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.userProfileImageView.image = image
        self.avatarImage  = image
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - GetUserDataAddress
extension EditProfileViewController: GetUserDataAddress {
    func GetUserAddress(_ viewController: LocationSearchViewController,
                        latitude: Double,
                        longitutde: Double,
                        Address: String,
                        contrary: String) {
        self.contryTextFiled.text = Address
    }
}


extension EditProfileViewController: genderContol {
    func genderName(Gender: String) {
        self.genderTextFiled.text = Gender
    }
}

extension EditProfileViewController: RelationshipDelegate {
    
    func RelationshipSeleted(type: String) {
        self.relationshipTextFiled.text = type
        
        if type == "Single" {
            self.type = "1"
            
        } else if type == "Reationship" {
            self.type = "2"
            
        } else if type == "Married" {
            self.type = "3"
            
        } else if type == "Engaged" {
            self.type = "4"
            
        }else if type == "Non" {
            self.type = "5"
            
        } else {
            self.type = "0"
        }
    }
}
