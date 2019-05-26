//
//  RxExtensions.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

extension BehaviorSubject {
    var value: Element {
        return try! self.value()
    }
}
