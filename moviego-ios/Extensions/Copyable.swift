//
//  Copyable.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol Copyable {}

extension Copyable {
    
    func copy(apply: (inout Self) -> Void) -> Self {
        var c = self
        apply(&c)
        return c
    }
}
