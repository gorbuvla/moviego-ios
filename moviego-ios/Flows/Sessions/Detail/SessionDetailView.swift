//
//  ShowtimeDetailView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class SessionDetailView: BaseView {
    
    weak var labelText: UILabel!
    
    override func createView() {
        backgroundColor = .white
        
        labelText = label { it in
            it.textStyleDark()
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}
