//
//  RxState.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

extension State {
    
    init?(event: Event<Value>) {
        switch event {
        case .next(let value):
            self = .value(value)
        case .error(let error):
            self = .error(error)
        default:
            return nil
        }
    }
}

extension ObservableType {
    
    func mapState() -> Observable<State<Element>> {
        return materialize()
            .compactMap(State.init)
            .startWith(State.loading)
    }
}

extension ObservableType where Element: StateConvertible {
    
    var loading: Observable<Bool> {
        get { return self.map { $0.state.isLoading } }
    }
    
    var data: Observable<Element.SValue> {
        get { return compactMap { $0.state.value } }
    }
    
    var error: Observable<Error> {
        get { return compactMap { $0.state.error } }
    }
}

typealias StateObservable<Value> = Observable<State<Value>>
