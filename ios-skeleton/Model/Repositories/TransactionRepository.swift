//
//  TransactionRepository.swift
//  ios-skeleton
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
    
    func getTransaction(id: Int) -> Single<Transaction>
}

class TransactionRepository: TransactionRepositoring {
    
    typealias Dependency = HasNoDependency
    
    init(dependencies: Dependency) {
        // init networking & stuff
    }
    
    func getTransactions() -> Single<[Transaction]> {
        return Single.just((0...20).map { Transaction(id: $0, amountInAccountCurrency: 124 * $0, direction: .incoming)})
    }
    
    func getTransaction(id: Int) -> Single<Transaction> {
        return Single.just(Transaction(id: id, amountInAccountCurrency: 124 * id, direction: .incoming))
    }
}
