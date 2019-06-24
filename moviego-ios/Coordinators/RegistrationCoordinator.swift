//
//  RegistrationCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import ACKategories
import UIKit

//
// Coordinator for registration flow
//
class RegistrationCoordinator: FlowCoordinator {
    
    private let repository: RegistrationRepository
    private var navController: UINavigationController? = nil
    
    override init() {
        self.repository = RegistrationRepository()
        super.init()
    }
    
    override func start(with navigationController: UINavigationController) {
        self.navController = navigationController
        self.navigationController = navigationController
        let vc = ChooseCityViewController(viewModel: factories.registerCityViewModelFactory(repository))
        vc.navigationDelegate = self
        self.navController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: ChooseCityNavigationDelegate {
    func onCityPicked() {
        let vc = RegisterUserViewController(viewModel: factories.userRegistrationViewModelFactory(repository))
        navigationController?.pushViewController(vc, animated: true)
    }
}
