//
//  ChageTextColorViewController.swift
//  WoWonder
//
//  Created by UnikApp on 14/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

class ChageTextColorViewController: UIViewController {

    //MARK: - All  @IBOutlet This VIew Controller
    
    @IBOutlet weak var Viewmain: UIView!
    @IBOutlet weak var liteBuleButton: UIControl!
    @IBOutlet weak var orangeButton: UIControl!
    @IBOutlet weak var pinkButton: UIControl!
    @IBOutlet weak var yelloButton: UIControl!
    @IBOutlet weak var darkBuleButton: UIControl!
    @IBOutlet weak var greeenDarkButton: UIControl!
    @IBOutlet weak var greenButton: UIControl!
    @IBOutlet weak var blackButton: UIControl!
    @IBOutlet weak var buleButton: UIControl!
    @IBOutlet weak var redButton: UIControl!
    @IBOutlet weak var backView: UIControl!
    @IBOutlet weak var litewhiteButton: UIControl!
    @IBOutlet weak var balckButton: UIControl!
    
    var delagete: changeColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.Viewmain.clipsToBounds = true
        self.Viewmain.layer.cornerRadius = 25
        self.Viewmain.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    @IBAction func BackButtonClick(_ sender: UIControl) {
        self.dismiss(animated: true)
    }
    
    @IBAction func redButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.white.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.white.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.white.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.white.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.white.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.white.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.white.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.white.cgColor
        self.buleButton.layer.borderWidth = 0
        self.buleButton.layer.borderColor = UIColor.white.cgColor
        self.redButton.layer.borderWidth = 1
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "C83747")
    }
    
    @IBAction func orangeButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 1
        self.pinkButton.layer.borderWidth = 0
        self.yelloButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.greenButton.layer.borderWidth = 0
        self.blackButton.layer.borderWidth = 0
        self.buleButton.layer.borderWidth = 0
        self.redButton.layer.borderWidth = 0
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "ED7440")
    }
    
    @IBAction func pinkButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.orangeButton.layer.borderWidth = 0
        self.pinkButton.layer.borderWidth = 1
        self.pinkButton.layer.borderColor = UIColor.white.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.greenButton.layer.borderWidth = 0
        self.blackButton.layer.borderWidth = 0
        self.buleButton.layer.borderWidth = 0
        self.redButton.layer.borderWidth = 0
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "F03568")
    }
    
    @IBAction func yelloButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.orangeButton.layer.borderWidth = 0
        self.pinkButton.layer.borderWidth = 0
        self.yelloButton.layer.borderWidth = 1
        self.yelloButton.layer.borderColor = UIColor.white.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.greenButton.layer.borderWidth = 0
        self.blackButton.layer.borderWidth = 0
        self.buleButton.layer.borderWidth = 0
        self.redButton.layer.borderWidth = 0
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "FB991C")
    }
    
    @IBAction func darkButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.orangeButton.layer.borderWidth = 0
        self.pinkButton.layer.borderWidth = 0
        self.yelloButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderWidth = 1
        self.darkBuleButton.layer.borderColor = UIColor.white.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greenButton.layer.borderWidth = 0
        self.blackButton.layer.borderWidth = 0
        self.buleButton.layer.borderWidth = 0
        self.redButton.layer.borderWidth = 0
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "022539")
    }
//    
//    @IBAction func purpleButtonClick(_ sender: UIControl) {
//        self.view.endEditing(true)
//        self.liteBuleButton.layer.borderWidth = 0
//        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
//        self.orangeButton.layer.borderWidth = 0
//        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
//        self.pinkButton.layer.borderWidth = 0
//        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
//        self.yelloButton.layer.borderWidth = 0
//        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
//        self.darkBuleButton.layer.borderWidth = 0
//        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
//        self.greeenDarkButton.layer.borderWidth = 1
//        self.greeenDarkButton.layer.borderColor = UIColor.white.cgColor
//        self.greenButton.layer.borderWidth = 0
//        self.greenButton.layer.borderColor = UIColor.gray.cgColor
//        self.blackButton.layer.borderWidth = 0
//        self.blackButton.layer.borderColor = UIColor.gray.cgColor
//        self.buleButton.layer.borderWidth = 0
//        self.buleButton.layer.borderColor = UIColor.gray.cgColor
//        self.redButton.layer.borderWidth = 0
//        self.redButton.layer.borderColor = UIColor.gray.cgColor
//        self.litewhiteButton.layer.borderWidth = 0
//        self.greeenDarkButton.layer.borderWidth = 0
//        self.balckButton.layer.borderWidth = 0
//        self.liteBuleButton.layer.borderWidth = 0
//        self.dismiss(animated: true)
//        self.delagete?.chagerColor(hex: "833CA2")
//    }
    
    @IBAction func greenButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 1
        self.greenButton.layer.borderColor = UIColor.white.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.gray.cgColor
        self.buleButton.layer.borderWidth = 0
        self.buleButton.layer.borderColor = UIColor.gray.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "1E947A")
    }
    
    @IBAction func blackButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.gray.cgColor
        self.blackButton.layer.borderWidth = 1
        self.blackButton.layer.borderColor = UIColor.white.cgColor
        self.buleButton.layer.borderWidth = 0
        self.buleButton.layer.borderColor = UIColor.gray.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.dismiss(animated: true)
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "444B57")
    }
    
