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
    
    private var dashboardCoordinator: DashboardCoordinator? = nil
    
    override func start() -> UIViewController {
        let navController = BaseNavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navigationController = navController
        let dashboardFlow = DashboardCoordinator()
        self.dashboardCoordinator = dashboardFlow
        self.dashboardCoordinator?.start(with: navController)
        return navController
    }
}
