//
//  ChangerColorViewController.swift
//  WoWonder
//
//  Created by Mac on 17/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol changeColor {
    func chagerColor(hex: String)
}

class ChangerColorViewController: UIViewController {
    
    //MARK: - All  @IBOutlet This VIew Controller
    
    @IBOutlet weak var Viewmain: UIView!
    @IBOutlet weak var backView: UIControl!
    
    @IBOutlet weak var oneColourButton: UIControl!
    @IBOutlet weak var twoColourButton: UIControl!
    @IBOutlet weak var threeColourButton: UIControl!
    @IBOutlet weak var fourColourButton: UIControl!
    @IBOutlet weak var fiveColourButton: UIControl!
    @IBOutlet weak var sixColourButton: UIControl!
    @IBOutlet weak var sevenColourButton: UIControl!
    @IBOutlet weak var eightColourButton: UIControl!
    @IBOutlet weak var nineColourButton: UIControl!
    @IBOutlet weak var tenColourButton: UIControl!
    @IBOutlet weak var elevenColourButton: UIControl!
    @IBOutlet weak var twelveColourButton: UIControl!
    @IBOutlet weak var thirteenColourButton: UIControl!
    @IBOutlet weak var fourteenColourButton: UIControl!
    @IBOutlet weak var fifteenColourButton: UIControl!
    @IBOutlet weak var sixteenColourButton: UIControl!
    @IBOutlet weak var seventeenColourButton: UIControl!
    @IBOutlet weak var eighteenColourButton: UIControl!
    @IBOutlet weak var nineteenColourButton: UIControl!
    @IBOutlet weak var twentyColourButton: UIControl!
    @IBOutlet weak var twentyoneColourButton: UIControl!
    @IBOutlet weak var twentytwoColourButton: UIControl!
    @IBOutlet weak var twentythreeColourButton: UIControl!
    @IBOutlet weak var twentyfourColourButton: UIControl!
    @IBOutlet weak var cancleButton: UIControl!
    
    
    var delagete: changeColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.Viewmain.clipsToBounds = true
        self.Viewmain.layer.cornerRadius = 25
        self.Viewmain.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func BackButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func oneColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#b582af")
        
    }
    
    @IBAction func twoColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#a84849")
    }
    
    @IBAction func threeColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#a52729")
    }
    
    @IBAction func fourColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#f9c270")
    }
    
    @IBAction func fiveColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#70a0e0")
    }
    
    @IBAction func  sixColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#56c4c5")
    }

    
    @IBAction func  sevenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#f33d4c")
    }
    
    
    @IBAction func  eightColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#a1ce79")
    }
    
    @IBAction func  nineColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#a085e2")
    }
    
    @IBAction func tenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        
        self.delagete?.chagerColor(hex: "#ed9e6a")
    }
    
    @IBAction func elevenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        
        self.delagete?.chagerColor(hex: "#2b87ce")
    }
    
    @IBAction func twelveColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#f2812b")
    }
    
    @IBAction func thirteenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#0ba05d")
    }
    
    @IBAction func fourteenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#0e71ea")
    }
    
    @IBAction func fifteenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#aa2294")
    }
    
    @IBAction func sixteenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#f9a722")
    }
    
    @IBAction func seventeenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#008484")
    }
    
    @IBAction func eighteenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#5462a5")
    }
    
    @IBAction func nineteenColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#fc9cde")
    }
    
    @IBAction func twentyColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#51bcbc")
    }
    
    @IBAction func twentyoneColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#51bcbc")
    }
    
    @IBAction func twentytwoColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#01a5a5")
    }
    
    @IBAction func twentythreeColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#056bba")
    }
    
    @IBAction func twentyfourColourButtonclick(_ sender: UIControl) {
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#C83747")
    }
    
    @IBAction func cancleButton(_ sender: UIControl) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
}
