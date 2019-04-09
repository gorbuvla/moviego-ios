//
//  RegisterNameView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class RegisterNameView: BaseView {

    weak var nameTextField: UITextField!
    weak var emailTextField: UITextField!
    weak var passwordTextField: UITextField!
    weak var nextButton: UIButton!
    
    override func createView() {
        stack { it in
            
            nameTextField = it.textField { it in
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            emailTextField = it.textField { it in
                
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
        }
    }
}
