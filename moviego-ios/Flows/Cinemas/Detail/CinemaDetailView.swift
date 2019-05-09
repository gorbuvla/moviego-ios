//
//  CinemaDetailView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class CinemaDetailView: BaseView {
    
    weak var titleLabel: UILabel!
    
    override func createView() {
        backgroundColor = .white
        titleLabel = label { it in
            it.textStyleDark()
            
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}
