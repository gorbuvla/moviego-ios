//
//  CollectionExtensions.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

func + <Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var dict: [Key: Value] = [:]
    lhs.forEach { (key, value) in dict[key] = value }
    rhs.forEach { (key, value) in dict[key] = value }
    return dict
}

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
