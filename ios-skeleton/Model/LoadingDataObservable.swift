//
//  LoadingDataObservable.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

protocol LoadingDataObservable {
    
    associatedtype ElementType
    
    var data: Event<ElementType>? { get }
    var loading: Bool { get }
}

struct LoadingResult<T>: LoadingDataObservable {
    
    let data: Event<T>?
    let loading: Bool
    
    public init(_ loading: Bool) {
        self.data = nil
        self.loading = loading
    }
    
    public init(_ data: Event<T>) {
        self.data = data
        self.loading = false
    }
}

extension ObservableType {
    
    func mapLoading() -> Observable<LoadingResult<E>> {
        return self.materialize()
            .map(LoadingResult.init)
            .startWith(LoadingResult(true))
    }
}

extension ObservableType where E: LoadingDataObservable {
    
    var loading: Observable<Bool> {
        get { return self.map { $0.loading } }
    }
    
    var data: Observable<E.ElementType> {
        get { return self.events.elements() }
    }
    
    var error: Observable<Error> {
        get { return self.events.errors() }
    }
    
    private var events: Observable<Event<E.ElementType>> {
        get { return self.filter { !$0.loading || $0.data != nil }.map { $0.data! } }
    }
}
