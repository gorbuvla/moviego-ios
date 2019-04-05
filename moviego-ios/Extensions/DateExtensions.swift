//
//  DateExtensions.swift
//  moviego-ios
//
//  Created by Vlad on 04/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

extension Date {
 
    static var currentTimeMillis: Int {
        get { return Int(Date().timeIntervalSince1970 * 1000) }
    }
}
