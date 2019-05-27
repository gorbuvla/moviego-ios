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
        let vc = DashboardViewController(viewModel: factories.dashboardViewModelFactory())
        vc.navigationDelegate = self
        self.navigationController = navigationController
        navigationController.pushViewController(vc, animated: true)
    }
}

extension DashboardCoordinator: DashboardNavigatioNDelegate {
    
    func didSelectMovie(movie: Movie) {
        navigationController?.pushViewController(MovieViewController(movie: movie), animated: true)
    }
    
    func didSelectSession(session: Session) {
        navigationController?.pushViewController(SessionDetailViewController(viewModel: SessionDetailViewModel(movie: session.movie, cinema: session.cinema)), animated: true)
    }
    
    func presentCinemaMap(from viewController: UIViewController) {
        let navidation = BaseNavigationController()
        navidation.viewControllers = [CinemaMapViewController(viewModel: factories.cinemaMapViewModel())]
        viewController.present(navidation, animated: true)
    }
    
    func presentProfile(from viewController: UIViewController) {
        let navigation = BaseNavigationController()
        navigation.viewControllers = [ProfileViewController(viewModel: factories.profileViewModel())]
        viewController.present(navigation, animated: true)
    }
}
