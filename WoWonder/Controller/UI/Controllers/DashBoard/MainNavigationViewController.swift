//
//  MainNavigationViewController.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 19/07/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension UIViewController {
    
    var mainNavigationController: MainNavigationViewController? {
        get {
            return self.navigationController as? MainNavigationViewController
        }
    }
}
