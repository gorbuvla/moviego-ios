//
//  PagedFetcher.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxRelay

//
// Helper class to perform paged requests.
//
final class PagedFetcher<T> {
    private let DEFAULT_PAGE_LIMIT = 10
    private let disposeBag = DisposeBag()
    private let pagerRelay = BehaviorRelay<[T]>(value: [])
    private let request: (Int, Int) -> Single<[T]>
    
    private(set) var canFetchMore: Bool = true
    
    var pagedResult: Observable<[T]> {
        return pagerRelay.asObservable().skip(1) // TODO: whats up?
    }
    
    init(request: @escaping (Int, Int) -> Single<[T]>) {
        self.request = request
    }
    
    func fetchInitial() {
        request(0, DEFAULT_PAGE_LIMIT).asObservable()
            .bind(to: pagerRelay)
            .disposed(by: disposeBag)
    }
    
    func fetchNext() {
        request(pagerRelay.value.count, DEFAULT_PAGE_LIMIT)
            .do(onSuccess: { page in self.canFetchMore = page.count == self.DEFAULT_PAGE_LIMIT })
            .map { page in self.pagerRelay.value + page }
            .asObservable()
            .bind(to: pagerRelay)
            .disposed(by: disposeBag)
    }
}
