//
//  ViewCodable.swift
//  EMS
//
//  Created by Mohammed Hamad on 25/08/2021.
//

import Foundation

public protocol KeyPathSettable {}

extension KeyPathSettable {
    
    public func setting<Value>(
        _ keyPath: WritableKeyPath<Self, Value>,
        to value: Value
    ) -> Self {
        
        var mutableSelf = self
        mutableSelf[keyPath: keyPath] = value
        return mutableSelf
    }
}

extension KeyPathSettable {
    
    public func setup(_ setup: (inout Self) -> Void) -> Self {
        var mutableSelf = self
        setup(&mutableSelf)
        return mutableSelf
    }
}

extension NSObject: KeyPathSettable {}
