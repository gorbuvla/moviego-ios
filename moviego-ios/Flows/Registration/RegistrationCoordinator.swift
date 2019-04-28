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

extension RegistrationCoordinator: UserRegistrationNavigationDelegate {
    
    func didTapContinue() {
        let vc = RegisterPasswordViewController(viewModel: factories.registerPasswordViewModelFactory())
        vc.navigationDelegate = self
        navController?.pushViewController(vc, animated: true)
    }
}

extension RegistrationCoordinator: RegisterPasswordNavigationDelegate {
    
    func didTapNext() {
        // TODO: go to city
    }
}

//extension RegistrationCoordinator: RegisterCityNavigationDelegate {
//
//    func onRegisterSuccess() {
//        // todo: continue into main flow
//    }
//}
