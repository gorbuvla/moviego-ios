//
//  OAuthApiService.swift
//  ios-skeleton
//
//  Created by Vlad on 04/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol OAuthApiServicing {
    func login(credentials: LoginCredentials) -> Single<UserWithCredentials>
    func register(credentials: RegisterCredentials) -> Single<UserWithCredentials>
    func refreshToken(credentials: Credentials) -> Single<Credentials>
}

class OAuthApiService: OAuthApiServicing {
    
    private let apiService: ApiService
    
    init(apiService: ApiServicing) {
        self.apiService = apiService
    }
    
    func login(credentials: LoginCredentials) -> Single<UserWithCredentials> {
        return apiService.request("/login", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: UserWithCredentials.self)
            .asSingle()
    }
    
    func register(credentials: RegisterCredentials) -> Single<UserWithCredentials> {
        // TODO: some cool way to decode object to parameters
        return apiService.request("/register", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: UserWithCredentials.self)
            .asSingle()
    }
    
    func refreshToken(credentials: Credentials) -> Single<Credentials> {
        return apiService.request("/refresh", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: Credentials.self)
            .asSingle()
    }
}
