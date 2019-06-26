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
    
    private lazy var initialCoordinator: AppCoordinator = AppCoordinator(userRepository: MockedModelDependency.shared.userRepository)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        initialCoordinator.start(in: window!)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // TODO: should be in one place... jackie chan meme...
        guard url.scheme == "moviego" else { return false }
        
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let _ = components.path,
            let params = components.queryItems else {
                print("Either path or params are missing")
                return false
        }
        
        guard let movieId = Int(params.first(where: { $0.name == "id" })?.value ?? "") else { return false }
        
        print("Handling movie with id: \(movieId)")
        initialCoordinator.handleDeeplink(with: movieId, window: window!)
        
        return true
    }
}
