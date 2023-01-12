//
//  MessagePrivacyViewController.swift
//  WoWonder
//
//  Created by UnikApp on 08/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol MessagePrivacyDelegate {
    func ButtonClickName(name: String)
}

class MessagePrivacyViewController: UIViewController {

    @IBOutlet weak var eveyoneButton: UIButton!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var nobodyButton: UIButton!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var Viewmain: UIView!
    
    var delagate: MessagePrivacyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Viewmain.clipsToBounds = true
        self.Viewmain.layer.cornerRadius = 25
        self.Viewmain.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func eveyoneButtonClick (_ sender: Any) {
        self.dismiss(animated: true)
        self.delagate?.ButtonClickName(name: "Everyone")
    }
    
    @IBAction func peopleButtonClick (_ sender: Any) {
        self.dismiss(animated: true)
        self.delagate?.ButtonClickName(name: "People i Follow")
    }
        
    @IBAction func nobodyButtonClick (_ sender: Any) {
        self.dismiss(animated: true)
        self.delagate?.ButtonClickName(name: "Nobody")
    }
    
}
