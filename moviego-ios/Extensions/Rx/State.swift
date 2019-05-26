//
//  State.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

enum State<Element> {
    case loading
    case loaded(Element)
    case error(Error)
}

extension State {
    
    init?(event: Event<Element>) {
        switch event {
        case .next(let value):
            self = .loaded(value)
        case .error(let error):
            self = .error(error)
        default:
            return nil
        }
    }
}

infix operator ~=
infix operator ~==

extension State {
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var isValue: Bool {
        switch self {
        case .loaded(_): return true
        default: return false
        }
    }
    
    var isError: Bool {
        switch self {
        case .error(_): return true
        default: return false
        }
    }
    
    var value: Element? {
        switch self {
        case .loaded(let value): return value
        default: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .error(let error): return error
        default: return nil
        }
    }
}

protocol StateConvertible {
    associatedtype Value
    
    var state: State<Value> { get }
}

extension State: StateConvertible {
    typealias Value = Element
    
    var state: State<Element> {
        return self
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
    
    var value: Observable<Element.Value> {
        get { return compactMap { $0.state.value } }
    }
    
    var error: Observable<Error> {
        get { return compactMap { $0.state.error } }
    }
}

fileprivate struct NoneWrap<E> {
    let value: E
}

typealias StateObservable<Value> = Observable<State<Value>>
