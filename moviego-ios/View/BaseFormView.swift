//
//  BaseFormView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class BaseFormView: BaseView {
    
    weak var continueButton: UIButton!
    
    override func createView() {
        backgroundColor = UIColor(named: .primaryBlue).withAlphaComponent(0.8)
        
        continueButton = button { it in
            it.primaryButton()
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
}
