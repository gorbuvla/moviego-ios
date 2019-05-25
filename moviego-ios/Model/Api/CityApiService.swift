//
//  CityApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Alamofire

protocol CityApiServicing {
    func fetchCities() -> Single<[City]>
}

class MockedCityApiService: CityApiServicing {
    
    func fetchCities() -> Single<[City]> {
        return Single.just(
            [
                City(id: 1, name: "Prague", pictureId: "cities/bg-city-prague", cinemasCount: 2),
                City(id: 2, name: "Berlin", pictureId: "cities/bg-city-berlin", cinemasCount: 4),
                City(id: 3, name: "Paris", pictureId: "cities/bg-city-paris", cinemasCount: 3)
            ]
        ).delay(1, scheduler: MainScheduler.instance)
    }
}

class CityApiService: CityApiServicing {
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchCities() -> Single<[City]> {
        return interactor.request("/cities", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [City].self)
            .asSingle()
    }
}
