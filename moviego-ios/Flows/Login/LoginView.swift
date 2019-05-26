//
//  LoginView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class LoginView: BaseScrollView {
    
    weak var logoImage: UIImageView!
    weak var controlStack: UIStackView!
    weak var emailOrUsernameField: FramedTextField!
    weak var passwordField: FramedTextField!
    weak var registerButton: UIButton!
    weak var loginButton: UIButton!
    weak var loadingView: UIView!
    
    
    override func createScrollContent(contentView: UIView) {
        backgroundColor = .bkgLight
        
        logoImage = contentView.ui.imageView { it in
            it.image = Asset.logo.image
            
            it.snp.makeConstraints { make in
                make.width.height.equalTo(240)
                make.center.equalToSuperview()
            }
        }
        
        controlStack = contentView.ui.stack { it in
            it.axis = .vertical
            it.spacing = 2
            it.isHidden = true
            
            emailOrUsernameField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Login.Email.title
                it.textField.textContentType = .emailAddress
                it.textField.returnKeyType = .next
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
            }
            
            passwordField = it.ui.framedField(style: .light) { it in
                it.titleLabel.text = L10n.Login.Password.title
                it.textField.textContentType = .password
                it.textField.returnKeyType = .send
                it.isSecureTextEntry = true
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
            }
            
            registerButton = it.ui.button { it in
                it.underlinedButton(text: L10n.Login.RegisterButton.title)
                it.titleLabel?.styleLink()
                it.titleLabel?.textStyleDark()
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(50)
                    make.height.equalTo(40)
                }
            }
            
            loginButton = it.ui.button { it in
                it.setTitle(L10n.Login.Button.title, for: .normal)
                it.primaryButton()
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.equalTo(logoImage.snp.bottom).offset(50)
                make.bottom.lessThanOrEqualToSuperview()
            }
        }
        
        loadingView = ui.loadingView { it in
            it.isHidden = true
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
