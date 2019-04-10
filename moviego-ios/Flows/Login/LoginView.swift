//
//  LoginView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class LoginView: BaseView {
    
    weak var emailOrUsernameTextField: UITextField!
    weak var passwordTextField: UITextField!
    weak var loginButton: UIButton!
    
    override func createView() {
        backgroundColor = .gray
        
        stack { it in
            emailOrUsernameTextField = it.textField { it in
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            passwordTextField = it.textField { it in
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            loginButton = it.button { it in
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            it.snp.makeConstraints { make in
                make.width.equalToSuperview().inset(20)
                make.centerY.equalToSuperview()
            }
        }
    }
}
