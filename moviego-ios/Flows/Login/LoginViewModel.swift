//
//  LoginViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

class LoginViewModel: BaseViewModel {
    
    private let repository: UserRepositoring
    
    init(repository: UserRepositoring) {
        self.repository = repository
    }
    
    func login(emailOrUsername: String, password: String) {
        
    }
}
