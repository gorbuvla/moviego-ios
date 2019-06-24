//
//  CinemaCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

//
// Coordinator for cinema flow.
//
class CinemaCoordinator: FlowCoordinator {
    
    override func start() -> UIViewController {
        let navController = BaseNavigationController()
        self.navigationController = navController
        
        let vc = CinemaMapViewController(viewModel: factories.cinemaMapViewModelFactory())
        vc.navigationDelegate = self
        navController.viewControllers = [vc]
        return navController
    }
}

extension CinemaCoordinator: CinemaMapNavigationDelegate {
    func didTapShowDetail(of cinema: Cinema) {
        let vc = CinemaDetailViewController(viewModel: factories.cinemaDetailViewModelFactory(cinema))
        vc.navigationDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapShowDetail(of promotion: Promotion) {
        let vc = PromotionViewController(promotion: promotion)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CinemaCoordinator: CinemaDetailNavigationDelegate {
    func didSelect(movie: Movie, in cinema: Cinema) {
        navigationController?.pushViewController(SessionDetailViewController(viewModel: factories.sessionDetailViewModelFactory(movie, cinema)), animated: true)
    }
}
