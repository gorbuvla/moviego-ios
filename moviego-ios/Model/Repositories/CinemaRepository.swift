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
    func fetchMovies(for cinema: Cinema, offset: Int, limit: Int) -> Single<[Movie]>
    func fetchSessions(startingFrom: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]>
    func fetchPromotions() -> Single<[Promotion]>
}

class MockedCinemaRepository: CinemaRepositoring {
    
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
    
    private let spiderMan = Movie(
        title: "Spider-Man: Far from Home",
        year: "2019",
        imdbRating: 8.0,
        imdbId: "tt6320628",
        rottenTomatoesRating: "90%",
        plot: "Following the events of Avengers: Endgame, Spider-Man must step up to take on new threats in a world that has changed forever.",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BNmFkYjkzZmUtYjJiYi00NDU1LTk4MjktNzc3ZmU2YjhiYzBhXkEyXkFqcGdeQXVyOTI5MTk1MjU@._V1_SY1000_SX675_AL_.jpg")!,
        release: "2019",
        trailer: "https://www.youtube.com/watch?v=Nt9L1jCKGnE",
        director: Person(name: "Jon Watts"),
        actors: [Person(name: "Tom Holland"), Person(name: "Jake Gyllenhaal")]
    )
    
    private let casinoRoyale = Movie(
        title: "Casino Royale",
        year: "2006",
        imdbRating: 8.0,
        imdbId: "tt0381061",
        rottenTomatoesRating: "90%",
        plot: "Armed with a license to kill, Secret Agent James Bond sets out on his first mission as 007, and must defeat a private banker to terrorists in a high stakes game of poker at Casino Royale, Montenegro, but things are not what they seem.",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMDI5ZWJhOWItYTlhOC00YWNhLTlkNzctNDU5YTI1M2E1MWZhXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SY1000_CR0,0,672,1000_AL_.jpg")!,
        release: "2006",
        trailer: "https://www.youtube.com/watch?v=36mnx8dBbGE",
        director: Person(name: "Martin Campbell"),
        actors: [Person(name: "Daniel Craig"), Person(name: "Mads Mikkelsen")]
    )
    
    private let ccAndel = Cinema(
        id: 1,
        name: "CinemaCity Andel",
        address: "Andel Praha 5",
        lat: 50.0741409,
        lng: 14.4025448,
        thumnailId: nil,
        website: "https://cinemacity.cz/",
        topMovies: [Movie(
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
            )]
    )
    
    private let ccChodov = Cinema(
        id: 2,
        name: "CinemaCity Chodov",
        address: "Chodov Praha 4",
        lat: 50.0304824,
        lng: 14.4885782,
        thumnailId: nil,
        website: "https://cinemacity.cz/",
        topMovies: [Movie(
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
            ), Movie(
                title: "Casino Royale",
                year: "2006",
                imdbRating: 8.0,
                imdbId: "tt0381061",
                rottenTomatoesRating: "90%",
                plot: "Armed with a license to kill, Secret Agent James Bond sets out on his first mission as 007, and must defeat a private banker to terrorists in a high stakes game of poker at Casino Royale, Montenegro, but things are not what they seem.",
                poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMDI5ZWJhOWItYTlhOC00YWNhLTlkNzctNDU5YTI1M2E1MWZhXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SY1000_CR0,0,672,1000_AL_.jpg")!,
                release: "2006",
                trailer: "https://www.youtube.com/watch?v=36mnx8dBbGE",
                director: Person(name: "Martin Campbell"),
                actors: [Person(name: "Daniel Craig"), Person(name: "Mads Mikkelsen")]
            )
]
    )
    
    private let csAndel = Cinema(
        id: 3,
        name: "CineStar Andel",
        address: "Andel Praha 5",
        lat: 50.071116,
        lng: 14.3996753,
        thumnailId: nil,
        website: "https://cinestar.cz/",
        topMovies: [Movie(
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
            ), Movie(
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
            ),  Movie(
                title: "Spider-Man: Far from Home",
                year: "2019",
                imdbRating: 8.0,
                imdbId: "tt6320628",
                rottenTomatoesRating: "90%",
                plot: "Following the events of Avengers: Endgame, Spider-Man must step up to take on new threats in a world that has changed forever.",
                poster: URL(string: "https://m.media-amazon.com/images/M/MV5BNmFkYjkzZmUtYjJiYi00NDU1LTk4MjktNzc3ZmU2YjhiYzBhXkEyXkFqcGdeQXVyOTI5MTk1MjU@._V1_SY1000_SX675_AL_.jpg")!,
                release: "2019",
                trailer: "https://www.youtube.com/watch?v=Nt9L1jCKGnE",
                director: Person(name: "Jon Watts"),
                actors: [Person(name: "Tom Holland"), Person(name: "Jake Gyllenhaal")]
            )
]
    )
    
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        return Single.just([csAndel, ccAndel, ccChodov]).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
    
    func fetchMovies(offset: Int, limit: Int) -> Single<[Movie]> {
        let list = Array(repeating: [rhapsody, atomicBlonde, spiderMan, casinoRoyale], count: 15).flatMap { $0 }
        if offset == list.count { return Single.just([]) }
        
        let slice = list[offset..<(offset+limit)]
        print("Return slice of size: \(slice.count) offset: \(offset) limit: \(limit)")
        return Single.just(Array(slice)).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
    
    func fetchMovies(for cinema: Cinema, offset: Int, limit: Int) -> Single<[Movie]> {
        return fetchMovies(offset: offset, limit: limit)
    }
    
    func fetchSessions(startingFrom: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]> {
        
        let results = [ccAndel, ccChodov, csAndel]
            .flatMap { cinema in [rhapsody, atomicBlonde, spiderMan, casinoRoyale].map { movie in (cinema, movie) } }
            .map { cinema, movie in
                Session(type: "2D", startsAt: Date(), cinema: cinema, movie: movie)
            }

        return Single.just(results).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
    
    func fetchPromotions() -> Single<[Promotion]> {
        print("fetch")
        return Single.just([
            Promotion(id: 1, lat: 50.086537, lng: 14.411172, iconId: "promotions/ic_spider_man", pulseColor: "", thumbnailId: "promotions/thumbnail_spiderslav", description: "Spider man finds himself in Prague. Walking past a shop with hm... traditional Czech Matreshkas he notices Charles Bridge which will bee closed for the next 40 years.", movie: spiderMan),
            Promotion(id: 2, lat: 50.0943222, lng: 14.4417161, iconId: "promotions/ic_casino_royale", pulseColor: "", thumbnailId: "promotions/casino_royale_danube", description: "James Bond, as always, while taking rest from his romantic adventures comes to Danube House to kill a traitor, but finds himself locked in the elevator and there is no slečna recepční who may help him...", movie: casinoRoyale)
        ])
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
