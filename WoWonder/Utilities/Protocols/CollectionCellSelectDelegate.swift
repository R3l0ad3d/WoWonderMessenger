//
//  CollectionRadioButtonCellDelegate.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 25/11/2020.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionCellSelectDelegate: AnyObject {
    func onCellSelected(_ selectedCell: UICollectionViewCell, object: Any)
}
