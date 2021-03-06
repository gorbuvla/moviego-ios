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
        setBackgroundImage(UIColor(named: .secondary).image(), for: .normal)
        setBackgroundImage(UIColor(named: .secondary).withAlphaComponent(0.4).image(), for: .disabled)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .disabled)
        
        layer.cornerRadius = 20
        clipsToBounds = true
        titleLabel?.styleLink()
    }
    
    func secondaryButton() {
        setBackgroundImage(UIColor(named: .primary).image(), for: .normal)
        setBackgroundImage(UIColor(named: .primary).withAlphaComponent(0.4).image(), for: .disabled)
        setTitleColor(.secondary, for: .normal)
        setTitleColor(UIColor.secondary.withAlphaComponent(0.3), for: .disabled)
        
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondary.cgColor
        clipsToBounds = true
        titleLabel?.styleLink()
    }
    
    func accentButton() {
        setBackgroundImage(UIColor(named: .accentGreen).image(), for: .normal)
        setBackgroundImage(UIColor(named: .accentGreen).withAlphaComponent(0.4).image(), for: .disabled)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .disabled)
        
        clipsToBounds = true
        titleLabel?.styleLink()
    }
    
    func underlinedButton(text: String) {
        let title = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        self.setAttributedTitle(title, for: .normal)
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
