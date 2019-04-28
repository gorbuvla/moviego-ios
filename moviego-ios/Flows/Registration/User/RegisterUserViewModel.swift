//
//  RegisterNameViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

class RegisterUserViewModel: BaseViewModel {
    
    private let repository: RegistrationRepositoring
    
    init(repository: RegistrationRepositoring) {
        self.repository = repository
    }
}
