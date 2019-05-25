//
//  RegisterNameView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class RegisterUserView: BaseScrollView {

    weak var nameTextField: FramedTextField!
    weak var surnameTextField: FramedTextField!
    weak var emailTextField: FramedTextField!
    weak var passwordTextField: FramedTextField!
    weak var userInfoTextField: FramedTextField!
    weak var passwordInput: FramedTextField!
    weak var confirmInput: FramedTextField!
    
    weak var footerView: UIView!
    weak var continueButton: UIButton!
    
    override func createView() {
        super.createView()
        
        footerView = ui.view { it in
            continueButton = it.ui.button { it in
                it.primaryButton()
                
                it.snp.makeConstraints { make in
                    make.height.equalTo(40)
                    make.leading.trailing.equalToSuperview().inset(20)
                    make.bottom.equalToSuperview().inset(30)
                }
            }
            
            it.snp.makeConstraints { make in
                //make.top.equalTo(.snp.bottom)
                make.leading.trailing.bottom.equalTo(safeArea)
                make.height.equalTo(0).priority(250)
                make.height.greaterThanOrEqualTo(0)
            }
        }
        
        scrollView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
    }
    
    override func createScrollContent(contentView: UIView) {
        super.createScrollContent(contentView: contentView)
        backgroundColor = .bkgLight
        
        contentView.ui.stack { it in
            it.axis = .vertical
            it.spacing = 2
            
            nameTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = "Name"
                it.textField.textContentType = .givenName
                it.textField.returnKeyType = .next
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            surnameTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = "Surname"
                it.textField.textContentType = .familyName
                it.textField.returnKeyType = .next
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            emailTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = "Email"
                it.textField.textContentType = .emailAddress
                it.textField.returnKeyType = .next
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            passwordInput = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = "Enter password"
                it.textField.textContentType = .newPassword
                it.textField.returnKeyType = .next
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            confirmInput = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = "Confirm password"
                it.textField.textContentType = .newPassword
                it.textField.returnKeyType = .continue
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview().inset(20)
            }
        }
    }
}
