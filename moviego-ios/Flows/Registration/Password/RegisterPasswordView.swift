//
//  RegisterPasswordView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import UIKit

class RegisterPasswordView: BaseFormView {
    
    weak var passwordInput: FramedTextField!
    weak var confirmInput: FramedTextField!
    
    override func createView() {
        super.createView()
        continueButton.setTitle("Next", for: .normal)
        
        ui.stack { it in
            it.axis = .vertical
            it.spacing = 10
            
            passwordInput = it.ui.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Enter password"
            }
            
            confirmInput = it.ui.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Confirm password"
            }
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalTo(safeArea)
                make.bottom.lessThanOrEqualTo(continueButton.snp.top).offset(50)
            }
        }
    }
}
