//
//  OAuthApiService.swift
//  moviego-ios
//
//  Created by Vlad on 04/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol OAuthApiServicing {
    func login(email: String, password: String) -> Single<UserWithCredentials>
    func register(credentials: RegisterCredentials) -> Single<UserWithCredentials>
    func refreshToken(credentials: Credentials) -> Single<Credentials>
}

class OAuthApiService: OAuthApiServicing {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func login(email: String, password: String) -> Single<UserWithCredentials> {
        let params = ["email": email, "password": password]
        return interactor.request("/auth/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: UserWithCredentials.self)
            .asSingle()
    }
    
    func register(credentials: RegisterCredentials) -> Single<UserWithCredentials> {
        // TODO: some cool way to decode object to parameters
        return interactor.request("/auth/register", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: UserWithCredentials.self)
            .asSingle()
    }
    
    func refreshToken(credentials: Credentials) -> Single<Credentials> {
        return interactor.request("/auth/refresh", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: Credentials.self)
            .asSingle()
    }
}
