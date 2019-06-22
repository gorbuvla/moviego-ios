//
//  FlexibleHeaderView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 22/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

//
// Header view with flexible upper part.
//
class FlexibleHeaderView: BaseView {

    private weak var card: UIView!
    
    override func createView() {
        backgroundColor = .bkgLight
        
        let flexibleView = ui.customView(getFlexibleView()) { it in
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.width.equalToSuperview()
            }
        }
        
        card = ui.view { it in
            it.layer.cornerRadius = 4
            it.backgroundColor = UIColor.white
            
            createCardContent(parent: it)
            
            it.snp.makeConstraints { make in
                make.centerY.equalTo(flexibleView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview().inset(20)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        card.applyShadow()
    }
    
    // override this method to create custom card content.
    open func createCardContent(parent: UIView) {}
    
    // override this method to provide flexible with that would be zoomed in on scroll.
    open func getFlexibleView() -> UIView {
        return UIView()
    }
}
