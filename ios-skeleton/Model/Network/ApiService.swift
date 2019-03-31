//
//  ApiService.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol ApiServicing {
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String:Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)>
}

class ApiService: ApiServicing {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String : Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)> {
        return network.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}

class AuthApiService: ApiServicing {
    
    private let network: Network
    private let credentialsProvider: CredentialsProvider
    
    private var authHeader: Observable<HTTPHeaders> { return Observable.just(credentialsProvider.credentials.map { ["Authorization": "Bearer " + $0.accessToken] } ?? [:]) }
    
    init(network: Network, credentialsProvider: CredentialsProvider) {
        self.network = network
        self.credentialsProvider = credentialsProvider
    }
    
    func request(_ url: RequestURL, method: HTTPMethod, parameters: [String : Any]?, encoding: ParameterEncoding, headers: HTTPHeaders? = [:]) -> Observable<(HTTPURLResponse, Data)> {
        return authHeader.map { $0 + headers! }
            .flatMap { [unowned network] in network.request(url, method: method, parameters: parameters, encoding: encoding, headers: $0) }
    }
}


extension ObservableType where E == (HTTPURLResponse, Data) {
    public func mapObject<T: Codable>(to type: T.Type) -> Observable<T> {
        return map { (response, data) -> T in
            try! JSONDecoder().decode(T.self, from: data)
        }
    }
}
