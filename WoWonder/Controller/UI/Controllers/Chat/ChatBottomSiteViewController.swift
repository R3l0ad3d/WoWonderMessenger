//
//  ChatBottomSiteViewController.swift
//  WoWonder
//
//  Created by Fs on 29/09/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit


protocol passiBottomArrayDelegate: AnyObject {
    func passingdata(_ viewController:ChatBottomSiteViewController,
                     indexpath: Int,
                     nameof: String,
                     isBack: IndexPath)
}
class ChatBottomSiteViewController: UIViewController {
    
    @IBOutlet weak var infoicone: UIImageView!
    @IBOutlet weak var deleteiconeImageview: UIImageView!
    @IBOutlet weak var replayicone: UIImageView!
    @IBOutlet weak var forworadicone: UIImageView!
    @IBOutlet weak var pinicone: UIImageView!
    @IBOutlet weak var staricone: UIImageView!
    
    var ChatBottomSiteArray: [ChatBottomSite] = []
    var delegate: passiBottomArrayDelegate?
    var isChat = true
    var indexpath = 0
    var nameof = ""
    var isBack = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        
        if objColor as? String != "" {
            self.infoicone.image = UIImage(systemName: "info.circle.fill")?.withRenderingMode(.alwaysTemplate)
            self.infoicone.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
            
            self.deleteiconeImageview.image = UIImage(named:  "delete")?.withRenderingMode(.alwaysTemplate)
            self.deleteiconeImageview.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
            
            self.replayicone.image = UIImage(systemName: "arrowshape.turn.up.backward.fill")?.withRenderingMode(.alwaysTemplate)
            self.replayicone.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
            
            self.forworadicone.image = UIImage(systemName: "arrowshape.turn.up.forward.fill")?.withRenderingMode(.alwaysTemplate)
            self.forworadicone.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
            
            self.pinicone.image = UIImage(systemName: "pin.fill")?.withRenderingMode(.alwaysTemplate)
            self.pinicone.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
            
            self.staricone.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            self.staricone.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func downButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func messageinfo(_ sender: Any) {
        self.nameof = "0"
        self.dismiss(animated: true)
        self.delegate?.passingdata(self, indexpath: 0, nameof: nameof, isBack: isBack)
    }
    
    @IBAction func deleteMessaage(_ sender: Any) {
        self.nameof = "1"
        self.dismiss(animated: true)
        self.delegate?.passingdata(self, indexpath: 1, nameof: nameof, isBack: isBack)
    }
    
    @IBAction func replayMassage(_ sender: Any) {
        self.nameof = "2"
        self.dismiss(animated: true)
        self.delegate?.passingdata(self, indexpath: 2, nameof: nameof, isBack: isBack)
    }
    
    @IBAction func ForwardMessage(_ sender: Any) {
        self.nameof = "3"
        self.delegate?.passingdata(self, indexpath: 3, nameof: nameof, isBack: isBack)
        self.dismiss(animated: true)
    }
    
    @IBAction func PinMessage(_ sender: Any) {
        self.nameof = "4"
        self.delegate?.passingdata(self, indexpath: 4, nameof: nameof, isBack: isBack)
        self.dismiss(animated: true)
    }
    
    @IBAction func FavMessage(_ sender: Any) {
        self.nameof = "5"
        self.delegate?.passingdata(self, indexpath: 5, nameof: nameof, isBack: isBack)
        self.dismiss(animated: true)
    }
    
}
