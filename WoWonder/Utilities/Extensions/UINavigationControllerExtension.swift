//
//  UIImageViewExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 8/30/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    public func getPreviousView() -> UIViewController {
        let viewsInNavigation = self.viewControllers
        return viewsInNavigation[viewsInNavigation.count - 2]
    }
    
    public func popTo(_ viewClass: AnyClass, onFailure: VoidCompletion? = nil) {
        let check = checkViewIfExists(viewClass)
        if check.isExists {
            self.popToViewController(self.viewControllers[check.index], animated: true)
        } else {
            onFailure?()
        }
    }
    
    public func checkViewIfExists(_ viewClass: AnyClass) -> (isExists: Bool, index: Int) {
        for (index, controller) in self.viewControllers.enumerated() {
            if controller.isKind(of: viewClass) {
                return (true, index)
            }
        }
        return (false, -1)
    }
}

