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

struct ShowtimeSearchItem: Codable {
    let cinema: Cinema
    let movie: Movie
    let showtimes: [Showtime]
}

enum ShowtimeOrderBy: String {
    case time = "time"
    case nearestCinema = "nearestCinema"
}
