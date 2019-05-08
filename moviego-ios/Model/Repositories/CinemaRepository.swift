//
//  CinemaRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

protocol CinemaRepositoring {
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]>
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
    
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        return Single.just([csAndel, ccAndel, ccChodov]).delay(.seconds(3), scheduler: MainScheduler.instance)
    }
}

class CinemaRepository: CinemaRepositoring {
    
    private let cinemaApi: CinemaApiServicing
    
    init(cinemaApi: CinemaApiServicing) {
        self.cinemaApi = cinemaApi
    }
    
    func fetchCinemas(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        return cinemaApi.fetchByDistance(lat: lat, lng: lng, radius: radius)
    }
}
