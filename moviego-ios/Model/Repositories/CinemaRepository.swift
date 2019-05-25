//
//  CinemaRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Foundation

protocol CinemaRepositoring {
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]>
    
    func fetchMovies(offset: Int, limit: Int) -> Single<[Movie]>
    func fetchSessions(startingFrom: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]>
}

class MockedCinemaRepository: CinemaRepositoring {
    
    private let ccAndel = Cinema(
        id: 1,
        name: "CinemaCity Andel",
        address: "Andel Praha 5",
        lat: 50.0741409,
        lng: 14.4025448,
        website: "https://cinemacity.cz/",
        topMovies: []
    )
    
    private let ccChodov = Cinema(
        id: 2,
        name: "CinemaCity Chodov",
        address: "Chodov Praha 4",
        lat: 50.0304824,
        lng: 14.4885782,
        website: "https://cinemacity.cz/",
        topMovies: []
    )
    
    private let csAndel = Cinema(
        id: 3,
        name: "CineStar Andel",
        address: "Andel Praha 5",
        lat: 50.071116,
        lng: 14.3996753,
        website: "https://cinestar.cz/",
        topMovies: []
    )
    
    private let rhapsody = Movie(
        title: "Bohemian Rhapsody",
        year: "2018",
        imdbRating: 8.3,
        imdbId: "tt1727824",
        rottenTomatoesRating: "83%",
        plot: "The story of the legendary rock music band Queen and its lead singer Freddie Mercury.",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BNDg2NjIxMDUyNF5BMl5BanBnXkFtZTgwMzEzNTE1NTM@._V1_SX300.jpg")!,
        release: "02 Nov 2018",
        trailer: "https://www.youtube.com/watch?v=mP0VHJYFOAU",
        director: Person(name: "Bryan Singer"),
        actors: "Rami Malek, Lucy Boynton, Gwilym Lee, Ben Hardy".components(separatedBy: ", ").map { Person(name: $0) }
    )
    
    private let atomicBlonde = Movie(
        title: "Atomic Blonde",
        year: "2017",
        imdbRating: 6.7,
        imdbId: "tt2406566",
        rottenTomatoesRating: "78%",
        plot: "An undercover MI6 agent is sent to Berlin during the Cold War to investigate the murder of a fellow agent and recover a missing list of double agents.",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMjM5NDYzMzg5N15BMl5BanBnXkFtZTgwOTM2NDU1MjI@._V1_SX300.jpg")!,
        release: "28 Jul 2017",
        trailer: "https://www.youtube.com/watch?v=yIUube1pSC0",
        director: Person(name: "David Leitch"),
        actors: "Charlize Theron, James McAvoy, Eddie Marsan, John Goodman".components(separatedBy: ", ").map { Person(name: $0) }
    )
    
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        return Single.just([csAndel, ccAndel, ccChodov]).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
    
    func fetchMovies(offset: Int, limit: Int) -> Single<[Movie]> {
        return Single.just([rhapsody, atomicBlonde]).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
    
    func fetchSessions(startingFrom: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]> {
        
        let results = [ccAndel, ccChodov, csAndel]
            .flatMap { cinema in [rhapsody, atomicBlonde].map { movie in (cinema, movie) } }
            .map { cinema, movie in
                Session(type: "2D", startsAt: Date(), cinema: cinema, movie: movie)
            }

        return Single.just(results).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
}

class CinemaRepository {
    
    private let cinemaApi: CinemaApiServicing
    
    init(cinemaApi: CinemaApiServicing) {
        self.cinemaApi = cinemaApi
    }
    
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        return cinemaApi.fetchByDistance(lat: lat, lng: lng, radius: radius)
    }
}
