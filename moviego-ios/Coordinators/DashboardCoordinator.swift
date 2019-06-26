//
//  DashboardCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

//
// Coordinator for dashboard flow.
//
class DashboardCoordinator: FlowCoordinator {
    
    private let movieId: Int?
    
    init(movieId: Int? = nil) {
        self.movieId = movieId
    }
    
    override func start() -> UIViewController {
        let navController = BaseNavigationController()
        self.navigationController = navController
        let vc = DashboardViewController(viewModel: factories.dashboardViewModelFactory())
        vc.navigationDelegate = self
        navController.pushViewController(vc, animated: true)
        return navController
    }
    
    func start(with movieId: Int) -> UIViewController {
        let navController = BaseNavigationController()
        self.navigationController = navController
        
        let dashboard = DashboardViewController(viewModel: factories.dashboardViewModelFactory())
        dashboard.navigationDelegate = self
        
        let session = SessionDetailViewController(viewModel: factories.loadingSessionDetailViewModelFactory(movieId))
        
        navController.viewControllers = [
            dashboard, session
        ]
        
        return navController
    }
}

extension DashboardCoordinator: DashboardNavigatioNDelegate {
    
    func didSelectMovie(movie: Movie) {
        navigationController?.pushViewController(SessionDetailViewController(viewModel: factories.sessionDetailViewModelFactory(movie, nil)), animated: true)
    }
    
    func didSelectSession(session: Session) {
        navigationController?.pushViewController(SessionDetailViewController(viewModel:factories.sessionDetailViewModelFactory(session.movie, session.cinema)), animated: true)
    }
    
    func presentCinemaMap(from viewController: UIViewController) {
        let cinemaFlow = CinemaCoordinator()
        viewController.present(cinemaFlow.start(), animated: true)
    }
}
