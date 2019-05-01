//
//  ViewDsl.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func customView<V: UIView>(_ view: V, _ block: (V) -> Void) -> V {
        addView(view)
        block(view)
        return view
    }
    
    func addView(_ view: UIView) {
        if let stack = self as? UIStackView {
            stack.addArrangedSubview(view)
        } else {
            addSubview(view)
        }
    }
    
    @discardableResult
    func view(_ block: (UIView) -> Void) -> UIView {
        return customView(UIView(), block)
    }
    
    @discardableResult
    func label(_ block: (UILabel) -> Void) -> UILabel {
        return customView(UILabel(), block)
    }
    
    @discardableResult
    func textField(_ block: (UITextField) -> Void) -> UITextField {
        return customView(UITextField(), block)
    }
    
    @discardableResult
    func stack(_ block: (UIStackView) -> Void) -> UIStackView {
        return customView(UIStackView(), block)
    }
    
    @discardableResult
    func button(_ block: (UIButton) -> Void) -> UIButton {
        return customView(UIButton(), block)
    }
    
    @discardableResult
    func imageView(_ block: (UIImageView) -> Void) -> UIImageView {
        return customView(UIImageView(), block)
    }
    
    @discardableResult
    func scrollView(_ block: (UIScrollView) -> Void) -> UIScrollView {
        return customView(UIScrollView(), block)
    }
    
    @discardableResult
    func activityIndicator(_ block: (UIActivityIndicatorView) -> Void) -> UIActivityIndicatorView {
        return customView(UIActivityIndicatorView(), block)
    }
}
