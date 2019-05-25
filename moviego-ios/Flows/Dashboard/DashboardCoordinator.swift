//
//  DashboardCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class DashboardCoordinator: FlowCoordinator {
    
    override func start(with navigationController: UINavigationController) {
        let vc = DashboardViewController(viewModel: dependencies.dashboardViewModelFactory())
        vc.navigationDelegate = self
        self.navigationController = navigationController
        navigationController.pushViewController(vc, animated: true)
    }
}

extension DashboardCoordinator: DashboardNavigatioNDelegate {
    
    func didSelectMovie(movie: Movie) {
        // TODO: go to movie detail
    }
    
    func didSelectSession(session: Session) {
        // TODO: go to session detail
    }
    
    func presentCinemaMap(from viewController: UIViewController) {
        let navidation = BaseNavigationController()
        navidation.viewControllers = [CinemaMapViewController(viewModel: dependencies.cinemaMapViewModel())]
        viewController.present(navidation, animated: true)
    }
    
    func presentProfile(from viewController: UIViewController) {
        let navigation = BaseNavigationController()
        navigation.viewControllers = [ProfileViewController(viewModel: dependencies.profileViewModel())]
        viewController.present(navigation, animated: true)
    }
}
