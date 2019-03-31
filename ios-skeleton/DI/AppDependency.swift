//
//  AppDependency.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation



final class AppDependency: HasTransactionManaging {
    
    lazy var transactionRepository: TransactionRepositoring = TransactionRepository(dependencies: self)
    
}

let dependencies = AppDependency()


protocol HasNoDependency {}

extension AppDependency: HasNoDependency {}
