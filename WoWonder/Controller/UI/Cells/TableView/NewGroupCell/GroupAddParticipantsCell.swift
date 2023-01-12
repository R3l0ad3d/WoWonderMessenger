//
//  GroupAddParticipantsCell.swift
//  WoWonder
//
//  Created by Mac on 16/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit

protocol deleteParticipantDelegate{
    func deleteParticipant(index:Int,status:Bool,selectedUseArray:[AddParticipantModel])
}

class GroupAddParticipantsCell: UITableViewCell {
    
    @IBOutlet weak var cancleImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cancleView: UIControl!
    @IBOutlet weak var userSubLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var indexPath:Int? = 0
    var selectedParticipantArray = [AddParticipantModel]()
    var delegate:deleteParticipantDelegate?
    var AddPartici = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cancleImage.image = UIImage(named: "ic_cancle_group_user")?.withRenderingMode(.alwaysTemplate)
        self.cancleImage.tintColor = UIColor.mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        if AddPartici == false {
            self.selectedParticipantArray.remove(at: indexPath ?? 0)
           
            self.delegate?.deleteParticipant(index: indexPath ?? 0, status: true, selectedUseArray:self.selectedParticipantArray)
         
        } else {
            
        }
    }
    
}
