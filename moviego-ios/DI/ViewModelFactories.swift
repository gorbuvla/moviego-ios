//
//  ViewModelFactories.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol HasViewModelFactories {
    
    var transactionListViewModelFactory: () -> TransactionListViewModel { get }
}

protocol RegistrationViewModelFactories {
    var registerNameViewModelFactory: () -> RegisterNameViewModel { get }
    var registerCityViewModelFactory: () -> RegisterCityViewModel { get }
}

protocol ProfileViewModelFactories {
    var profileViewModel: () -> ProfileViewModel { get }
}

typealias ViewModelFactory = HasViewModelFactories & RegistrationViewModelFactories & ProfileViewModelFactories

extension AppDependency: ViewModelFactory {
    
    var transactionListViewModelFactory: () -> TransactionListViewModel {
        return { TransactionListViewModel(repository: dependencies.transactionRepository) }
    }
    
    var loginViewModelFactory: () -> LoginViewModel {
        return { LoginViewModel(repository: dependencies.userRepository) }
    }
    
    var registerNameViewModelFactory: () -> RegisterNameViewModel {
        return { RegisterNameViewModel(repository: dependencies.registrationRepository) }
    }
    
    var registerCityViewModelFactory: () -> RegisterCityViewModel {
        return { RegisterCityViewModel(repository: dependencies.registrationRepository) }
    }
    
    var movieListViewModelFactory: () -> MovieListViewModel {
        return { MovieListViewModel() }
    }
    
    var promotionListViewModelFactory: () -> PromotionListViewModel {
        return { PromotionListViewModel() }
    }
    
    var profileViewModel: () -> ProfileViewModel {
        return { ProfileViewModel() }
    }
}
