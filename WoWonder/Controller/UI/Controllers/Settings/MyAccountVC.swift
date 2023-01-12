
import UIKit
import SkyFloatingLabelTextField
import Async
import WowonderMessengerSDK
class MyAccountVC: BaseVC {
    
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var emailTextField: RoundTextField!
    @IBOutlet weak var usernameTextField: RoundTextField!
    @IBOutlet weak var birthdayField: RoundTextField!
    
    private var gender:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showData()
    }
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.Save()
    }
    
    @IBAction func genderPressed(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Select Gender", preferredStyle: .actionSheet)
        let male = UIAlertAction(title: "Male", style: .default) { action in
            self.gender = "male"
            self.genderBtn.setTitle("Male", for: .normal)
        }
        let female = UIAlertAction(title: "Female", style: .default) { action in
            self.gender = "female"
            self.genderBtn.setTitle("Female", for: .normal)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(male)
        alert.addAction(female)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateMyAccount(){
        //
        let sessionToken = AppInstance.instance.sessionId ?? ""
        let email = emailTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let genderbind = self.gender ?? ""
        
        Async.background({
            SettingsManager.instance.updateMyAccount(session_Token: sessionToken, email: email, username: username, gender: genderbind, completionBlock: { (success, sessionError, serverError, error) in
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
                            log.error("error = \(error?.localizedDescription ?? "")")
                            self.view.makeToast(error?.localizedDescription ?? "")
                        }
                    })
                }
            })
        })
    }
    
    private func showData() {
        self.usernameTextField.text = AppInstance.instance.userProfile?.username ?? ""
        self.emailTextField.text = AppInstance.instance.userProfile?.email ?? ""
        self.birthdayField.text = AppInstance.instance.userProfile?.birthday ?? ""
        if AppInstance.instance.userProfile?._gender == "Male" || AppInstance.instance.userProfile?._gender == "male"{
        }else{
        }
    }

    func Save(){
        log.verbose("savePressed!!")
        self.updateMyAccount()
    }
}
