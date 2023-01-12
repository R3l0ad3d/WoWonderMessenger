

import UIKit
import GoogleMobileAds
import Async

protocol TwoFactorAuthDelegate {
    func getTwoFactorUpdateString(type:String)
}

class TwoFactorVC: BaseVC {
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var twoFactorLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
            
    var bannerView: GADBannerView!
    var typeString:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI(){
        self.saveBtn.backgroundColor = UIColor.mainColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Two Factor Authentication"
        
        
        self.twoFactorLabel.text = NSLocalizedString("Two-factor Authentication", comment: "Two-factor Authentication")       
        self.saveBtn.setTitle(NSLocalizedString("SAVE", comment: "SAVE"), for: .normal)
        
        self.typeString = self.selectBtn.titleLabel?.text ?? ""
        if AppInstance.instance.userProfile?.twoFactor == "0"{
            self.selectBtn.setTitle(NSLocalizedString("Disable", comment: "Disable"), for: .normal)
        }else{
            self.selectBtn.setTitle(NSLocalizedString("Enable", comment: "Enable"), for: .normal)
        }
        if ControlSettings.shouldShowAddMobBanner{

            bannerView = GADBannerView()
            addBannerViewToView(bannerView)
            bannerView.adUnitID = ControlSettings.addUnitId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    
    @IBAction func selectBtnPressed(_ sender: Any) {
        let vc = R.storyboard.settings.twoFactorUpdateVC()
        vc!.delegate = self
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func backButtonClick(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        self.showProgressDialog(text: "Loading")
        
        if typeString == "on"{
            self.updateTwoFactorSendCode()
        }else{
            self.updateTwoFactor()
        }
        
    }
    private func updateTwoFactor(){
        let type = self.typeString ?? ""
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            SettingsManager.instance.updateTwoStepVerification(session_Token: sessionToken, type: type) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(success?.message ?? "")
                           AppInstance.instance.fetchUserProfile(pass: nil)
                            
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
        })
        
    }
    private func updateTwoFactorSendCode(){
        self.showProgressDialog(text: "Loading")
        let sessionToken = AppInstance.instance.sessionId ?? ""
        Async.background({
            TwoFactorManager.instance.updateTwoFactor(session_Token: sessionToken) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(success?.message ?? "")
                            let vc = R.storyboard.settings.confirmationCodeVC()
                            self.present(vc!, animated: true, completion: nil)
                            
                        }
                    })
                }else if sessionError != nil{
                    Async.main({
                        self.dismissProgressDialog {
                            self.view.makeToast(sessionError?.errors.errorText)
                            log.error("sessionError = \(sessionError?.errors.errorText)")
                            
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
        })
    }
}
extension TwoFactorVC:TwoFactorAuthDelegate{
    func getTwoFactorUpdateString(type: String) {
        if type == "on"{
            self.selectBtn.setTitle("Enable", for: .normal)
        }else{
            self.selectBtn.setTitle("Disable", for: .normal)
        }
        self.typeString = type
    }
}


