//
//  StringExtensions.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 19/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import MapKit

extension Optional where Wrapped == String {
    
    var emptyOrNull: Bool {
        get { return self == .none || self?.isEmpty ?? true }
    }
}

extension MKDistanceFormatter {
    
    static var shared: MKDistanceFormatter = {
        return MKDistanceFormatter()
    }()
}
