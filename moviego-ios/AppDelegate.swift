//
//  AppDelegate.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 30/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var initialCoordinator: FlowCoordinator = AppCoordinator(userRepository: ModelDependency.shared.userRepository)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        initialCoordinator.start(in: window!)
        return true
    }
}
