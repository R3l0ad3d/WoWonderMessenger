//


import UIKit
import Async

class ManageSessionTableItem: UITableViewCell {
    
    @IBOutlet weak var crossBtn: UIControl!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var lastSeenlabel: UILabel!
    @IBOutlet weak var browserLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var object : SessionModel.Datum?
    
    var singleCharacter :String?
    var indexPath:Int? = 0
    var vc: ManageSessionVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.backgroundColor = .mainColor
        self.crossBtn.backgroundColor = .mainColor
//        self.crossBtn.backgroundColor = .ButtonColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func bind(_ object:SessionModel.Datum, index:Int){
        self.object = object
        self.indexPath = index
        
        self.phoneLabel.text = "Phone : \(object.platform ?? "")"
        self.phoneLabel.text = "Browser : \(object.browser ?? "")"
        self.phoneLabel.text = "Last seen : \(object.time ?? "")"
        if object.browser == nil{
            self.alphaLabel.text = self.singleCharacter ?? ""
        }else{
            for (index, value) in (object.browser?.enumerated())!{
                if index == 0{
                    self.singleCharacter = String(value)
                    break
                }
            }
            self.alphaLabel.text = self.singleCharacter ?? ""
        }
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.deleteSession()
        
    }
    private func deleteSession(){
        let id = self.object?.id ?? ""
        
        let sessionToken = AppInstance.instance.sessionId ?? ""
        
        Async.background({
            SessionManager.instance.deleteSession(session_Token: sessionToken, type: "delete", id: id) { (success, sessionError, serverError, error) in
                if success != nil{
                    Async.main({
                        
                        self.vc?.sessionArray.remove(at: self.indexPath ?? 0)
                        self.vc?.tableView.reloadData()
                        
                        
                    })
                }else if sessionError != nil{
                    Async.main({
                        
                        self.vc!.view.makeToast(sessionError?.errors?.errorText ?? "")
                        log.error("sessionError = \(sessionError?.errors?.errorText ?? "")")
                        
                        
                    })
                }else if serverError != nil{
                    Async.main({
                        
                        self.vc!.view.makeToast(serverError?.errors?.errorText ?? "")
                        log.error("serverError = \(serverError?.errors?.errorText ?? "")")
                        
                        
                    })
                    
                }else {
                    Async.main({
                        
                        self.vc!.view.makeToast(error?.localizedDescription ?? "")
                        log.error("error = \(error?.localizedDescription ?? "")")
                        
                    })
                }
            }
            
        })
        
    }
    
}
