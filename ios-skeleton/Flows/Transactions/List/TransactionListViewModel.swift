//
//  TransactionListViewModel.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TransactionListViewModel: BaseViewModel {
    
    private let repository: TransactionRepositoring
    private let viewStateVariable: Variable<LoadingResult<[Transaction]>> = Variable(.init(true))
    
    var viewState: Observable<LoadingResult<[Transaction]>> {
        get { return viewStateVariable.asObservable() }
    }
    
    // try to come with a better approach
    var data: [Transaction]? {
        get { return viewStateVariable.value.data?.element }
    }
    
    init(repository: TransactionRepositoring) {
        self.repository = repository
        super.init()
        
        fetchTransactions()
    }
    
    private func fetchTransactions() {
        repository.getTransactions().asObservable()
            .mapLoading()
            .filter { ev in !(ev.data?.isStopEvent ?? false) } // do it better...
            .bind(to: viewStateVariable)
            .disposed(by: disposeBag)
    }
}
