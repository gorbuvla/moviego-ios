//
//  PromotionsCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class PromotionsCoordinator: FlowCoordinator {
    
    override func start() -> UIViewController {
        let nav = UINavigationController()
        let vc = PromotionListViewController(viewModel: dependencies.promotionListViewModelFactory())
        vc.tabBarItem.title = L10n.Tabbar.Promotions.title
        nav.viewControllers = [vc]
        navigationController = nav
        return nav
    }
}
