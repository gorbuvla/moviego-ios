//
//  CityRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 25/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

protocol CityRepositoring {
    func fetchCities() -> Single<[City]>
}

final class CityRepository: CityRepositoring {
    
    private let cityApi: CityApiService
    
    init(cityApi: CityApiService) {
        self.cityApi = cityApi
    }
    
    func fetchCities() -> Single<[City]> {
        return cityApi.fetchCities()
    }
}
