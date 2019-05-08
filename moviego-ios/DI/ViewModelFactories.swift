//
//  ViewModelFactories.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol HasViewModelFactories {
    
}

protocol RegistrationViewModelFactories {
    var userRegistrationViewModelFactory: () -> RegisterUserViewModel { get }
    var registerPasswordViewModelFactory: () -> RegisterPasswordViewModel { get }
    var registerCityViewModelFactory: () -> RegisterCityViewModel { get }
}

protocol ProfileViewModelFactories {
    var profileViewModel: () -> ProfileViewModel { get }
}

typealias ViewModelFactory = HasViewModelFactories & RegistrationViewModelFactories & ProfileViewModelFactories

extension AppDependency: ViewModelFactory {
    
    var loginViewModelFactory: () -> LoginViewModel {
        return { LoginViewModel(repository: dependencies.userRepository) }
    }
    
    var userRegistrationViewModelFactory: () -> RegisterUserViewModel {
        return { RegisterUserViewModel(repository: dependencies.registrationRepository) }
    }
    
    var registerPasswordViewModelFactory: () -> RegisterPasswordViewModel {
        return { RegisterPasswordViewModel(repository: dependencies.registrationRepository) }
    }
    
    var registerCityViewModelFactory: () -> RegisterCityViewModel {
        return { RegisterCityViewModel(cityApi: dependencies.cityApi, repository: dependencies.registrationRepository) }
    }
    
    var showtimeListViewModelFactory: () -> ShowtimeSearchViewModel {
        return {
            ShowtimeSearchViewModel(
                showtimeRepository: dependencies.showtimeRepository,
                userRepository: dependencies.userRepository
            )
        }
    }
    
    var cinemaMapViewModel: () -> CinemaMapViewModel {
        return { CinemaMapViewModel(repository: dependencies.cinemaRepository) }
    }
    
    var promotionListViewModelFactory: () -> PromotionListViewModel {
        return { PromotionListViewModel() }
    }
    
    var profileViewModel: () -> ProfileViewModel {
        return { ProfileViewModel() }
    }
}
