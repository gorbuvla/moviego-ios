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
        backgroundColor = UIColor(named: .primaryBlue).withAlphaComponent(0.8)
        
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
            it.spacing = 10
            it.isHidden = true
            
            emailOrUsernameField = it.customView(FramedTextField(style: .dark)) { it in
                it.titleLabel.text = "Email Or Username"
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    //make.height.equalTo(40)
                }
            }
            
            passwordField = it.customView(FramedTextField(style: .light)) { it in
                it.titleLabel.text = "Password"
                it.isSecureTextEntry = true
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                }
            }
            
            // TODO: link button
            
            registerButton = it.button { it in
                it.setTitle("Register", for: [])
                it.setTitleColor(UIColor.white, for: .normal)
                it.setTitleColor(UIColor.white.darkened(), for: .highlighted)
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(50)
                }
            }
            
            loginButton = it.button { it in
                it.setTitle("Sing In", for: .normal)
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
