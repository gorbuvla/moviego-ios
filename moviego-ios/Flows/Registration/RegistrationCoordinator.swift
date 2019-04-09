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
    
    init(factories: ViewModelFactory) {
        self.factories = factories
    }
    
    override func start(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let vc = RegisterNameViewController(viewModel: factories.registerNameViewModelFactory())
        vc.navigationDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: RegisterNameNavigationDelegate {
    
    func didTapContinue() {
        let vc = RegisterCityViewController(viewModel: factories.registerCityViewModelFactory())
        vc.navigationDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: RegisterCityNavigationDelegate {
    
    func onRegisterSuccess() {
        // todo: continue into main flow
    }
}
