//
//  TransactionApiService.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol TransactionApiServicing {
    
    func fetchTransactions() -> Single<TransactionListResponse>
    func fetchTransaction(id: Int) -> Single<TransactionInfoResponse>
}

final class TransactionApiService: TransactionApiServicing {
    private let api: ApiServicing
    
    init(api: ApiServicing) {
        self.api = api
    }
    
    func fetchTransactions() -> Single<TransactionListResponse> {
        return api.request("/transactions", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: [:])
            .mapObject(to: TransactionListResponse.self)
            .asSingle()
    }
    
    func fetchTransaction(id: Int) -> Single<TransactionInfoResponse> {
        return api.request("/transaction/\(id)", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: [:])
            .mapObject(to: TransactionInfoResponse.self)
            .asSingle()
    }
}
