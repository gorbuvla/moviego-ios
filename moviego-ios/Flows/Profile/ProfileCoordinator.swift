//
//  ProfileCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class ProfileCoordinator: FlowCoordinator {
    
    override func start() -> UIViewController {
        let vc = ProfileViewController(viewModel: factories.profileViewModel())
        let nav = UINavigationController()
        nav.viewControllers = [vc]
        navigationController = nav
        return nav
    }
}
