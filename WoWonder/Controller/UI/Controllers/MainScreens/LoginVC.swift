

import UIKit
import Async
//import FBSDKLoginKit
import GoogleSignIn
import WowonderMessengerSDK
import AuthenticationServices


class LoginVC: BaseVC {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var usernameTextFieldTF: UITextField!
    @IBOutlet weak var passwordTextFieldTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("OneSignal device id = \(self.oneSignalID ?? "")")
        self.dismissKeyboard()
        setupUI()
        self.loginBtn.backgroundColor = UIColor.mainColor
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
    
    func setupUI() {
        usernameTextFieldTF.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextFieldTF.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.usernameTextFieldTF.placeholder = NSLocalizedString("Username", comment: "Username")
        self.passwordTextFieldTF.placeholder = NSLocalizedString("Password", comment: "Password")
        self.versionLabel.text = NSLocalizedString("Welcome Back!!", comment: "")
        self.forgotPassBtn.setTitle(NSLocalizedString("Forgot your Password?", comment: ""), for: .normal)
        self.loginBtn.setTitle(NSLocalizedString("Log in", comment: ""), for: .normal)
        self.signupBtn.setTitle(NSLocalizedString("Sign up", comment: ""), for: .normal)
    }
    
    @IBAction func passwrodShowHideButtonClick(_ sender: UIButton) {
        if iconClick {
            passwordTextFieldTF.isSecureTextEntry = false
            sender.setImage(UIImage(named: "ic_Show_Password"), for: .normal)

        } else {
            passwordTextFieldTF.isSecureTextEntry = true
            sender.setImage(UIImage(named: "ic_hide_Password"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @available(iOS 13.0, *)
    @IBAction func loginWithApplePressed(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    @IBAction func googlePressed(_ sender: Any) {
//        GIDSignIn.sharedInstance().presentingViewController = self
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookPressed(_ sender: Any) {
        self.facebookLogin()
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        let vc = R.storyboard.main.forgetPasswordVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        loginPressed()
    }
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        let vc = R.storyboard.main.signUpVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func loginPressed() {
        if appDelegate.isInternetConnected {
            
            if (self.usernameTextFieldTF.text?.isEmpty)! {
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter username.", comment: "Please enter username.")
                self.present(securityAlertVC!, animated: true, completion: nil)
                
            }else if (passwordTextFieldTF.text?.isEmpty)!{
                let securityAlertVC = R.storyboard.main.securityPopupVC()
                securityAlertVC?.titleText = NSLocalizedString("Security", comment: "Security")
                securityAlertVC?.errorText = NSLocalizedString("Please enter username.", comment: "Please enter username.")
                self.present(securityAlertVC!, animated: true, completion: nil)
                
            } else {
                let username = self.usernameTextFieldTF.text ?? ""
                let password = self.passwordTextFieldTF.text ?? ""
                let deviceId = UserDefaults.standard.getDeviceId(Key: "deviceID") ?? ""
                
                Async.background({
                    UserManager.instance.authenticateUser(UserName: username,
                                                          Password: password,
                                                          DeviceId: deviceId) { (success,
                                                                                 sessionError,
                                                                                 serverError,
                                                                                 error) in
                        if success != nil{
                            Async.main {
                                self.dismissProgressDialog {
                                    let accessToken = success?["access_token"] as? String
                                    let userID = success?["user_id"] as? String
                                    
                                    if accessToken == nil {
                                        let vc = R.storyboard.main.twoFactorVerifyVC()
                                        vc?.userID = userID ?? ""
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                    } else {
                                        let User_Session = [Local.USER_SESSION.Access_token:accessToken ?? "",Local.USER_SESSION.User_id:userID ?? ""] as [String : Any]
                                        UserDefaults.standard.setUserSession(value: User_Session, ForKey: Local.USER_SESSION.User_Session)
                                        UserDefaults.standard.setPassword(value: password, ForKey: Local.USER_SESSION.Current_Password)
                                        AppInstance.instance.fetchUserProfile(pass: password)
                                        UserDefaults.standard.setPassword(value: password, ForKey: Local.USER_SESSION.Current_Password)
                                        let vc = R.storyboard.main.introVC()
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                        self.view.makeToast(NSLocalizedString("Login Successfull!!", comment: "Login Successfull!!"))
                                    }
                                }
                            }
                            
                        }else if sessionError != nil {
                            Async.main{
                                self.dismissProgressDialog {
                                    let securityAlertVC = R.storyboard.main.securityPopupVC()
                                    securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                    securityAlertVC?.errorText = sessionError?.errors?.errorText ?? ""
                                    self.present(securityAlertVC!, animated: true, completion: nil)
                                }
                            }
                            
                        }else if serverError != nil {
                            Async.main({
                                self.dismissProgressDialog {
                                    let securityAlertVC = R.storyboard.main.securityPopupVC()
                                    securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
                                    securityAlertVC?.errorText = sessionError?.errors?.errorText ?? ""
                                    self.present(securityAlertVC!, animated: true, completion: nil)
                                }
                            })
                            
                        }else {
                            Async.main({
                                self.dismissProgressDialog {
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
            }
        }
    }
    private func facebookLogin(){
        if Connectivity.isConnectedToNetwork(){
//            let fbLoginManager : LoginManager = LoginManager()
//            
//            fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) in
//                if (error == nil){
//                    let fbloginresult : LoginManagerLoginResult = result!
//                    if (result?.isCancelled)!{
//                        self.dismissProgressDialog{
//                        }
//                        return
//                    }
//                    if fbloginresult.grantedPermissions != nil {
//                        if(fbloginresult.grantedPermissions.contains("email")) {
//                            if((AccessToken.current) != nil){
//                                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completion: { (connection, result, error) -> Void in
//                                    if (error == nil){
//                                        let dict = result as! [String : AnyObject]
//                                        log.debug("result = \(dict)")
//                                        guard let firstName = dict["first_name"] as? String else {return}
//                                        guard let lastName = dict["last_name"] as? String else {return}
//                                        guard let email = dict["email"] as? String else {return}
//                                        let accessToken = AccessToken.current?.tokenString
//                                        Async.background({
//                                            UserManager.instance.socialLogin(Provider: "facebook", AccessToken: accessToken ?? "", GoogleApiKey: "", completionBlock: { (success, sessionError,serverError, error) in
//                                                if success != nil{
//                                                    Async.main{
//                                                        self.dismissProgressDialog{
//                                                            AppInstance.instance.fetchUserProfile(pass: nil)
//                                                            let vc = R.storyboard.main.introVC()
//                                                            self.navigationController?.pushViewController(vc!, animated: true)
//                                                            self.view.makeToast(NSLocalizedString("Login Successfull!!", comment: "Login Successfull!!"))
//                                                        }
//                                                        
//                                                    }
//                                                }else if sessionError != nil{
//                                                    Async.main{
//                                                        self.dismissProgressDialog {
//                                                            let securityAlertVC = R.storyboard.main.securityPopupVC()
//                                                            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
//                                                            securityAlertVC?.errorText = sessionError?.errors?.errorText ?? ""
//                                                            self.present(securityAlertVC!, animated: true, completion: nil)
//                                                            
//                                                        }
//                                                    }
//                                                }else if serverError != nil{
//                                                    Async.main({
//                                                        self.dismissProgressDialog {
//                                                            let securityAlertVC = R.storyboard.main.securityPopupVC()
//                                                            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
//                                                            securityAlertVC?.errorText = sessionError?.errors?.errorText ?? ""
//                                                            self.present(securityAlertVC!, animated: true, completion: nil)
//                                                        }
//                                                    })
//                                                    
//                                                }else {
//                                                    Async.main({
//                                                        self.dismissProgressDialog {
//                                                            let securityAlertVC = R.storyboard.main.securityPopupVC()
//                                                            securityAlertVC?.titleText  = NSLocalizedString("Security", comment: "Security")
//                                                            securityAlertVC?.errorText = error?.localizedDescription ?? ""
//                                                            self.present(securityAlertVC!, animated: true, completion: nil)
//                                                        }
//                                                    })
//                                                }
//                                            })
//                                        })
//                                    }
//                                })
//                            }
//                        }
//                    }
//                }
//            }
            
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
    private func googleLogin(access_Token:String){
        //
        if Connectivity.isConnectedToNetwork(){
            Async.background({
                UserManager.instance.socialLogin(Provider: "google", AccessToken: access_Token ?? "", GoogleApiKey: ControlSettings.googleApiKey, completionBlock: { (success, sessionError, serverError,error) in
                    if success != nil{
                        Async.main{
                            self.dismissProgressDialog{
                                AppInstance.instance.getUserSession()
                                AppInstance.instance.fetchUserProfile(pass: nil)
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
    private func appleLogin(access_Token:String){
        //
        if Connectivity.isConnectedToNetwork(){
            Async.background({
                UserManager.instance.socialLogin(Provider: "apple", AccessToken: access_Token ?? "", GoogleApiKey: "", completionBlock: { (success, sessionError, serverError,error) in
                    if success != nil{
                        Async.main{
                            self.dismissProgressDialog{
                                AppInstance.instance.getUserSession()
                                AppInstance.instance.fetchUserProfile(pass: nil)
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

//@available(iOS 13.0, *)
//extension LoginVC : GIDSignInDelegate{
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if error == nil {
//            let userId = user.userID
//            let idToken = user.authentication.accessToken
//            print("user auth " ,idToken)
//            let token = user.authentication.idToken ?? ""
//            googleLogin(access_Token: token)
//        } else {
//            self.dismissProgressDialog {
//                      print(error.localizedDescription)
//            }
//
//        }
//
//    }
//}

extension LoginVC:ASAuthorizationControllerDelegate{
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.authorizationCode
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let authorizationCode = String(data: appleIDCredential.identityToken!, encoding: .utf8)!
            print("authorizationCode: \(authorizationCode)")
            self.appleLogin(access_Token: authorizationCode)
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))") }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error sign in with apple")
    }
}
