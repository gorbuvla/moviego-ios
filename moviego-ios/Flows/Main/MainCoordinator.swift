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
    
    override func start() -> UIViewController {
        let tabBarController = setupTabBarController()
        rootViewController = tabBarController
        return tabBarController
    }
    
    
    private func setupTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let moviesFlow = MoviesCoordinator()
        let moviesRoot = moviesFlow.start()
        addChild(moviesFlow)
        
        let promotionsFlow = PromotionsCoordinator()
        let promotionsRoot = promotionsFlow.start()
        addChild(promotionsFlow)
        
        let profileFlow = ProfileCoordinator()
        let profileRoot = profileFlow.start()
        addChild(profileFlow)
        
        tabBarController.viewControllers = [moviesRoot, promotionsRoot, profileRoot]
        return tabBarController
    }
}
