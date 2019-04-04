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
    lazy var apiInteractor: ApiInteracting = ApiInteractor(network: self.network)
    lazy var authApiInteractor: ApiInteracting = AuthApiInteractor(network: self.network, credentialsStore: UserDefaults.defaultStore, factory: { credentials in self.oauthApi.refreshToken(credentials: credentials) })
    
    // api services
    lazy var oauthApi: OAuthApiServicing = OAuthApiService(interactor: self.apiInteractor)
    lazy var transactionsApi: TransactionApiServicing = TransactionApiService(interactor: self.apiInteractor) // no auth
    
    // repositories
    lazy var userRepository: UserRepositoring = MockedUserRepository(credentialsStore: UserDefaults.defaultStore)
    lazy var transactionRepository: TransactionRepositoring = TransactionRepository(apiService: self.transactionsApi)
}

let dependencies = AppDependency()
