//
//  MoviesCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class ShowtimesCoordinator: FlowCoordinator {
    
    override func start() -> UIViewController {
        let nav = UINavigationController()
        let vc = ShowtimeListViewController(viewModel: dependencies.showtimeListViewModelFactory())
        vc.tabBarItem.image = Asset.icTabMovies.image
        vc.tabBarItem.title = L10n.Tabbar.Movies.title
        vc.navigationDelegate = self
        nav.viewControllers = [vc]
        navigationController = nav
        return nav
    }
}

extension ShowtimesCoordinator: ShowtimeListNavigationDelegate {
    
}
