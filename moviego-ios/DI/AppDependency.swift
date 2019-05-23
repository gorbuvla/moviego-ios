//
//  AppDependency.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//
import Foundation

final class AppDependency {
    
    // networking
    lazy var network: Network = Network()
    lazy var apiInteractor: ApiInteracting = ApiInteractor(network: self.network)
    lazy var authApiInteractor: ApiInteracting = AuthApiInteractor(network: self.network, credentialsStore: UserDefaults.defaultStore, factory: { credentials in self.oauthApi.refreshToken(credentials: credentials) })
    
    // api services
    lazy var oauthApi: OAuthApiServicing = OAuthApiService(interactor: self.apiInteractor)
    lazy var cityApi: CityApiServicing = MockedCityApiService()
    lazy var cinemaApi: CinemaApiServicing = CinemaApiService(interactor: self.authApiInteractor)
    
    // repositories
    lazy var registrationRepository: RegistrationRepositoring = RegistrationRepository()
    lazy var userRepository: UserRepositoring = MockedUserRepository(credentialsStore: UserDefaults.defaultStore)
    lazy var sessionRepository: SessionRepositoring = MockedSessionRepository()
    lazy var cinemaRepository: CinemaRepositoring = MockedCinemaRepository()
}

let dependencies = AppDependency()
