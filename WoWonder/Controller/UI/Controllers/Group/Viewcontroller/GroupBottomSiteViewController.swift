//
//  GroupBottomSiteViewController.swift
//  WoWonder
//
//  Created by UnikApp on 19/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol GroupBottomSiteDelegte: AnyObject {
    func passingdata(_ viewController:GroupBottomSiteViewController,
                     indexpath: Int,
                     nameof: String,
                     isBack: IndexPath)
}

class GroupBottomSiteViewController: UIViewController {
    
    var delegate: GroupBottomSiteDelegte?
    var isChat = true
    var indexpath = 0
    var nameof = ""
    var isBack = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}
