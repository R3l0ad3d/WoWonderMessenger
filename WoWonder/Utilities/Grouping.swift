//
//  Group.swift
//  QPay
//
//  Created by Mohammed Hamad on 12/14/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

struct Grouping<SectionItem: Comparable&Hashable, RowItem> : Comparable {
    
    var sectionItem: SectionItem
    var rowItems: [RowItem]
    
    enum CompareType {
        case Descending
        case Ascending
    }
    
    static func toDictionary(_ items: [RowItem], by criteria: (RowItem) -> SectionItem) -> Dictionary<SectionItem, [RowItem]> {
        return Dictionary(grouping: items, by: criteria)
    }
    
    static func toGroups(_ items: [RowItem], compare: CompareType, by criteria: (RowItem) -> SectionItem) -> [Grouping<SectionItem, RowItem>] {
        
        return self.toDictionary(items, by: criteria).map { (sectionItem, rowItems) -> Grouping<SectionItem, RowItem> in
            return Grouping(sectionItem: sectionItem, rowItems: rowItems)
            
        }.sorted { (left, right) -> Bool in
            switch compare {
            case .Descending:
                return left.sectionItem > right.sectionItem
            case .Ascending:
                return left.sectionItem < right.sectionItem
            }
        }
    }
    
    static func < (lhs: Grouping<SectionItem, RowItem>, rhs: Grouping<SectionItem, RowItem>) -> Bool {
        return lhs.sectionItem < rhs.sectionItem
    }
    
    static func == (lhs: Grouping<SectionItem, RowItem>, rhs: Grouping<SectionItem, RowItem>) -> Bool {
        return lhs.sectionItem == rhs.sectionItem
    }
}
