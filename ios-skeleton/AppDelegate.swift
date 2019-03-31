//
//  AppDelegate.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 30/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var initialCoordinator: Coordinator = TransactionCoordinator(dependencies: dependencies)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        initialCoordinator.start(inside: window!)
        return true
    }
}
