//
//  TextTheme.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 27/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

// TODO: unify all these...

extension UILabel {
    
    func textStyleLight(opacity: Float = 0.6) {
        textColor = UIColor(named: .textLight).withAlphaComponent(CGFloat(opacity))
    }
    
    func textStyleDark(opacity: Float = 0.6) {
        textColor = UIColor(named: .textDark).withAlphaComponent(CGFloat(opacity))
    }
    
    func styleHeading1() {
        font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    func styleHeading2() {
        font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func styleHeading3() {
        font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func styleHeading4() {
        font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func styleParagraphNormall() {
        font = UIFont.systemFont(ofSize: 15)
    }
    
    func styleParagraphSmall() {
        font = UIFont.systemFont(ofSize: 12)
    }
    
    func styleParagraphLarge() {
        font = UIFont.systemFont(ofSize: 16)
    }
    
    func styleLink() {
        textColor = UIColor(named: .secondary)
        font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func styleLabel() {
        font = UIFont.systemFont(ofSize: 11)
    }
    
    func styleError() {
        textColor = UIColor(named: .errorRed)
        font = UIFont.systemFont(ofSize: 12)
    }
}

extension UITextField {
    
    func textStyleLight(opacity: Float = 0.6) {
        textColor = UIColor(named: .textLight).withAlphaComponent(CGFloat(opacity))
    }
    
    func textStyleDark(opacity: Float = 0.6) {
        textColor = UIColor(named: .textDark).withAlphaComponent(CGFloat(opacity))
    }
    
    func styleHeading1() {
        font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    func styleHeading2() {
        font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func styleHeading3() {
        font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func styleHeading4() {
        font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func styleParagraphNormall() {
        font = UIFont.systemFont(ofSize: 15)
    }
    
    func styleParagraphSmall() {
        font = UIFont.systemFont(ofSize: 12)
    }
    
    func styleParagraphLarge() {
        font = UIFont.systemFont(ofSize: 16)
    }
    
    func styleLink() {
        textColor = UIColor(named: .secondary)
        font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func styleLabel() {
        font = UIFont.systemFont(ofSize: 11)
    }
    
    func styleError() {
        textColor = UIColor(named: .errorRed)
        font = UIFont.systemFont(ofSize: 12)
    }
}
