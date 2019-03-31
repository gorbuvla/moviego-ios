//
//  AppDependency.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation



final class AppDependency: HasTransactionManaging {
    
    // networking
    lazy var network: Network = Network()
    lazy var apiService: ApiServicing = ApiService(network: self.network)
    lazy var authApiService: ApiServicing = ApiService(network: self.network) // TODO: to be continued
    
    // api services
    lazy var transactionsApi: TransactionApiServicing = TransactionApiService(api: self.apiService)
    
    // repositories
    lazy var transactionRepository: TransactionRepositoring = TransactionRepository(apiService: self.transactionsApi)
}

let dependencies = AppDependency()


protocol HasNoDependency {}

extension AppDependency: HasNoDependency {}
