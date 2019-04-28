//
//  RegisterPasswordViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

protocol RegisterPasswordNavigationDelegate: class {
    func didTapNext()
}

class RegisterPasswordViewController: BaseViewController<RegisterPasswordView> {
    
    private let viewModel: RegisterPasswordViewModel
    weak var navigationDelegate: RegisterPasswordNavigationDelegate? = nil
    
    init(viewModel: RegisterPasswordViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
