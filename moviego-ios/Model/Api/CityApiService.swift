//
//  CityApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Alamofire

class CityApiService {
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchCities() -> Single<[City]> {
        return interactor.request("/api/cities", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [City].self)
            .asSingle()
    }
}
