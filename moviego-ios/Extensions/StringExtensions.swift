//
//  StringExtensions.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 19/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

extension Optional where Wrapped == String {
    
    var emptyOrNull: Bool {
        get { return self == .none || self?.isEmpty ?? true }
    }
}
