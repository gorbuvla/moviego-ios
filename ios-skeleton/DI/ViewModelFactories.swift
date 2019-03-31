//
//  ViewModelFactories.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol HasViewModelFactories {
    
    var transactionListViewModelFactory: () -> TransactionListViewModel { get }
}

extension AppDependency: HasViewModelFactories {
    
    var transactionListViewModelFactory: () -> TransactionListViewModel {
        return { TransactionListViewModel(repository: dependencies.transactionRepository) }
    }
}
