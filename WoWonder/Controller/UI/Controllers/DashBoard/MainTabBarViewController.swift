//
//  MainTabBarViewController.swift
//  WoWonder
//
//  Created by Mohammed Hamad on 19/07/2022.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Back"
        self.addButtons()
    }
    
    //MARK: - SetNavigactionBar Title Color
    public func addButtons() {
        let location = UIBarButtonItem(image: .ic_location_home,
                                       style: .plain,
                                       target: self,
                                       action: #selector(self.location(_:)))

        let search = UIBarButtonItem(image: .ic_search_home,
                                     style: .plain,
                                     target: self,
                                     action: #selector(self.search(_:)))

        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItems = [
            location,
            search,
        ]
    }
    
    @objc private func location(_ sender: UIBarButtonItem) {
        let vc = R.storyboard.dashboard.searchLocationVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc private func search(_ sender: UIBarButtonItem) {
        let vc = R.storyboard.dashboard.searchRandomVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setUpscreenUI() {
        
    }
    
    
}

