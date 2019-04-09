//
//  RegisterCityViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol RegisterCityNavigationDelegate: class {
    func onRegisterSuccess()
}

class RegisterCityViewController: BaseViewController<BaseListView> {
    
    private let viewModel: RegisterCityViewModel
    weak var navigationDelegate: RegisterCityNavigationDelegate?
    
    init(viewModel: RegisterCityViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
