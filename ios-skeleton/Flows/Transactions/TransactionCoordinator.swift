//
//  TransactionCoordinator.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import UIKit

final class TransactionCoordinator: Coordinator {
    
    typealias Dependency = HasViewModelFactories
    
    private let navigationController: UINavigationController
    
    var rootViewController: UIViewController {
        get { return navigationController }
    }
    
    init(dependencies: Dependency) {
        self.navigationController = UINavigationController()
    }
    
    func start(inside window: UIWindow) {
        let vc = TransactionListViewController(viewModel: dependencies.transactionListViewModelFactory())
        navigationController.viewControllers = [vc]
        window.rootViewController = navigationController
    }
}

extension TransactionCoordinator: TransactionListNavigationDelegate {
    
    func didSelect(transaction: Transaction) {
        // push detail
    }
}
