//
//  UITableViewExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 02/04/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        self.register(cell, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.reuseIdentifier, bundle: .main), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ cell: T.Type) {
        self.register(cell, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ headerFooter: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func setOffsetToBottom(animated: Bool) {
        self.setContentOffset(CGPoint(x: 0, y: (self.contentSize.height - self.frame.size.height)), animated: animated)
    }
    
    func scrollToLastRow(animated: Bool, section: Int = 0) {
        if self.numberOfRows(inSection: section) > 0 {
            self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: section) - 1, section: 0),
                             at: .bottom,
                             animated: animated)
        }
    }
}
