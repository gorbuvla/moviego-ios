//
//  Showtime.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 02/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

struct Showtime: Codable {
    let type: String
    let startsAt: Date
    let cinema: Cinema
    let movie: Movie
}
