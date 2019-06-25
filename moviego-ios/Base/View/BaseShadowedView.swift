//
//  BaseShadowedView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 25/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

//
// Base view with shadowed container.
//
class BaseShadowedView: BaseView {
    
    private weak var container: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.applyShadow()
    }
    
    open func createContentView(container: UIView) {}
    
    override func createView() {
        container = ui.view { it in
            it.layer.cornerRadius = 4
            it.clipsToBounds = true
            
            createContentView(container: it)
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
            }
        }
    }
}
