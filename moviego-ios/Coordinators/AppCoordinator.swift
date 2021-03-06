//
//  AppCoordinator.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories
import RxSwift

//
// Main app coordinator
//
class AppCoordinator: FlowCoordinator {
    
    private let userRepository: UserRepositoring
    private var userStateDisposable: Disposable? = nil
    
    init(userRepository: UserRepositoring) {
        self.userRepository = userRepository
    }
    
    override func start(in window: UIWindow) {
        super.start(in: window)
        
        userStateDisposable = userRepository.user.distinctUntilChanged { $0?.name == $1?.name }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                let coordinator = user == nil ? LoginCoordinator() : DashboardCoordinator()
                self?.addChild(coordinator)
            
                let root = coordinator.start()
                self?.rootViewController = root
                window.rootViewController = root
            })
    }
    
    override func stop(animated: Bool = false) {
        userStateDisposable?.dispose()
    }
    
    func handleDeeplink(with movieId: Int, window: UIWindow) {
        
        if userRepository.currentUser != nil {
            // sry, the easiest way
            let coordinator = DashboardCoordinator()
            let root = coordinator.start(with: movieId)
            rootViewController = root
            window.rootViewController = root
        }
    }
}
