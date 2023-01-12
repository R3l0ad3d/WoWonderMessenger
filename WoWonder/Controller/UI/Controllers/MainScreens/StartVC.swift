//
//  StartVC.swift
//  WoWonder
//
//  Created by Muhammad Haris Butt on 10/13/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import UIKit
import WowonderMessengerSDK
import Async
class StartVC: BaseVC {

    @IBOutlet weak var continueAsBtn: UIButton!
    @IBOutlet weak var loginIntoAccBtn: UIButton!
    @IBOutlet weak var termsAndConditionsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        let data =  UserDefaults.standard.getContinueAs(Key: "ContinueAs")
        self.continueAsBtn.setTitle("Continue as \(data["username"] ?? "" )", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    private func setupUI(){
        self.continueAsBtn.backgroundColor = UIColor.ButtonColor
    }
    @IBAction func continueAsPressed(_ sender: Any){
        self.loginPressed()
    }
    @IBAction func termsAndConditionPressed(_ sender: Any) {
        let vc = R.storyboard.main.webViewVC()
           vc?.url = ControlSettings.termsOfUse
           self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func loginIntoAnotherAccPressed(_ sender: Any) {
        let vc = R.storyboard.main.loginVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    private func loginPressed(){
          if appDelegate.isInternetConnected{
       
                  //
                  let data =  UserDefaults.standard.getContinueAs(Key: "ContinueAs")

                            let username = data["username"] ?? ""
                  let password1 = data["password"] ?? ""
                            let password = password1
                  let deviceId = UserDefaults.standard.getDeviceId(Key: "deviceID") ?? ""
                  Async.background({
                      UserManager.instance.authenticateUser(UserName: username, Password: password, DeviceId: deviceId){ (success, sessionError, serverError, error) in
                          if success != nil{
                              Async.main{
                                  self.dismissProgressDialog{
                                    let accessToken = success?["access_token"] as? String
                                    let userID = success?["user_id"] as? String
                                    if accessToken == nil{
                                        let vc = R.storyboard.main.twoFactorVerifyVC()
                                        vc?.userID = userID ?? ""
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                    }else{
                                        log.verbose("Success = \(accessToken ?? "")")
                                        let User_Session = [Local.USER_SESSION.Access_token:accessToken ?? "",Local.USER_SESSION.User_id:userID ?? ""] as [String : Any]
                                        UserDefaults.standard.setUserSession(value: User_Session, ForKey: Local.USER_SESSION.User_Session)
                                        UserDefaults.standard.setPassword(value: password, ForKey: Local.USER_SESSION.Current_Password)
                                        AppInstance.instance.getUserSession()
                                        AppInstance.instance.fetchUserProfile(pass: password)
                                        UserDefaults.standard.setPassword(value: password, ForKey: Local.USER_SESSION.Current_Password)
                                        let vc = R.storyboard.main.introVC()
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                        self.view.makeToast(NSLocalizedString("Login Successfull!!", comment: "Login Successfull!!"))
                                    }
                                  }
                              }
                          }else if sessionError != nil{
                              Async.main{
                                  self.dismissProgressDialog {
                                      log.verbose("session Error = \(sessionError?.errors?.errorText)")
                                      
                                      let securityAlertVC = R.storyboard.main.securityPopupVC()
                                      securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                      securityAlertVC?.errorText = sessionError?.errors?.errorText ?? ""
                                      self.present(securityAlertVC!, animated: true, completion: nil)
                                  }
                              }
                          }else if serverError != nil{
                              Async.main({
                                  self.dismissProgressDialog {
                                      
                                      log.verbose("serverError = \(serverError?.errors?.errorText)")
                                      
                                      let securityAlertVC = R.storyboard.main.securityPopupVC()
                                      securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                      securityAlertVC?.errorText = sessionError?.errors?.errorText ?? ""
                                      self.present(securityAlertVC!, animated: true, completion: nil)
                                  }
                              })
                              
                          }else {
                              Async.main({
                                  self.dismissProgressDialog {
                                      log.verbose("error = \(error?.localizedDescription)")
                                      let securityAlertVC = R.storyboard.main.securityPopupVC()
                                      securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                      securityAlertVC?.errorText = error?.localizedDescription ?? ""
                                      self.present(securityAlertVC!, animated: true, completion: nil)
                                  }
                              })
                          }
                      }
                  })
          }else{
              self.dismissProgressDialog {
                  let securityAlertVC = R.storyboard.main.securityPopupVC()
                  securityAlertVC?.titleText  = NSLocalizedString("Internet Error", comment: "Internet Error")
                  securityAlertVC?.errorText = InterNetError ?? ""
                  self.present(securityAlertVC!, animated: true, completion: nil)
                  log.error("internetError - \(InterNetError)")
              }
          }
      }
}
