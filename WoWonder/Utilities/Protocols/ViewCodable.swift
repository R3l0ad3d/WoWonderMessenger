//
//  ViewCodable.swift
//  EMS
//
//  Created by Mohammed Hamad on 25/08/2021.
//

import Foundation

public protocol ViewCodable {
    
    func buildHierarchy()
    
    func setupConstraints()
    
    func applyAdditionalChanges()
}

public extension ViewCodable {
    
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func buildHierarchy() {}
    
    func setupConstraints() {}
    
    func applyAdditionalChanges() {}
}
