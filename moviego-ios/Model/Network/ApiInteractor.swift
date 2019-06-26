//
//  ApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol ApiInteracting {
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String:Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)>
}

class ApiInteractor: ApiInteracting {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String : Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)> {
        return network.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}

typealias CredentialsCallFactory = (Credentials) -> Single<Credentials>

class AuthApiInteractor: ApiInteracting {
    
    private let network: Network
    private var credentialsStore: CredentialsStore
    private let credentialsCallFactory: CredentialsCallFactory
    
    private var authHeader: Single<HTTPHeaders> {
        guard let credentials = credentialsStore.credentials else {
            print("Else guard")
            return Single.just([:]) }
        
        let source: Single<Credentials> = credentialsStore.isTokenExpired ? credentialsCallFactory(credentials).do(onSuccess: { [weak self] it in self?.credentialsStore.credentials = it }) : Single.just(credentialsStore.credentials!)
        return source.map { ["Authorization": "Bearer " + $0.accessToken] }
    }
    
    init(network: Network, credentialsStore: CredentialsStore, factory: @escaping CredentialsCallFactory) {
        self.network = network
        self.credentialsStore = credentialsStore
        self.credentialsCallFactory = factory
    }
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String : Any]?, encoding: ParameterEncoding, headers: HTTPHeaders? = [:]) -> Observable<(HTTPURLResponse, Data)> {
        // todo: on 401 repeat once
        return authHeader
            .map { $0 }.asObservable() // no .flatMapObservable() :-(
                .flatMap { [unowned network] in network.request(url, method: method, parameters: parameters, encoding: encoding, headers: $0) }
    }
}

extension ObservableType where Element == (HTTPURLResponse, Data) {
    public func mapObject<T: Codable>(to type: T.Type) -> Observable<T> {
        return map { (response, data) -> T in
            if response.statusCode == 200 {
                return try! JSONDecoder().decode(T.self, from: data)
            } else {
                throw ApiException.unauthorized
            }
            // TODO: map errors here
        }
    }
}

enum ApiException: Error {
    
    case unauthorized
}
