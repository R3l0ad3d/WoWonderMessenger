

import UIKit
import TTRangeSlider

protocol FilterSearchDelegate {
    func getFilterData(gender: String, _status: String, distnce: String, relationships: String)
}

class SearchFilterVC: UIViewController {
    
    @IBOutlet weak var all: UIButton!
    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var valuteCountKMLabel: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var offineStutesButton: UIButton!
    @IBOutlet weak var allSatutsButton: UIButton!
    @IBOutlet weak var RelationshipcommitedButton: UIButton!
    @IBOutlet weak var singleRelationshipButton: UIButton!
    @IBOutlet weak var allRelationship: UIButton!
    @IBOutlet weak var onlineStatusButton: UIButton!
    @IBOutlet weak var distanceSlider: UISlider!

    
    var gender: String? = nil
    var countryId: String? = nil
    var filterbyage: String? = nil
    var age_from: String? = nil
    var age_to: String? = nil
    var verify: String? = nil
    var _status: String? = nil
    var delegate:SearchDelegate?
    var filterSearch: FilterSearchDelegate?
    var userStatus = ""
    var distance = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allRelationship.backgroundColor = UIColor.bgMain
        self.allRelationship.setTitleColor(UIColor.mainColor, for: .normal)
        self.allSatutsButton.backgroundColor = UIColor.bgMain
        self.allSatutsButton.setTitleColor(UIColor.mainColor, for: .normal)
        self.all.backgroundColor = UIColor.bgMain
        self.all.setTitleColor(UIColor.mainColor, for: .normal)
        self._status = "all"
        self.gender = "all"
        self.userStatus = "all"
        self.distanceSlider.minimumTrackTintColor = UIColor.mainColor
        self.distanceSlider.maximumTrackTintColor = UIColor.bgMain
        self.filterBtn.backgroundColor = UIColor.mainColor
        
        
    }
    
    //    func displayVerified(){
    //        let alert = UIAlertController(title: "", message: NSLocalizedString("Verified", comment: "Verified"), preferredStyle: .actionSheet)
    //        alert.setValue(NSAttributedString(string: alert.message ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
    //
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("All", comment: "All"), style: .default, handler: { (_) in
    //              self.verified.text = NSLocalizedString("All", comment: "All")
    //              self.verify = "all"
    //        }))
    //
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("Verified", comment: "Verified"), style: .default, handler: { (_) in
    //            print("Verified")
    //            self.verified.text = NSLocalizedString("Verified", comment: "Verified")
    //            self.verify = "on"
    //        }))
    //
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("UnVerified", comment: "UnVerified"), style: .default, handler: { (_) in
    //            print("UnVerified")
    //            self.verified.text = NSLocalizedString("UnVerified", comment: "UnVerified")
    //            self.verify = "off"
    //
    //        }))
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Close"), style: .cancel, handler: { (_) in
    //            print("Close")
    //        }))
    //        self.present(alert, animated: true, completion: {
    //            print("completion block")
    //        })
    //    }
    
    //    func displayStatus(){
    //        let alert = UIAlertController(title: "", message: NSLocalizedString("Status", comment: "Status"), preferredStyle: .actionSheet)
    //
    //        alert.setValue(NSAttributedString(string: alert.message ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("All", comment: "All"), style: .default, handler: { (_) in
    //            self.status.text = NSLocalizedString("All", comment: "All")
    //            self._status = "all"
    //
    //        }))
    //
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("Offline", comment: "Offline"), style: .default, handler: { (_) in
    //            self.status.text = NSLocalizedString("Offline", comment: "Offline")
    //            self._status = "off"
    //        }))
    //
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("Online", comment: "Online"), style: .default, handler: { (_) in
    //            self.status.text = NSLocalizedString("Online", comment: "Online")
    //            self._status = "on"
    //        }))
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Close"), style: .cancel, handler: { (_) in
    //            print("User click Dismiss button")
    //        }))
    //        self.present(alert, animated: true, completion: {
    //            print("completion block")
    //        })
    //    }
    
    //    func displayProfile(){
    //        let alert = UIAlertController(title: "", message: NSLocalizedString("Profile Picture", comment: "Profile Picture"), preferredStyle: .actionSheet)
    //
    //        alert.setValue(NSAttributedString(string: alert.message ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
    //
    //        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Close"), style: .cancel, handler: { (_) in
    //            print("User click Dismiss button")
    //        }))
    //        self.present(alert, animated: true, completion: {
    //            print("completion block")
    //        })
    //    }
    @IBAction func singleRelationShipButtonClick(_ sender: Any) {
        self.allRelationship.backgroundColor = .white
        self.RelationshipcommitedButton.backgroundColor = .white
        self.singleRelationshipButton.backgroundColor = UIColor.bgMain
        self.singleRelationshipButton.setTitleColor(UIColor.mainColor, for: .normal)
        self.allRelationship.setTitleColor(.black, for: .normal)
        self.RelationshipcommitedButton.setTitleColor(.black, for: .normal)
        self._status = "Single"
    }
    
    @IBAction func applyFilterButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
//        self.delegate?.filterSearch(gender: self.gender ?? "",
//                                    countryId: self.countryId ?? "",
//                                    ageTo: self.age_to ?? "",
//                                    ageFrom: self.age_from ?? "",
//                                    verified: self.verify ?? "",
//                                    status: self._status ?? "",
//                                    profilePic: "",
//                                    filterByAge:self.filterbyage ?? "")
        
        self.filterSearch?.getFilterData(gender: gender ?? "All",
                                         _status: userStatus,
                                         distnce:"\(distanceSlider.value)" ,
                                         relationships: _status ?? "All")
    }
        
    // MARK: - All IBAction's for this UIViewController
    @IBAction func distanceSliderClick(_ sender: Any) {
        self.view.endEditing(true)
        
        let slider = sender as? UISlider
        let value = round(slider?.value ?? Float())
        self.valuteCountKMLabel.text = "\(value)km"
        self.distance = "\(value)"
    }
    
    @IBAction func RelationshipAllButton(_ sender: UIButton) {
        self.allRelationship.backgroundColor = UIColor.bgMain
        self.allRelationship.setTitleColor(UIColor.mainColor, for: .normal)
        self.singleRelationshipButton.backgroundColor = .white
        self.RelationshipcommitedButton.backgroundColor = .white
        self.RelationshipcommitedButton.setTitleColor(.black, for: .normal)
        self.singleRelationshipButton.setTitleColor(.black, for: .normal)
        self._status = "relationship"
    }
    
    @IBAction func RelationshipcommitedButtonClick(_ sender: Any) {
        self.allRelationship.backgroundColor = .white
        self.singleRelationshipButton.backgroundColor = .white
        self.RelationshipcommitedButton.backgroundColor = UIColor.bgMain
        self.RelationshipcommitedButton.setTitleColor(UIColor.mainColor, for: .normal)
        self.allRelationship.setTitleColor(.black, for: .normal)
        self.singleRelationshipButton.setTitleColor(.black, for: .normal)
        self._status = "Commited"
    }
    
    @IBAction func onlineSatutesButtonClick(_ sender: Any) {
        self.allSatutsButton.backgroundColor = .white
        self.offineStutesButton.backgroundColor = .white
        self.onlineStatusButton.backgroundColor = UIColor.bgMain
        self.onlineStatusButton.setTitleColor(UIColor.mainColor, for: .normal)
        self.offineStutesButton.setTitleColor(.black, for: .normal)
        self.allSatutsButton.setTitleColor(.black, for: .normal)
        self.userStatus = "online"
    }
    
    @IBAction func offineButtonClick(_ sender: UIButton) {
        self.allSatutsButton.backgroundColor = .white
        self.onlineStatusButton.backgroundColor = .white
        self.offineStutesButton.backgroundColor = UIColor.bgMain
        self.offineStutesButton.setTitleColor(UIColor.mainColor, for: .normal)
        self.allSatutsButton.setTitleColor(.black, for: .normal)
        self.onlineStatusButton.setTitleColor(.black, for: .normal)
        self.userStatus = "offine"
    }
    
    @IBAction func allStutesClick(_ sender: Any) {
        self.allSatutsButton.backgroundColor = UIColor.bgMain
        self.allSatutsButton.setTitleColor(UIColor.mainColor, for: .normal)
        self.onlineStatusButton.backgroundColor = .white
        self.offineStutesButton.backgroundColor = .white
        self.offineStutesButton.setTitleColor(.black, for: .normal)
        self.onlineStatusButton.setTitleColor(.black, for: .normal)
        self.userStatus = "all"
    }
    
    @IBAction func Gender(_ sender: UIButton) {
        if (sender.tag == 0){
            self.all.backgroundColor = UIColor.bgMain
            self.all.setTitleColor(UIColor.mainColor, for: .normal)
            self.male.backgroundColor = .white
            self.female.backgroundColor = .white
            self.female.setTitleColor(.black, for: .normal)
            self.male.setTitleColor(.black, for: .normal)
            self.gender = "all"
        }
        else if (sender.tag == 1){
            self.all.backgroundColor = .white
            self.male.backgroundColor = .white
            self.female.backgroundColor = UIColor.bgMain
            self.female.setTitleColor(UIColor.mainColor, for: .normal)
            self.all.setTitleColor(.black, for: .normal)
            self.male.setTitleColor(.black, for: .normal)
            self.gender = "female"
        }
        else  {
            self.all.backgroundColor = .white
            self.female.backgroundColor = .white
            self.male.backgroundColor = UIColor.bgMain
            self.male.setTitleColor(UIColor.mainColor, for: .normal)
            self.all.setTitleColor(.black, for: .normal)
            self.female.setTitleColor(.black, for: .normal)
            self.gender = "male"
        }
    }
    
    @IBAction func Filter(_ sender: Any) {
        self.dismiss(animated: true) {
            //            self.delegate?.filterSearch(gender: self.gender ?? "", countryId: self.countryId ?? "", ageTo: self.age_to ?? "", ageFrom: self.age_from ?? "", verified: self.verify ?? "", status: self._status ?? "", profilePic: self.profilePicture.text ?? "",filterByAge:self.filterbyage ?? "")
        }
        //        let userInfo =  ["gender": self.gender ?? "","country": self.countryId ?? "","verified": self.verify ?? "","status": self._status ?? "","profilePic": self.profilePicture.text!,"filterbyage": self.filterbyage ?? "","age_from":self.age_from ?? "", "age_to": self.age_to ?? "","keyword": ""] as [String : Any]
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadFilterData"), object: nil, userInfo: userInfo)
        //        self.dismiss(animated: true, completion: nil)
    }
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        let min = String(format: "%i",Int(selectedMinimum))
        let max = String(format: "%i",Int(selectedMaximum))
        self.ageLabel.text = "\("Age ")\(min)\(" - ")\(max)"
        self.age_from = min
        self.age_to = max
    }
    
    func locationSearch(location: String, countryId: String) {
        //        self.location.text = location
        self.countryId = countryId
    }
}

extension SearchFilterVC: SearchDelegate {
    func filterSearch(gender: String, countryId: String, ageTo: String, ageFrom: String, verified: String, status: String, profilePic: String, filterByAge: String) {}
}

