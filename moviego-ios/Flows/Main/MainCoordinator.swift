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
    
    private var showtimesFlow: ShowtimesCoordinator? = nil
    
    override func start() -> UIViewController {
        let navController = BaseNavigationController()
        navigationController = navController
        let showtimesFlow = ShowtimesCoordinator()
        self.showtimesFlow = showtimesFlow
        showtimesFlow.start(with: navController)
        return navController
    }
    
    private func setupTabBarController() -> UITabBarController {
        let tabbarController = UITabBarController()
        tabbarController.tabBar.barTintColor = UIColor.white
        tabbarController.tabBar.backgroundColor = UIColor.white
        tabbarController.tabBar.tintColor = UIColor(named: .primary)
        tabbarController.tabBar.unselectedItemTintColor = .gray
        
        let moviesFlow = ShowtimesCoordinator()
        let moviesRoot = moviesFlow.start()
        addChild(moviesFlow)
        
        let promotionsFlow = PromotionsCoordinator()
        let promotionsRoot = promotionsFlow.start()
        addChild(promotionsFlow)
        
        let profileFlow = ProfileCoordinator()
        let profileRoot = profileFlow.start()
        addChild(profileFlow)
        
        tabbarController.viewControllers = [moviesRoot, promotionsRoot, profileRoot]
        return tabbarController
    }
}
