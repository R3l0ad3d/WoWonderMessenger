//
//  ConfigurableView.swift
//  ScanQR
//
//  Created by Mohammed Hamad on 21/06/2021.
//  Copyright © 2021 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableView {
    func configure(viewData: ViewData)
}

extension ConfigurableView where Self: UIView {
    func modelFor<T: ViewData>(_ type: T.Type, _ viewData: ViewData) -> T? {
        return viewData as? T
    }
}

protocol ViewData {}

//struct TitleViewData: ViewData {
//    var title: String
//    var subtitle: String
//}
//
//func configure(viewData: ViewData) {
//    guard let model = modelFor(TitleViewData.self, viewData) else { return }
//    model.title
//    model.subtitle
//}

