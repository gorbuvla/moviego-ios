//
//  ShowtimeRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift

protocol ShowtimeRepositoring {
    
    func fetchShowtimes(for cinema: Cinema?, movieId: Int?, startingFrom: Date, lat: Float?, lng: Float?, orderBy: ShowtimeOrderBy, limit: Int, offset: Int) -> Single<[Showtime]>
}

class MockedShowtimeRepository: ShowtimeRepositoring {
    
    func fetchShowtimes(for cinema: Cinema?, movieId: Int?, startingFrom: Date, lat: Float?, lng: Float?, orderBy: ShowtimeOrderBy, limit: Int, offset: Int) -> Single<[Showtime]> {
        let showtimeList = [Showtime(type: "Standard", startsAt: Date(), cinema: ccAndel, movie: rhapsody),
                            Showtime(type: "Standard", startsAt: Date(), cinema: ccAndel, movie: atomicBlonde)]
        
        var returnList: [Showtime] = []
        
        if offset < showtimeList.count && limit > 0 {
            returnList = showtimeList
        }
        
        return Single.just(returnList).delay(3, scheduler: MainScheduler.instance)
    }
    
    private let rhapsody = Movie(
        title: "Bohemian Rhapsody",
        year: "2018",
        imdbRating: 8.3,
        imdbId: "tt1727824",
        rottenTomatoesRating: "83%",
        plot: "The story of the legendary rock music band Queen and its lead singer Freddie Mercury.",
        poster: "https://m.media-amazon.com/images/M/MV5BNDg2NjIxMDUyNF5BMl5BanBnXkFtZTgwMzEzNTE1NTM@._V1_SX300.jpg",
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
        poster: "https://m.media-amazon.com/images/M/MV5BMjM5NDYzMzg5N15BMl5BanBnXkFtZTgwOTM2NDU1MjI@._V1_SX300.jpg",
        release: "28 Jul 2017",
        trailer: "https://www.youtube.com/watch?v=yIUube1pSC0",
        director: Person(name: "David Leitch"),
        actors: "Charlize Theron, James McAvoy, Eddie Marsan, John Goodman".components(separatedBy: ", ").map { Person(name: $0) }
    )
    
    private let ccAndel = Cinema(
        id: 1,
        name: "CinemaCity Andel",
        address: "Andel Praha 5",
        lat: 50.0741409,
        lng: 14.4025448,
        website: "https://cinemacity.cz/",
        topMovies: []
    )
}
