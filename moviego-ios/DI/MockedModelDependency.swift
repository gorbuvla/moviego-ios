//
//  MockedModelDependency.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 25/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

final class MockedModelDependency: ModelProvider {
    
    static var shared: ModelProvider = {
        MockedModelDependency()
    }()
    
    private init() {}
    
    lazy var userRepository: UserRepositoring = MockedUserRepository(credentialsStore: UserDefaults.defaultStore)
    lazy var cityRepository: CityRepositoring = MockedCityRepository()
    lazy var cinemaRepository: CinemaRepositoring = MockedCinemaRepository()
}
