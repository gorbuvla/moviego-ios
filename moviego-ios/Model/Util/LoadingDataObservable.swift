//
//  LoadingDataObservable.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxRelay

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
    
    func mapLoadingEvent() -> Observable<LoadingResult<Element>> {
        return materialize()
            .filter { e in
                switch e {
                case .completed: return false
                default: return true
                }
            }
            .map(LoadingResult.init)
    }
    
    func mapLoading() -> Observable<LoadingResult<Element>> {
        return materialize()
            .filter { e in
                switch e {
                case .completed: return false
                default: return true
                }
            }
            .map(LoadingResult.init)
            .startWith(LoadingResult(true))
    }
}

extension ObservableType where Element: LoadingDataObservable {
    
    var loading: Observable<Bool> {
        get { return self.map { $0.loading } }
    }
    
    var data: Observable<Element.ElementType> {
        get { return self.events.elements() }
    }
    
    var error: Observable<Error> {
        get { return self.events.errors() }
    }
    
    private var events: Observable<Event<Element.ElementType>> {
        get { return self.filter { $0.data != nil }.map { $0.data! } }
    }
}

class MutableProperty<T> {
    
    private let relay: BehaviorRelay<LoadingResult<T>>
    
    var isLoading: Bool {
        get { return relay.value.loading }
        set(newValue) {
            relay.accept(LoadingResult(newValue))
        }
    }
    
    var data: T? {
        get { return relay.value.data?.element }
        set(newValue) {
            guard let value = newValue else { return }
            relay.accept(LoadingResult(.next(value)))
        }
    }
    
    init() {
        relay = BehaviorRelay(value: LoadingResult(false))
    }
    
    init(value: T) {
        relay = BehaviorRelay(value: LoadingResult(.next(value)))
    }
    
    func on(event: LoadingResult<T>) {
        
    }
    
    func asObservable() -> ObservableProperty<T> {
        return relay.asObservable()
    }
}


// 1. computed property of optional current value
typealias ObservableProperty<T> = Observable<LoadingResult<T>>

//protocol ObservableProperty {
//
//    associatedtype T
//
//    var loading: Observable<Bool> { get }
//
//    var data: Observable<T> { get }
//
//    var error: Observable<Error> { get }
//}
//
//protocol MutableProperty: ObservableProperty {
//
//    associatedtype T
//
//    var isLoading: Bool { get set }
//}



//extension Variable: ObservableProperty where Element: LoadingDataObservable {
//
//    typealias T = Element.ElementType
//
//    var loading: Observable<Bool> {
//        get { return self.asObservable().map { $0.loading } }
//    }
//
//    var data: Observable<T> {
//        get { return self.events.elements() }
//    }
//
//    var error: Observable<Error> {
//        get { return self.events.errors() }
//    }
//
//    private var events: Observable<Event<E.ElementType>> {
//        get { return self.asObservable().filter { !$0.loading || $0.data != nil }.map { $0.data! } }
//    }
//}



//extension Variable: MutableProperty where Element: LoadingDataObservable {
//    
//    var isLoading: Bool {
//        get { return self.value.loading }
//        set(newLoading) { self.value = LoadingResult(newLoading) }
//    }
//}
//
