//
//  UICollectionViewExtension.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 03/04/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(cell, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeader<T: UICollectionReusableView>(_ cell: T.Type) {
        self.register(cell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderNib<T: UICollectionReusableView>(_ cell: T.Type) {
        self.register(UINib(nibName: T.reuseIdentifier, bundle: .main),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerFooter<T: UICollectionReusableView>(_ cell: T.Type) {
        self.register(cell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerFooterNib<T: UICollectionReusableView>(_ cell: T.Type) {
        self.register(UINib(nibName: T.reuseIdentifier, bundle: .main),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.reuseIdentifier, bundle: .main), forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ reusableView: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                     withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_ reusableView: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                     withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
