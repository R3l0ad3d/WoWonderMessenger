

import Async
import UIKit
import WowonderMessengerSDK

class TwoFactorVerifyVC: BaseVC {
    @IBOutlet weak var verifyCodeTextField: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    
    var code:String? = ""
    var userID : String? = ""
    var error = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.verifyCodeTextField.placeholder = NSLocalizedString("Add code number", comment: "Add code number")
        self.verifyBtn.setTitle(NSLocalizedString("VERIFY", comment: "VERIFY"), for: .normal)
        self.label1.text = NSLocalizedString("To log in, you need to verify  your identity.", comment: "To log in, you need to verify  your identity.")
        self.label2.text = NSLocalizedString("We have sent you the confirmation code to your email address.", comment: "We have sent you the confirmation code to your email address.")
        self.verifyBtn.setTitleColor(.mainColor, for: .normal)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func verifyPressed(_ sender: Any) {
        if self.verifyCodeTextField.text!.isEmpty{
            self.view.makeToast(NSLocalizedString("Please enter Code", comment: "Please enter Code"))
        }else{
            self.verifyTwoFactor()
        }
    }
    private func verifyTwoFactor(){
        
        if appDelegate.isInternetConnected{
            if (self.verifyCodeTextField.text!.isEmpty){
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter Code.", comment: "Please enter Code.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else{
                //
                let userID = self.userID ?? ""
                let code = self.verifyCodeTextField.text ?? ""
                
                Async.background({
                    TwoFactorManager.instance.verifyCode(code: code, UserID: userID) { (success, sessionError, serverError, error) in
                        if success != nil{
                            Async.main{
                                self.dismissProgressDialog{
                                    log.verbose("Success = \(success?.accessToken)")
                                    let User_Session = [Local.USER_SESSION.Access_token:success?.accessToken,Local.USER_SESSION.User_id:success?.userID] as [String : Any]
                                    UserDefaults.standard.setUserSession(value: User_Session, ForKey: Local.USER_SESSION.User_Session)
 AppInstance.instance.fetchUserProfile(pass: nil)
                                    //                                    UserDefaults.standard.setPassword(value: password, ForKey: Local.USER_SESSION.Current_Password)
                                    let vc = R.storyboard.main.introVC()
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                    self.view.makeToast(NSLocalizedString("Login Successfull!!", comment: "Login Successfull!!"))
                                }
                            }
                        }else if sessionError != nil{
                            Async.main{
                                self.dismissProgressDialog {
                                    log.verbose("session Error = \(sessionError?.errors.errorText)")
                                    
                                    let securityAlertVC = R.storyboard.main.securityPopupVC()
                                    securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                    securityAlertVC?.errorText = sessionError?.errors.errorText ?? ""
                                    self.present(securityAlertVC!, animated: true, completion: nil)
                                    
                                }
                            }
                        }else if serverError != nil{
                            Async.main({
                                self.dismissProgressDialog {
                                    
                                    log.verbose("serverError = \(serverError?.errors?.errorText)")
                                    
                                    let securityAlertVC = R.storyboard.main.securityPopupVC()
                                    securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                    securityAlertVC?.errorText = sessionError?.errors.errorText ?? ""
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
            }
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
