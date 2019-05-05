//
//  Movie.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 02/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

struct Movie: Codable {
    let title: String
    let year: String
    let imdbRating: Float
    let imdbId: String
    let rottenTomatoesRating: String
    let plot: String
    let poster: String
    let release: String
    let trailer: String
    let director: Person
    let actors: [Person]
}

struct Person: Codable {
    let name: String
}
