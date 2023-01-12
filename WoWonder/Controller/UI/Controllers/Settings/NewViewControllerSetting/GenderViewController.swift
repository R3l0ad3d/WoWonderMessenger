//
//  GenderViewController.swift
//  WoWonder
//
//  Created by UnikApp on 05/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol genderContol {
    func genderName(Gender: String)
}

class GenderViewController: UIViewController {

    @IBOutlet weak var Viewmain: UIView!
    
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    
    
    var delegate: genderContol?
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setgender()
        // Do any additional setup after loading the view.
        
        self.Viewmain.clipsToBounds = true
        self.Viewmain.layer.cornerRadius = 25
        self.Viewmain.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    func setgender() {
        if gender == "female" {
            self.male.backgroundColor = .white
            self.female.backgroundColor = UIColor(hex: "F9EBED")
            self.female.setTitleColor(UIColor(hex: "C83747"), for: .normal)
            self.male.setTitleColor(.black, for: .normal)
        } else if gender == "male" {
            self.female.backgroundColor = .white
            self.male.backgroundColor = UIColor(hex: "F9EBED")
            self.male.setTitleColor(UIColor(hex: "C83747"), for: .normal)
            self.female.setTitleColor(.black, for: .normal)
        } else {
        }
    }
    
    @IBAction func femaleButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.male.backgroundColor = .white
        self.female.backgroundColor = UIColor(hex: "F9EBED")
        self.female.setTitleColor(UIColor(hex: "C83747"), for: .normal)        
        self.male.setTitleColor(.black, for: .normal)
        self.delegate?.genderName(Gender: "female")
        self.dismiss(animated: true)
    }
    
    @IBAction func maleButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.female.backgroundColor = .white
        self.male.backgroundColor = UIColor(hex: "F9EBED")
        self.male.setTitleColor(UIColor(hex: "C83747"), for: .normal)
        self.female.setTitleColor(.black, for: .normal)
        self.delegate?.genderName(Gender: "male")
        self.dismiss(animated: true)
    }

}
