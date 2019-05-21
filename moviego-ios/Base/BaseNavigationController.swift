//
//  BaseNavigationController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 08/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupAppearance()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    private func setupAppearance() {
        navigationBar.barTintColor = UIColor(named: .primary)
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        let backImage = Asset.icBackArrow.image
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.white]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
