//
//  RegisterNameViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

protocol RegisterNameNavigationDelegate: class {
    func didTapContinue()
}

class RegisterNameViewController: BaseViewController<RegisterNameView> {
    
    private let viewModel: RegisterNameViewModel
    weak var navigationDelegate: RegisterNameNavigationDelegate?
    
    init(viewModel: RegisterNameViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
