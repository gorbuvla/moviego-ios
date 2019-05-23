//
//  Promotion.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

// TODO: add model name, movie promotion is for, etc...
struct Promotion: Codable {
    let lat: Double
    let lng: Double
    let movie: Movie
}
