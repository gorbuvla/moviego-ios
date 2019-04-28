//
//  LoginView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import ACKategories

class LoginView: BaseView {
    
    weak var logoImage: UIImageView!
    weak var controlStack: UIStackView!
    weak var emailOrUsernameField: FramedTextField!
    weak var passwordField: FramedTextField!
    weak var registerButton: UIButton!
    weak var loginButton: UIButton!
    weak var loadingIndicator: UIActivityIndicatorView!
    
    override func createView() {
        backgroundColor = UIColor(named: .bkgDark).withAlphaComponent(0.8)
        
        logoImage = imageView { it in
            it.image = Asset.logo.image
            it.backgroundColor = .yellow
            
            it.snp.makeConstraints { make in
                make.width.height.equalTo(240)
                make.center.equalToSuperview()
            }
        }
        
        controlStack = stack { it in
            it.axis = .vertical
            it.spacing = 5
            it.isHidden = true
            
            emailOrUsernameField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = L10n.Login.emailTitle
                it.textField.textContentType = .emailAddress
                it.textField.returnKeyType = .next
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
            }
            
            passwordField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = L10n.Login.password
                it.textField.textContentType = .password
                it.textField.returnKeyType = .send
                it.isSecureTextEntry = true
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
            }
            
            registerButton = it.button { it in
                it.underlinedButton(text: L10n.Login.registerButton)
                it.titleLabel?.styleLink()
                it.titleLabel?.textStyleLight()
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(50)
                    make.height.equalTo(40)
                }
            }
            
            loginButton = it.button { it in
                it.setTitle(L10n.Login.buttonTitle, for: .normal)
                it.primaryButton()
                
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(40)
                }
            }
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.equalTo(logoImage.snp.bottom).offset(50)
            }
        }
        
        loadingIndicator = customView(UIActivityIndicatorView()) { it in
            it.style = .whiteLarge
            it.isHidden = true
            
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}
