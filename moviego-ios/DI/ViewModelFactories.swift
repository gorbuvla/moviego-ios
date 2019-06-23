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
    var userRegistrationViewModelFactory: (RegistrationRepository) -> RegisterUserViewModel { get }
    var registerCityViewModelFactory: (RegistrationRepository) -> RegisterCityViewModel { get }
}

typealias ViewModelFactory = HasViewModelFactories & RegistrationViewModelFactories

final class ViewModelDependency: ViewModelFactory {
    
    private let dependencies: ModelDependency
    
    init(modelDependency: ModelDependency) {
        self.dependencies = modelDependency
    }
    
    var loginViewModelFactory: () -> LoginViewModel {
        return { LoginViewModel(repository: self.dependencies.userRepository) }
    }
    
    var userRegistrationViewModelFactory: (RegistrationRepository) -> RegisterUserViewModel {
        return { registrationRepository in
            RegisterUserViewModel(repository: registrationRepository, userRepository: self.dependencies.userRepository)
        }
    }
    
    var registerCityViewModelFactory: (RegistrationRepository) -> RegisterCityViewModel {
        return { registrationRepository in
            RegisterCityViewModel(cityApi: self.dependencies.cityApi, repository: registrationRepository)
        }
    }

    var dashboardViewModelFactory: () -> DashboardViewModel {
        return { DashboardViewModel(cinemaRepository: self.dependencies.cinemaRepository, userRepository: self.dependencies.userRepository) }
    }
    
    var cinemaMapViewModelFactory: () -> CinemaMapViewModel {
        return { CinemaMapViewModel(repository: self.dependencies.cinemaRepository) }
    }
    
    var cinemaDetailViewModelFactory: (Cinema) -> CinemaDetailViewModel {
        return { cinema in CinemaDetailViewModel(cinema: cinema, repository: self.dependencies.cinemaRepository) }
    }
    
    var sessionDetailViewModelFactory: (Movie, Cinema?) -> SessionDetailViewModel {
        return { movie, cinema in SessionDetailViewModel(movie: movie, cinema: cinema, cinemaRepository: self.dependencies.cinemaRepository) }
    }
}

let factories = ViewModelDependency(modelDependency: ModelDependency.shared)
