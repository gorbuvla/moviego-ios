//
//  State.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

//
// Inspired by Result type, this one is used to indicate loading process.
//
enum State<Value> {
    case loading
    case value(Value)
    case error(Error)
}

protocol StateConvertible {
    associatedtype SValue
    
    var state: State<SValue> { get }
}

extension State: StateConvertible {
    typealias SValue = Value
    
    var state: State<Value> { return self }
}

infix operator ~=

extension State {
    
    static func ~=(lhs: State, rhs: State) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.value(_), .value(_)): return true
        case (.error(_), .error(_)): return true
        default: return false
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var value: Value? {
        switch self {
        case .value(let value): return value
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
