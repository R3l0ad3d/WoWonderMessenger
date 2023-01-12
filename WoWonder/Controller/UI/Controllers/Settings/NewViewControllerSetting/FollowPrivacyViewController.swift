//
//  FollowPrivacyViewController.swift
//  WoWonder
//
//  Created by UnikApp on 08/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol FollowPrivacyDelegate {
    func ButtonClick(name: String)
}

class FollowPrivacyViewController: UIViewController {

    @IBOutlet weak var eveyoneButton: UIButton!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var Viewmain: UIView!
    
    var delagate: FollowPrivacyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Viewmain.clipsToBounds = true
        self.Viewmain.layer.cornerRadius = 25
        self.Viewmain.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func eveyoneButtonClick (_ sender: Any) {
        self.dismiss(animated: true)
        self.delagate?.ButtonClick(name: "Everyone")
    }
    
    @IBAction func peopleButtonClick (_ sender: Any) {
        self.dismiss(animated: true)
        self.delagate?.ButtonClick(name: "People i Follow")
    }

}
