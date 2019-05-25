//
//  RegistrationCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import ACKategories
import UIKit

class RegistrationCoordinator: FlowCoordinator {
    
    private let factories: ViewModelFactory
    private var navController: UINavigationController? = nil
    
    init(factories: ViewModelFactory) {
        self.factories = factories
    }
    
    override func start(with navigationController: UINavigationController) {
        self.navController = navigationController
        self.navigationController = navigationController
        let vc = ChooseCityViewController(viewModel: factories.registerCityViewModelFactory())
        vc.navigationDelegate = self
        self.navController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: RegistrUserNavigationDelegate {
    
    func didTapNext() {
        
    }
}

extension RegistrationCoordinator: ChooseCityNavigationDelegate {
    func onCityPicked() {
        let vc = RegisterUserViewController(viewModel: factories.userRegistrationViewModelFactory())
        vc.navigationDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
