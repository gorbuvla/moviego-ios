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
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchTransactions() -> Single<TransactionListResponse> {
        return interactor.request("/transactions", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: TransactionListResponse.self)
            .asSingle()
    }
    
    func fetchTransaction(id: Int) -> Single<TransactionInfoResponse> {
        return interactor.request("/transaction/\(id)", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: TransactionInfoResponse.self)
            .asSingle()
    }
}
