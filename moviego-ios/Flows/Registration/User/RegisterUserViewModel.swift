//
//  RegisterNameViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift

class RegisterUserViewModel: BaseViewModel {
    
    private let repository: RegistrationRepositoring
    private let viewStateSubject = PublishSubject<Result<Void, RegisterationValidationException>>()
    
    var viewState: Observable<Result<Void, RegisterationValidationException>> {
        get { return viewStateSubject.asObservable() }
    }
    
    init(repository: RegistrationRepositoring) {
        self.repository = repository
    }
    
    func submit(name: String, surname: String, email: String, password: String, confirm: String) {
        do {
            try validate(name, surname, email, password, confirm)
        } catch {
            viewStateSubject.onNext(.failure(error as! RegisterationValidationException))
            return
        }
        
        viewStateSubject.onNext(.success(()))
    }
    
    private func validate(_ name: String, _ surname: String, _ email: String, _ password: String, _ confirm: String) throws {
        if name.isEmpty {
            throw RegisterationValidationException.nameFieldError("Name must not be empty")
        }
        
        if surname.isEmpty {
            throw RegisterationValidationException.surnameFieldError("Surname must not be empty")
        }
        
        if email.isEmpty {
            throw RegisterationValidationException.emailFieldError("Email must not be empty")
        }
        
        if password.isEmpty || password.count < 8 {
            throw RegisterationValidationException.passwordFieldError("Password should be at least 8 digits long")
        }
        
        if confirm.isEmpty || password != confirm {
            throw RegisterationValidationException.confirmFieldError("Passwords do not match")
        }
    }
}

enum RegisterationValidationException: Error {
    case nameFieldError(String)
    case surnameFieldError(String)
    case emailFieldError(String)
    case passwordFieldError(String)
    case confirmFieldError(String)
}