//    @IBAction func liteBuleButtonClick(_ sender: UIControl) {
//        self.view.endEditing(true)
//        self.liteBuleButton.layer.borderWidth = 1
//        self.liteBuleButton.layer.borderColor = UIColor.white.cgColor
//        self.orangeButton.layer.borderWidth = 0
//        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
//        self.pinkButton.layer.borderWidth = 0
//        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
//        self.yelloButton.layer.borderWidth = 0
//        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
//        self.darkBuleButton.layer.borderWidth = 0
//        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
//        self.greeenDarkButton.layer.borderWidth = 0
//        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
//        self.greenButton.layer.borderWidth = 0
//        self.greenButton.layer.borderColor = UIColor.gray.cgColor
//        self.blackButton.layer.borderWidth = 0
//        self.blackButton.layer.borderColor = UIColor.gray.cgColor
//        self.buleButton.layer.borderWidth = 0
//        self.buleButton.layer.borderColor = UIColor.gray.cgColor
//        self.redButton.layer.borderWidth = 0
//        self.redButton.layer.borderColor = UIColor.gray.cgColor
//        self.litewhiteButton.layer.borderWidth = 0
//        self.greeenDarkButton.layer.borderWidth = 0
//        self.balckButton.layer.borderWidth = 0
//        self.liteBuleButton.layer.borderWidth = 0
//        self.dismiss(animated: true)
//        self.delagete?.chagerColor(hex: "00AEEE")
//    }
//
    
    @IBAction func buleButtonClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.gray.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.gray.cgColor
        self.buleButton.layer.borderWidth = 1
        self.buleButton.layer.borderColor = UIColor.white.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "5C8DF5")
    }
    
    
    @IBAction func greenDarkButtonClick(_ sender: UIControl) {
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.gray.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.gray.cgColor
        self.balckButton.layer.borderWidth = 0
        self.balckButton.layer.borderColor = UIColor.white.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 1
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "06A500")
        
    }
    
    @IBAction func blackDarkButtonClick(_ sender: UIControl) {
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.gray.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.gray.cgColor
        self.balckButton.layer.borderWidth = 0
        self.balckButton.layer.borderColor = UIColor.white.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 1
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#000000")
    }
    
    @IBAction func buleDarkButtonClick(_ sender: UIControl) {
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.gray.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.gray.cgColor
        self.balckButton.layer.borderWidth = 0
        self.balckButton.layer.borderColor = UIColor.white.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 1
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#0F00FF")
    }
    
    
    @IBAction func liteWhiteButtonCLick(_ sender: UIControl) {
        self.liteBuleButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.orangeButton.layer.borderWidth = 0
        self.orangeButton.layer.borderColor = UIColor.gray.cgColor
        self.pinkButton.layer.borderWidth = 0
        self.pinkButton.layer.borderColor = UIColor.gray.cgColor
        self.yelloButton.layer.borderWidth = 0
        self.yelloButton.layer.borderColor = UIColor.gray.cgColor
        self.darkBuleButton.layer.borderWidth = 0
        self.darkBuleButton.layer.borderColor = UIColor.gray.cgColor
        self.greeenDarkButton.layer.borderWidth = 0
        self.greeenDarkButton.layer.borderColor = UIColor.gray.cgColor
        self.greenButton.layer.borderWidth = 0
        self.greenButton.layer.borderColor = UIColor.gray.cgColor
        self.blackButton.layer.borderWidth = 0
        self.blackButton.layer.borderColor = UIColor.gray.cgColor
        self.balckButton.layer.borderWidth = 0
        self.balckButton.layer.borderColor = UIColor.white.cgColor
        self.redButton.layer.borderWidth = 0
        self.redButton.layer.borderColor = UIColor.gray.cgColor
        self.litewhiteButton.layer.borderWidth = 1
        self.greeenDarkButton.layer.borderWidth = 0
        self.balckButton.layer.borderWidth = 0
        self.liteBuleButton.layer.borderWidth = 0
        self.dismiss(animated: true)
        self.delagete?.chagerColor(hex: "#C0D4F8")
    }
}
