//
//  RelationshipViewController.swift
//  WoWonder
//
//  Created by UnikApp on 17/12/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol RelationshipDelegate {
    func RelationshipSeleted(type: String)
}

class RelationshipViewController: UIViewController {

    @IBOutlet weak var mainview: UIView!
    
    var delegate: RelationshipDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mainview.clipsToBounds = true
        self.mainview.layer.cornerRadius = 25
        self.mainview.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    

    @IBAction func nonButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.RelationshipSeleted(type: "Non")
    }
    
    @IBAction func singleButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.RelationshipSeleted(type: "Single")
    }

    
    @IBAction func reationshipButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.RelationshipSeleted(type: "Reationship")
    }

    
    @IBAction func MarriedButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.RelationshipSeleted(type: "Married")
    }

    
    @IBAction func EngagedButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.RelationshipSeleted(type: "Engaged")
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
