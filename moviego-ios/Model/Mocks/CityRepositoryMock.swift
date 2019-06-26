//
//  CityRepositoryMock.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 25/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

final class MockedCityRepository: CityRepositoring {
    
    func fetchCities() -> Single<[City]> {
        return Single.just(
            [
                City(id: 1, name: "Prague", pictureId: "cities/bg-city-prague", cinemasCount: 2),
                City(id: 2, name: "Berlin", pictureId: "cities/bg-city-berlin", cinemasCount: 4),
                City(id: 3, name: "Paris", pictureId: "cities/bg-city-paris", cinemasCount: 3)
            ]
            ).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
}
