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
    func login(credentials: LoginCredentials) -> Single<UserWithCredentials>
    func register(credentials: RegisterCredentials) -> Single<UserWithCredentials>
    func refreshToken(credentials: Credentials) -> Single<Credentials>
}

class OAuthApiService: OAuthApiServicing {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func login(credentials: LoginCredentials) -> Single<UserWithCredentials> {
        return interactor.request("/login", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: UserWithCredentials.self)
            .asSingle()
    }
    
    func register(credentials: RegisterCredentials) -> Single<UserWithCredentials> {
        // TODO: some cool way to decode object to parameters
        return interactor.request("/register", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: UserWithCredentials.self)
            .asSingle()
    }
    
    func refreshToken(credentials: Credentials) -> Single<Credentials> {
        return interactor.request("/refresh", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: Credentials.self)
            .asSingle()
    }
}
