
import UIKit
import WowonderMessengerSDK

class SecurityPopupVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorTextLabel: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    var errorText:String? = ""
    var titleText:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.okBtn.setTitle(NSLocalizedString("OK", comment: "OK"), for: .normal)
        self.titleLabel.text = titleText ?? "Security"
        self.errorTextLabel.text = errorText ?? "N/A"
       
    }
    

    @IBAction func okPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
