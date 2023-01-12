//
//  StoryBottomViewController.swift
//  WoWonder
//
//  Created by UnikApp on 13/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol StoryBottomdDelegate {
    func nameClick(name: String)
}

class StoryBottomViewController: UIViewController {

    @IBOutlet weak var Viewmain: UIView!
    
    var delegate: StoryBottomdDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Viewmain.clipsToBounds = true
        self.Viewmain.layer.cornerRadius = 25
        self.Viewmain.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func textClickStory(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.nameClick(name: "Text")
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func ImageStory(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.nameClick(name: "Image")
    }
    
    @IBAction func VideoStory(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.nameClick(name: "Video")
    }
    

}
