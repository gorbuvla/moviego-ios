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
        let vc = ShowtimeSearchViewController(viewModel: dependencies.showtimeListViewModelFactory())
        vc.navigationDelegate = self
        
        let nav = BaseNavigationController(rootViewController: vc)
        navigationController = nav
        return nav
    }
    
    override func start(with navigationController: UINavigationController) {
        let vc = ShowtimeSearchViewController(viewModel: dependencies.showtimeListViewModelFactory())
        vc.navigationDelegate = self
        self.navigationController = navigationController
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ShowtimesCoordinator: ShowtimeSearchNavigationDelegate {
    func presentMap(from viewController: UIViewController) {
        let navidation = UINavigationController()
        navidation.viewControllers = [CinemaMapViewController(viewModel: dependencies.cinemaMapViewModel())]
        viewController.present(navidation, animated: true)
    }
    
    func presentProfile(from viewController: UIViewController) {
        let navigation = UINavigationController()
        navigation.viewControllers = [ProfileViewController(viewModel: dependencies.profileViewModel())]
        viewController.present(navigation, animated: true)
    }
    
    func didSelect(searchItem: ShowtimeSearchItem) {
        
    }
}
