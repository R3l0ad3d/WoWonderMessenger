//
//  MoreBottonViewController.swift
//  WoWonder
//
//  Created by Mac on 17/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol MoreBottonDelegate {
    func clickIndex(IndexCllick: String?)
}

class MoreBottonViewController: UIViewController {

    @IBOutlet weak var moreTableView: UITableView!
    
    var moreArray: [MoreModel] = []
    var delegate: MoreBottonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpScreenUI()
    }
    
    func setUpScreenUI() {
        let XIB = UINib(nibName: "BottonSetCell", bundle: nil)
        self.moreTableView.register(XIB, forCellReuseIdentifier: "BottonSetCell")
        
        self.moreArray = MoredummyData()
    }
}


extension MoreBottonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "BottonSetCell") as? BottonSetCell
        self.moreTableViewSetData(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }

    func moreTableViewSetData(cell: BottonSetCell?, indexPath: IndexPath) {
        let objmore = moreArray[indexPath.row]
        cell?.titleNameLabel.text = objmore.name
        cell?.moreimageView.image = UIImage(named: objmore.moreImage)?.withRenderingMode(.alwaysTemplate)
        
        let objColor = UserDefaults.standard.value(forKey: "ColorTheme")
        
        if objColor as? String != "" {
            cell?.moreimageView.tintColor = UIColor.hexStringToUIColor(hex: objColor as? String ?? "")
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.dismiss(animated: true)
            self.delegate?.clickIndex(IndexCllick: "0")
                    
        } else if indexPath.row == 1 {
            self.dismiss(animated: true)
            self.delegate?.clickIndex(IndexCllick: "1")
            
        } else if indexPath.row == 2 {
            self.dismiss(animated: true)
            self.delegate?.clickIndex(IndexCllick: "2")
            
        } else if indexPath.row == 3 {
            self.dismiss(animated: true)
            self.delegate?.clickIndex(IndexCllick: "3")
            
        } else if indexPath.row == 4 {
            self.dismiss(animated: true)
            self.delegate?.clickIndex(IndexCllick: "4")
            
        } else if indexPath.row == 5 {
            self.dismiss(animated: true)
            self.delegate?.clickIndex(IndexCllick: "5")
            
        }
    }
}
