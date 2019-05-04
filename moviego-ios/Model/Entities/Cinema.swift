//
//  Cinema.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 02/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

struct Cinema: Codable {
    let id: Int
    let name: String
    let address: String
    let lat: Double
    let lng: Double
    let website: String?
    let topMovies: [Movie]
}

struct CinemaReview: Codable {
    let rating: Float
    let note: String?
    let createdAt: Date
    let photoId: String?
    let cinema: Cinema
    let user: ServiceUser
}
