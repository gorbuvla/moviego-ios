//
//  LoginViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

protocol LoginNavigationDelegate: class {
    
    func didTapRegister()
    
    func didFinishLogin()
}

class LoginViewController: BaseViewController<LoginView> {
    
    private let viewModel: LoginViewModel
    
    weak var navigationDelegate: LoginNavigationDelegate?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
    }
}
