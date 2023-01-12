//
//  UIViewControllerExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 8/25/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: Reusable {
    
    private var storyboardID: String? {
        return value(forKey: "storyboardIdentifier") as? String
    }
    
    public func getStoryboardView<T: UIViewController>(_ controller: T.Type) -> T {
        return UIStoryboard.getViewFromStoryboard(with: T.reuseIdentifier) as! T
    }
    
    public func openShareDialog(sender: UIView, data: [Any],
                                activityTypes: [UIActivity.ActivityType] = [UIActivity.ActivityType.message],
                                completion: ((Bool) -> Void)? = nil) {
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: data, applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = activityTypes
//        [
//            UIActivity.ActivityType.message
//            UIActivity.ActivityType.postToWeibo,
//            UIActivity.ActivityType.print,
//            UIActivity.ActivityType.assignToContact,
//            UIActivity.ActivityType.saveToCameraRoll,
//            UIActivity.ActivityType.addToReadingList,
//            UIActivity.ActivityType.postToFlickr,
//            UIActivity.ActivityType.postToVimeo,
//            UIActivity.ActivityType.postToTencentWeibo
//        ]
        
        self.present(activityViewController, animated: true)
        activityViewController.completionWithItemsHandler = { (type, isCompleted, returnedItems, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let comp = completion {
                comp(isCompleted)
            }
        }
    }
}
