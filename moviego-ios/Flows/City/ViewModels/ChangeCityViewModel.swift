//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

class ChangeCityViewModel: ChooseCityViewModel {
    
    private let repository: UserRepositoring
    
    init(cityApi: CityApiServicing, repository: UserRepositoring) {
        self.repository = repository
        super.init(cityApi: cityApi)
    }
    
    override func saveSelection(_ city: City) -> Single<City> {
        return repository.changeCity(to: city)
            .asObservable()
            .asSingle() // double jackie chan meme
            .map { _ in city }
    }
}
