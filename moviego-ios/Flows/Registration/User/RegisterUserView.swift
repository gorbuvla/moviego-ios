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
    weak var confirmTextField: FramedTextField!
    
    weak var loadingView: LoadingView!
    weak var footerView: UIView!
    weak var continueButton: UIButton!
    
    override func createView() {
        super.createView()
        
        footerView = ui.view { it in
            continueButton = it.ui.button { it in
                it.setTitle(L10n.Registration.User.Button.title, for: .normal)
                it.primaryButton()
                
                it.snp.makeConstraints { make in
                    make.height.equalTo(40)
                    make.leading.trailing.equalToSuperview().inset(20)
                    make.bottom.top.equalToSuperview().inset(30)
                }
            }
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalTo(safeArea)
                make.bottom.equalTo(safeArea)
                make.height.equalTo(0).priority(250)
                make.height.greaterThanOrEqualTo(0)
            }
        }
        
        scrollView.snp.removeConstraints()
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        
        loadingView = ui.loadingView { it in
            it.isHidden = true
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    override func createScrollContent(contentView: UIView) {
        super.createScrollContent(contentView: contentView)
        backgroundColor = .bkgLight
        
        let userStack = contentView.ui.stack { it in
            it.axis = .vertical
            it.spacing = 2
            
            nameTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Registration.User.Name.title
                it.textField.textContentType = .givenName
                it.textField.returnKeyType = .next
                it.textField.enablesReturnKeyAutomatically = true
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            surnameTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Registration.User.Surname.title
                it.textField.textContentType = .familyName
                it.textField.returnKeyType = .next
                it.textField.enablesReturnKeyAutomatically = true
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            emailTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Registration.User.Email.title
                it.textField.textContentType = .emailAddress
                it.textField.returnKeyType = .next
                it.textField.enablesReturnKeyAutomatically = true
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(20)
            }
        }
        
        let divider = contentView.ui.view { it in
            it.backgroundColor = UIColor.separator //.withAlphaComponent(0.6)
            
            it.snp.makeConstraints { make in
                make.top.equalTo(userStack.snp.bottom).offset(24)
                make.height.equalTo(1)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
        
        contentView.ui.stack { it in
            it.axis = .vertical
            it.spacing = 2
            
            passwordTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Registration.User.Password.title
                it.textField.textContentType = .newPassword
                it.textField.returnKeyType = .next
                it.textField.enablesReturnKeyAutomatically = true
                it.isSecureTextEntry = true
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            confirmTextField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Registration.User.ConfirmPassword.title
                it.textField.textContentType = .newPassword
                it.textField.returnKeyType = .continue
                it.textField.enablesReturnKeyAutomatically = true
                it.isSecureTextEntry = true
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.equalTo(divider.snp.bottom).offset(30)
                make.leading.trailing.bottom.equalToSuperview().inset(20)
            }
        }
    }
}
