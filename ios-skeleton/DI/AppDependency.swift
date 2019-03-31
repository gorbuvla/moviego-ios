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
    lazy var authApiService: ApiServicing = AuthApiService(network: self.network, credentialsProvider: UserDefaults.defaultStore)
    
    // api services
    lazy var transactionsApi: TransactionApiServicing = TransactionApiService(api: self.apiService)
    
    // repositories
    lazy var userRepository: UserRepositoring = MockedUserRepository(credentialsStore: UserDefaults.defaultStore)
    lazy var transactionRepository: TransactionRepositoring = TransactionRepository(apiService: self.transactionsApi)
}

let dependencies = AppDependency()
