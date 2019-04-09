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
    
    override func createView() {
        stack { it in
            
            emailOrUsernameTextField = textField { it in
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            passwordTextField = textField { it in
                
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
