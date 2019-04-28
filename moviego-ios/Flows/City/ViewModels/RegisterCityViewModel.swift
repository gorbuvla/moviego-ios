//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation


class RegisterCityViewModel: BaseViewModel, CitySelectModeling {
    private let cityApi: CityApiServicing
    private let repository: RegistrationRepositoring
    
    init(cityApi: CityApiServicing, repository: RegistrationRepositoring) {
        self.cityApi = cityApi
        self.repository = repository
    }
}
