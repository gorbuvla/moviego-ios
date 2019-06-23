//
//  Showtime.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 02/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

struct Session: Codable {
    let type: SessionType
    let startsAt: Date
    let cinema: Cinema
    let movie: Movie
}

struct SessionSearchItem: Codable {
    let cinema: Cinema
    let movie: Movie
    let showtimes: [Session]
}

enum SessionType: String, Codable, CaseIterable {
    case D2 = "2D"
    case D3 = "3D"
    case IMAX = "IMAX"
    case DX4 = "4DX"
}

enum SessionOrderBy: String {
    case time = "time"
    case nearestCinema = "nearestCinema"
}
