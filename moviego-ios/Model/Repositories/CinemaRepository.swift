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
    func fetchCinema(for movie: Movie) -> Single<[Cinema]>
    
    func fetchMovie(id: Int) -> Single<Movie>
    func fetchMovies(offset: Int, limit: Int) -> Single<[Movie]>
    func fetchMovies(for cinema: Cinema, offset: Int, limit: Int) -> Single<[Movie]>
    
    func fetchSessions(startingFrom: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]>
    func fetchSessions(for movie: Movie, in cinema: Cinema, startingAt: Date) -> Single<[Session]>
    
    func fetchPromotions() -> Single<[Promotion]>
}

class CinemaRepository: CinemaRepositoring {
    
    private let cinemaApi: CinemaApiService
    private let movieApi: MovieApiService
    private let sessionApi: SessionApiService
    private let promotionApi: PromotionApiService
    
    init(cinemaApi: CinemaApiService,
         movieApi: MovieApiService,
         sessionApi: SessionApiService,
         promotionApi: PromotionApiService
    ) {
        self.cinemaApi = cinemaApi
        self.movieApi = movieApi
        self.sessionApi = sessionApi
        self.promotionApi = promotionApi
    }
    
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        return cinemaApi.fetchMovies(lat: lat, lng: lng, radius: radius)
    }
    
    func fetchCinema(for movie: Movie) -> Single<[Cinema]> {
        return cinemaApi.fetchMovies(movieId: movie.id)
    }
    
    func fetchMovie(id: Int) -> Single<Movie> {
        return movieApi.fetchMovie(id)
    }
    
    func fetchMovies(offset: Int, limit: Int) -> Single<[Movie]> {
        return movieApi.fetchMovies(offset: offset, limit: limit)
    }
    
    func fetchMovies(for cinema: Cinema, offset: Int, limit: Int) -> Single<[Movie]> {
        return movieApi.fetchMovies(for: cinema.id, offset: offset, limit: limit)
    }
    
    func fetchSessions(startingFrom: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]> {
        return sessionApi.fetchSessions(startingAt: startingFrom, lat: lat, lng: lng, limit: limit, offset: offset)
    }
    
    func fetchSessions(for movie: Movie, in cinema: Cinema, startingAt: Date) -> Single<[Session]> {
        return sessionApi.fetchSessions(movieId: movie.id, cinemaId: cinema.id, startingAt: startingAt)
    }
    
    func fetchPromotions() -> Single<[Promotion]> {
        return promotionApi.fetchPromotions()
    }
}
