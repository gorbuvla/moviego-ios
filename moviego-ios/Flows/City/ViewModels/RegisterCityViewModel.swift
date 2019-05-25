//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxCocoa

class RegisterCityViewModel: ChooseCityViewModel {
    
    private var repository: RegistrationRepositoring
    
    init(cityApi: CityApiServicing, repository: RegistrationRepositoring) {
        self.repository = repository
        super.init(cityApi: cityApi)
    }
    
    override func saveSelection(_ city: City) -> Single<City> {
        repository.city = city
        return super.saveSelection(city)
    }
}
