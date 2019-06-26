//
//  AppDependency.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//
import Foundation

protocol ModelProvider {
    var userRepository: UserRepositoring { get }
    var cityRepository: CityRepositoring { get }
    var cinemaRepository: CinemaRepositoring { get }
}

final class ModelDependency: ModelProvider {
    
    static var shared: ModelProvider = {
        ModelDependency()
    }()
    
    private init() {}
    
    // networking
    lazy var network: Network = Network()
    lazy var apiInteractor: ApiInteracting = ApiInteractor(network: self.network)
    lazy var authApiInteractor: ApiInteracting = AuthApiInteractor(network: self.network, credentialsStore: UserDefaults.defaultStore, factory: { credentials in self.oauthApi.refreshToken(credentials: credentials) })
    
    // api services
    private lazy var oauthApi: OAuthApiServicing = OAuthApiService(interactor: self.apiInteractor)
    private lazy var cityApi = CityApiService(interactor: self.apiInteractor)
    private lazy var cinemaApi: CinemaApiService = CinemaApiService(interactor: self.authApiInteractor)
    private lazy var movieApi: MovieApiService = MovieApiService(interactor: self.authApiInteractor)
    private lazy var sessionApi: SessionApiService = SessionApiService(interactor: self.authApiInteractor)
    private lazy var promotionApi: PromotionApiService = PromotionApiService(interactor: self.authApiInteractor)
    
    // repositories
    lazy var userRepository: UserRepositoring = UserRepository(credentialsStore: UserDefaults.defaultStore, oauthApi: self.oauthApi)
    lazy var cityRepository: CityRepositoring = CityRepository(cityApi: self.cityApi)
    lazy var cinemaRepository: CinemaRepositoring = CinemaRepository(cinemaApi: self.cinemaApi, movieApi: self.movieApi, sessionApi: self.sessionApi, promotionApi: self.promotionApi)
}
