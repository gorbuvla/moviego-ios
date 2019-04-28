//
//  UIElementTheme.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 27/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import UIKit
import ACKategories

extension UIButton {
    
    func primaryButton() {
        setBackgroundImage(UIColor(named: .primaryGreen).image(), for: .normal)
        setBackgroundImage(UIColor(named: .primaryGreen).withAlphaComponent(0.4).image(), for: .disabled)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .disabled)
    }
}


extension UINavigationController {
    func translucentStyle() {
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
    }
}
