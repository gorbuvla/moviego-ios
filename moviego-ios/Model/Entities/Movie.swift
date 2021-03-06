//
//  Movie.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 02/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let year: String
    let imdbRating: Float
    let imdbId: String
    let rottenTomatoesRating: String
    let plot: String
    let poster: URL
    let thumbnailId: String
    let release: String
    let trailer: String
}
