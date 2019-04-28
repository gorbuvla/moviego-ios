//
//  RegisterPasswordViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

class RegisterPasswordViewModel: BaseViewModel {
    
    private let repository: RegistrationRepositoring
    
    init(repository: RegistrationRepositoring) {
        self.repository = repository
    }
}

