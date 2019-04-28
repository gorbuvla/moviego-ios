//
//  CityApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Alamofire

struct City: Codable {
    let id: Int
    let name: String
    let pictureId: String
    let citiesCount: Int
}

protocol CityApiServicing {
    func fetchCities() -> Single<[City]>
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
