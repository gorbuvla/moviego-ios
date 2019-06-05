//
//  Promotion.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import CoreLocation

// TODO: add model name, movie promotion is for, etc...
struct Promotion: Codable, Equatable {
    let id: Int
    let lat: Double
    let lng: Double
    let iconId: String
    let pulseColor: String // UIColor or CGColor ?
    let thumbnailId: String
    let description: String
    let movie: Movie
    
    static func == (lhs: Promotion, rhs: Promotion) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Promotion {
    
    var location: CLLocation {
        get { return CLLocation(latitude: lat, longitude: lng) }
    }
}
