//
//  ThemeViewController.swift
//  WoWonder
//
//  Created by UnikApp on 17/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol ThemeDelegate {
    func ThemeType(typeName: String)
}

class ThemeViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
        
    var delagete: ThemeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainView.clipsToBounds = true
        self.mainView.layer.cornerRadius = 25
        self.mainView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func lightButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delagete?.ThemeType(typeName: "Light")
    }
    
    @IBAction func darkButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delagete?.ThemeType(typeName: "Dark")
    }
}
