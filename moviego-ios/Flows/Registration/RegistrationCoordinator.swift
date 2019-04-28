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
        
        let vc = RegisterUserViewController(viewModel: factories.userRegistrationViewModelFactory())
        vc.navigationDelegate = self
        self.navController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: RegistrUserNavigationDelegate {
    
    func didTapGoToPassword() {
        let vc = RegisterPasswordViewController(viewModel: factories.registerPasswordViewModelFactory())
        vc.navigationDelegate = self
        navController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: RegisterPasswordNavigationDelegate {
    
    func didTapGoToCity() {
        let vc = PickCityViewController(viewModel: factories.registerCityViewModelFactory())
        vc.navigationDelegate = self
        navController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: PickCityNavigationDelegate {
    func onPickSuccess() {
        // TODO: navigate to dashboard
    }
}

//extension RegistrationCoordinator: RegisterCityNavigationDelegate {
//
//    func onRegisterSuccess() {
//        // todo: continue into main flow
//    }
//}
