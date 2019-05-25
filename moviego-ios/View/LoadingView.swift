//
//  LoadingView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class LoadingView: BaseView {
    
    weak var indicator: UIActivityIndicatorView!
    
    override func createView() {
        super.createView()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        indicator = ui.customView(UIActivityIndicatorView()) { it in
            it.style = .whiteLarge
            it.startAnimating()
            
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}

extension ViewDslMaker {
    
    func loadingView(_ block: (LoadingView) -> ()) -> LoadingView {
        return customView(LoadingView(), block)
    }
}
