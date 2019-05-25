//
//  LoginCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class LoginCoordinator: FlowCoordinator {
    
    override func start() -> UIViewController {
        let navigation = BaseNavigationController()
//        navigation.translucentStyle()
//        navigation.navigationBar.barStyle = .blackOpaque
        
        let vc = LoginViewController(viewModel: dependencies.loginViewModelFactory())
        vc.navigationDelegate = self
        navigation.viewControllers = [vc]
        navigationController = navigation
        return navigation
    }
    
    override func stop(animated: Bool = false) {
        rootViewController = nil
    }
}

extension LoginCoordinator: LoginNavigationDelegate {
    func didTapRegister() {
        let registrationCoordinator = RegistrationCoordinator(factories: dependencies)
        addChild(registrationCoordinator)
        registrationCoordinator.start(with: navigationController!)
    }
    
    func didFinishLogin() {
        // parent coordinator is subscribed to user updates and handles coordinator switching
    }
}
