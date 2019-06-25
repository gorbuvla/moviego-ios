//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxCocoa

//
// ViewModel for choosing city in registration process.
//
class RegisterCityViewModel: ChooseCityViewModel {
    
    private var registrationRepository: RegistrationRepositoring
    
    init(cityRepository: CityRepositoring, registrationRepository: RegistrationRepositoring) {
        self.registrationRepository = registrationRepository
        super.init(cityRepository: cityRepository)
    }
    
    override func saveSelection(_ city: City) -> Single<City> {
        registrationRepository.city = city
        return super.saveSelection(city)
    }
}
