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

protocol ProfileViewModelFactories {
    var profileViewModel: () -> ProfileViewModel { get }
}

protocol RegistrationViewModelFactories {
    var userRegistrationViewModelFactory: (RegistrationRepository) -> RegisterUserViewModel { get }
    var registerCityViewModelFactory: (RegistrationRepository) -> RegisterCityViewModel { get }
}

typealias ViewModelFactory = HasViewModelFactories & RegistrationViewModelFactories & ProfileViewModelFactories

extension AppDependency: ViewModelFactory {
    
    var loginViewModelFactory: () -> LoginViewModel {
        return { LoginViewModel(repository: dependencies.userRepository) }
    }
    
    var userRegistrationViewModelFactory: (RegistrationRepository) -> RegisterUserViewModel {
        return { registrationRepository in
            RegisterUserViewModel(repository: registrationRepository, userRepository: dependencies.userRepository)
        }
    }
    
    var registerCityViewModelFactory: (RegistrationRepository) -> RegisterCityViewModel {
        return { registrationRepository in
            RegisterCityViewModel(cityApi: dependencies.cityApi, repository: registrationRepository)
        }
    }
    
    var showtimeListViewModelFactory: () -> SessionSearchViewModel {
        return {
            SessionSearchViewModel(
                showtimeRepository: dependencies.cinemaRepository, userRepository: dependencies.userRepository
            )
        }
    }
    
    var sessionDetailViewModelFactory: (Movie, Cinema, [Session]?) -> SessionDetailViewModel {
        return { movie, cinema, sessions in
            SessionDetailViewModel(
                movie: movie, cinema: cinema, sessions: sessions
            )
        }
    }
    
    var dashboardViewModelFactory: () -> DashboardViewModel {
        return { DashboardViewModel(repository: dependencies.cinemaRepository) }
    }
    
    var cinemaMapViewModel: () -> CinemaMapViewModel {
        return { CinemaMapViewModel(repository: dependencies.cinemaRepository) }
    }
    
    var profileViewModel: () -> ProfileViewModel {
        return { ProfileViewModel() }
    }
}
