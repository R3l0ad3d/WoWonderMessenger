//
//  StoryboardNib.swift
//  WoWonder
//
//  Created by Azizur Rahman on 7/1/23.
//  Copyright © 2023 ScriptSun. All rights reserved.
//

import Foundation
import UIKit

protocol StoryBoardVC{
    static func instantiate() -> Self
}
extension StoryBoardVC where Self : UIViewController{
    static func instantiate() -> Self {
            // this pulls out "MyApp.MyViewController"
            let fullName = NSStringFromClass(self)

            // this splits by the dot and uses everything after, giving "MyViewController"
            let className = fullName.components(separatedBy: ".")[1]

            // load our storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))

            // instantiate a view controller with that identifier, and force cast as the type that was requested
            return storyboard.instantiateViewController(withIdentifier: className) as! Self
        }
}

protocol NIBVCProtocol{
    static func instantiateNib() -> Self
}
        
extension NIBVCProtocol where Self: UIViewController {
    static func instantiateNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension UICollectionViewCell{
    static var identifier : String{
        return String(describing: self)
    }
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}
extension UITableViewCell{
    static var identifier : String{
        return String(describing: self)
    }
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}
