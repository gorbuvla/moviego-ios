//
//  Coordinator.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var rootViewController: UIViewController { get }
    
    func start()
    
    func start(inside window: UIWindow)
}

extension Coordinator {
    
    func start() {}
    
    func start(inside window: UIWindow) {}
}
