//
//  GroupBottomMoreVC.swift
//  WoWonder
//
//  Created by UnikApp on 06/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol GroupBottomMoreData {
    func groupBottomClick(name: String)
}


class GroupBottomMoreVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    var delegate: GroupBottomMoreData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mainView.clipsToBounds = true
        self.mainView.layer.cornerRadius = 25
        self.mainView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func backButtonClickButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
        
    }
    
    @IBAction func addmembersButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
        self.delegate?.groupBottomClick(name: "Update")
        
    }
    
    @IBAction func groupinfoButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
        self.delegate?.groupBottomClick(name: "GroupInfo")
        

    }
    
    @IBAction func ExitGroupButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
        self.delegate?.groupBottomClick(name: "Exit")
    }
    

}
