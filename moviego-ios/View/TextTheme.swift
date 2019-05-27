//
//  TextTheme.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 27/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit


// Extensions to apply styleguide styles to common text components.

protocol Styleable {
    
    func applyTextStyle(color: UIColor)
    func applyFontStyle(font: UIFont)
}

extension UILabel: Styleable {
    func applyTextStyle(color: UIColor) {
        self.textColor = color
    }
    
    func applyFontStyle(font: UIFont) {
        self.font = font
    }
}

extension UITextField: Styleable {
    func applyTextStyle(color: UIColor) {
        self.textColor = color
    }
    
    func applyFontStyle(font: UIFont) {
        self.font = font
    }
}

extension Styleable {
    
    func textStyleLight(opacity: Float = 0.6) {
        applyTextStyle(color: UIColor(named: .textLight).withAlphaComponent(CGFloat(opacity)))
    }
    
    func textStyleDark(opacity: Float = 0.6) {
        applyTextStyle(color: UIColor(named: .textDark).withAlphaComponent(CGFloat(opacity)))
    }
    
    func styleHeading1() {
        applyFontStyle(font: UIFont.boldSystemFont(ofSize: 24))
    }
    
    func styleHeading2() {
        applyFontStyle(font: UIFont.boldSystemFont(ofSize: 14))
    }
    
    func styleHeading3() {
        applyFontStyle(font: UIFont.boldSystemFont(ofSize: 11))
    }
    
    func styleHeading4() {
        applyFontStyle(font: UIFont.boldSystemFont(ofSize: 9))
    }
    
    func styleParagraphNormall() {
        applyTextStyle(color: .title)
        applyFontStyle(font: UIFont.systemFont(ofSize: 15))
    }
    
    func styleParagraphSmall() {
        applyTextStyle(color: .subtitle)
        applyFontStyle(font: UIFont.systemFont(ofSize: 12))
    }
    
    func styleParagraphLarge() {
        applyFontStyle(font: UIFont.systemFont(ofSize: 16))
    }
    
    func styleLink() {
        applyTextStyle(color: .secondary)
        applyFontStyle(font: UIFont.boldSystemFont(ofSize: 13))
    }
    
    func styleLabel() {
        applyFontStyle(font: UIFont.systemFont(ofSize: 11))
    }
    
    func styleError() {
        applyTextStyle(color: .red)
        applyFontStyle(font: UIFont.systemFont(ofSize: 12))
    }
}
