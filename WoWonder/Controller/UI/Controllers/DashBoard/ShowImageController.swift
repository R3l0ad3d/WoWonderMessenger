//
//  ShowImageController.swift
//  WoWonder
//
//  Created by Ubaid Javaid on 7/22/20.
//  Copyright © 2020 ScriptSun. All rights reserved.
//

import UIKit
import Kingfisher

class ShowImageController: UIViewController {

    //MARK: - All IBOutlet this ViewController
     @IBOutlet weak var showimageView: UIImageView!
    
    //Variable's
      var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: imageURL)
        self.showimageView.kf.indicatorType = .activity
        self.showimageView.kf.setImage(with: url, placeholder: UIImage(named: ""))
    }
    

    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Share(_ sender: Any) {
        let textToShare = [ self.imageURL ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.assignToContact,UIActivity.ActivityType.mail,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.message,UIActivity.ActivityType.postToFlickr,UIActivity.ActivityType.postToVimeo,UIActivity.ActivityType.init(rawValue: "net.whatsapp.WhatsApp.ShareExtension"),UIActivity.ActivityType.init(rawValue: "com.google.Gmail.ShareExtension"),UIActivity.ActivityType.init(rawValue: "com.toyopagroup.picaboo.share"),UIActivity.ActivityType.init(rawValue: "com.tinyspeck.chatlyio.share")]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
