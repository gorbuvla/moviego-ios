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
        
        continueButton.setTitle("Next", for: .normal)
        
        scrollContent.ui.stack { it in
            it.axis = .vertical
            it.spacing = 10
            
            nameTextField = it.ui.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Name"
                it.backgroundColor = .gray
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            emailTextField = it.ui.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Email"
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            userInfoTextField = it.ui.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Info"
                
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
            }
        }
    }
}
