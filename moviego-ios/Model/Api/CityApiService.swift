//
//  CityApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Alamofire

struct City: Codable, Equatable {
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let pictureId: String
    let cinemaCount: Int
}

protocol CityApiServicing {
    func fetchCities() -> Single<[City]>
}

class MockedCityApiService: CityApiServicing {
    
    func fetchCities() -> Single<[City]> {
        return Single.just(
            [
                City(id: 1, name: "Prague", pictureId: "cities/bg-city-prague", cinemaCount: 2),
                City(id: 2, name: "Berlin", pictureId: "cities/bg-city-berlin", cinemaCount: 4),
                City(id: 3, name: "Paris", pictureId: "cities/bg-city-paris", cinemaCount: 3)
            ]
        ).delay(2, scheduler: MainScheduler.instance)
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
