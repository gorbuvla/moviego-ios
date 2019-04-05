//
//  TransactionRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift

protocol HasTransactionManaging {
    var transactionRepository: TransactionRepositoring { get }
}

protocol TransactionRepositoring {
    
    func getTransactions() -> Single<[Transaction]>
    
    func getTransaction(id: Int) -> Single<TransactionInfo>
}

// Mocked repository with fake data for testing
class MockedTransactionRepository: TransactionRepositoring {
    
    func getTransactions() -> Single<[Transaction]> {
        return Single.just((0...20).map { Transaction(id: $0, amountInAccountCurrency: 124 * $0, direction: .incoming)})
    }
    
    func getTransaction(id: Int) -> Single<TransactionInfo> {
        return Single.just(TransactionInfo(accountNumber: "1011", accountName: "BU", bankCode: "123"))
    }
}

class TransactionRepository: TransactionRepositoring {
    
    private let apiService: TransactionApiServicing
    
    init(apiService: TransactionApiServicing) {
        self.apiService = apiService
    }
    
    func getTransactions() -> Single<[Transaction]> {
        return apiService.fetchTransactions()
            .map { $0.items }
    }
    
    func getTransaction(id: Int) -> Single<TransactionInfo> {
        return apiService.fetchTransaction(id: id)
            .map { $0.contraAccount }
    }
}
