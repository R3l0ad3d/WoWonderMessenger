

import UIKit
import Async
import WowonderMessengerSDK
class ForgetPasswordVC: BaseVC {
    
    @IBOutlet weak var forgetPassLabel: UILabel!
    @IBOutlet weak var emailTextFieldTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.dismissKeyboard()
        self.sendBtn.backgroundColor = UIColor.mainColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        self.forgetPasswordPressed()
    }
    
    private func forgetPasswordPressed(){
        self.view.endEditing(true)
        if appDelegate.isInternetConnected{
            
            if (self.emailTextFieldTF.text?.isEmpty)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter email.", comment: "Please enter email.")
                self.present(securityAlertVC!, animated: true, completion: nil)
                
            }else if !(emailTextFieldTF.text?.isEmail)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Email is badly formatted.", comment: "Email is badly formatted.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else{
                //
                
                let email = self.emailTextFieldTF.text ?? ""
                
                Async.background({
                    UserManager.instance.forgetPassword(Email: email, completionBlock: { (success, sessionError, serverError, error) in
                        if success != nil{
                            Async.main{
                                self.dismissProgressDialog{
//                                    log.verbose("Success = \(success?.apiStatus)")
                                    let securityAlertVC = R.storyboard.main.securityPopupVC()
                                    securityAlertVC?.titleText = NSLocalizedString("Check your email", comment: "Check your email")
                                    securityAlertVC?.errorText = "\(NSLocalizedString("We Sent email to", comment: "We Sent email to"))\(email). \(NSLocalizedString("Click the link in the email to reset your password.", comment: "Click the link in the email to reset your password."))"
                                    self.present(securityAlertVC!, animated: true, completion: nil)
                                    
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
                    })
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



