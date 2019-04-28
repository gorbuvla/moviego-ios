//
//  RegisterNameView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class RegisterUserView: BaseFormView {

    weak var nameTextField: FramedTextField!
    weak var emailTextField: FramedTextField!
    weak var passwordTextField: FramedTextField!
    weak var userInfoTextField: FramedTextField!
    
    override func createView() {
        super.createView()
        
        stack { it in
            it.axis = .vertical
            it.spacing = 10
            
            nameTextField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Name"
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            emailTextField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Email"
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            passwordTextField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Password"
                it.isSecureTextEntry = true
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            userInfoTextField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Info"
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.lessThanOrEqualTo(continueButton.snp.top).offset(50)
            }
        }
    }
}
