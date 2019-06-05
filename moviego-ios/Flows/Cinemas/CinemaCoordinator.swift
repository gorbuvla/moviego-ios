//
//  CinemaCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class CinemaCoordinator: FlowCoordinator {
    
    override func start() -> UIViewController {
        let navController = BaseNavigationController()
        let vc = CinemaMapViewController(viewModel: factories.cinemaMapViewModelFactory())
        vc.navigationDelegate = self
        navController.viewControllers = [vc]
        navigationController = navController
        return navController
    }
}

extension CinemaCoordinator: CinemaMapNavigationDelegate {
    func didTapShowDetail(of cinema: Cinema) {
        let vc = CinemaDetailViewController(viewModel: factories.cinemaDetailViewModelFactory(cinema))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapShowDetail(of promotion: Promotion) {
        let vc = PromotionViewController(promotion: promotion)
        navigationController?.pushViewController(vc, animated: true)
    }
}
