

import UIKit
import Async
import WowonderMessengerSDK

class SignUpVC: BaseVC {
    
    @IBOutlet weak var registerNowLabel: UILabel!
    @IBOutlet weak var downTextLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextFieldTF: UITextField!
    @IBOutlet weak var passwordTextFieldTF: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextFieldTF: UITextField!
    @IBOutlet weak var agreeTermsBtn: UIButton!
    @IBOutlet weak var termOfServiceBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var termsandConditionLabel: UILabel!
    @IBOutlet weak var maleButton: UIImageView!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleButton: UIImageView!
    @IBOutlet weak var femaleLabel: UILabel!
    
    var gender:String = ""
    private var agreeStatus:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        setupUI()
        self.termOfServiceBtn.setTitleColor(UIColor.mainColor, for: .normal)
        self.signupBtn.backgroundColor = UIColor.mainColor
        self.agreeTermsBtn.setTitleColor(UIColor.mainColor, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func maleButtonClick(_ sender: UIControl) {
        self.gender = "female"
        self.femaleLabel.textColor = UIColor(hex: "686C6B")
        self.maleLabel.textColor = UIColor(hex: "C83747")
        self.femaleButton.image = UIImage(named: "ic_redia")
        self.maleButton.image = UIImage(named: "ic_redia_on")
    }
    
    @IBAction func femaleButtonClick(_ sender: UIControl) {
        self.gender = "female"
        self.maleLabel.textColor = UIColor(hex: "686C6B")
        self.femaleLabel.textColor = UIColor(hex: "C83747")
        self.maleButton.image = UIImage(named: "ic_redia")
        self.femaleButton.image = UIImage(named: "ic_redia_on")
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        self.registerPressed()
    }
    
    @IBAction func agreeTermsPressed(_ sender: Any) {
        self.agreeStatus = !self.agreeStatus!
        if self.agreeStatus!{
            self.agreeTermsBtn.setImage(UIImage(named: "ic_checkbox"), for: .normal)
        }else{
            self.agreeTermsBtn.setImage(UIImage(named: "ic_uncheckgey"), for: .normal)
        }
    }
    @IBAction func termsOfServicePressed(_ sender: Any) {
        let vc = R.storyboard.main.webViewVC()
        vc?.url = ControlSettings.termsOfUse
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    func setupUI(){                                                     
        self.termOfServiceBtn.underline()
    }
    
    private func registerPressed(){
        if appDelegate.isInternetConnected{
            if !self.agreeStatus!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Warning !", comment: "Warning !")
                securityAlertVC?.errorText = NSLocalizedString("You can not access your disapproval of the Terms and Conditions.", comment: "You can not access your disapproval of the Terms and Conditions.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }  else if (self.usernameTextField.text?.isEmpty)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter username.", comment: "Please enter username.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else if (emailTextFieldTF.text?.isEmpty)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter email.", comment: "Please enter email.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else if (passwordTextFieldTF.text?.isEmpty)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter password.", comment: "Please enter password.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else if (confirmPasswordTextFieldTF.text?.isEmpty)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter confirm password.", comment: "Please enter confirm password.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else if (passwordTextFieldTF.text != confirmPasswordTextFieldTF.text ){
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Password do not match.", comment: "Password do not match.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }else if !((emailTextFieldTF.text?.isEmail)!){
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Email is badly formatted.", comment: "Email is badly formatted.")
                self.present(securityAlertVC!, animated: true, completion: nil)
            }
            else{
                //
                let username = self.usernameTextField.text ?? ""
                let email = self.emailTextFieldTF.text ?? ""
                let password = self.passwordTextFieldTF.text ?? ""
                let confirmPassword = self.confirmPasswordTextFieldTF.text ?? ""
                let deviceId = self.oneSignalID ?? ""
                let gender = self.gender ?? ""
                Async.background({
                    UserManager.instance.RegisterUser(Email: email, UserName: username, DeviceId: deviceId, Password: password, ConfirmPassword: confirmPassword, gender: gender, completionBlock: { (success, sessionError, serverError, error) in
                        if success != nil{
                            Async.main{
                                self.dismissProgressDialog{
                                    log.verbose("Success = \(success?["access_token"] as? String)")
                                    AppInstance.instance.getUserSession()
                                    AppInstance.instance.fetchUserProfile(pass: nil)
                                    UserDefaults.standard.setPassword(value: password, ForKey: Local.USER_SESSION.Current_Password)
                                    let vc = R.storyboard.main.introVC()
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                    self.view.makeToast(NSLocalizedString("Login Successfull!!", comment: "Login Successfull!!"))
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
