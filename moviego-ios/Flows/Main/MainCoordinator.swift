//
//  MainFlowCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class MainCoordinator: FlowCoordinator {
    
    private var showtimesFlow: SessionCoordinator? = nil
    
    override func start() -> UIViewController {
        let navController = BaseNavigationController()
        navigationController = navController
        let showtimesFlow = SessionCoordinator()
        self.showtimesFlow = showtimesFlow
        showtimesFlow.start(with: navController)
        return navController
    }
}
