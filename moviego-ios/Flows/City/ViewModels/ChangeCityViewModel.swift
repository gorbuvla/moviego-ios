//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

// TODO: unfinished viewModel for changing user preferred city.
class ChangeCityViewModel: ChooseCityViewModel {
    
    private let userRepository: UserRepositoring
    
    init(cityRepository: CityRepository, userRepository: UserRepositoring) {
        self.userRepository = userRepository
        super.init(cityRepository: cityRepository)
    }
    
    override func saveSelection(_ city: City) -> Single<City> {
        return userRepository.changeCity(to: city)
            .asObservable()
            .asSingle() // double jackie chan meme
            .map { _ in city }
    }
}
