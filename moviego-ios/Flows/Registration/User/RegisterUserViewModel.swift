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
    
    private var repository: RegistrationRepositoring
    private let userRepository: UserRepositoring
    private let viewStateSubject = PublishSubject<State<()>>()
    
    var viewState: StateObservable<()> {
        get { return viewStateSubject.asObservable() }
    }
    
    init(repository: RegistrationRepositoring, userRepository: UserRepositoring) {
        self.repository = repository
        self.userRepository = userRepository
    }
    
    func submit(name: String, surname: String, email: String, password: String, confirm: String) {
        do {
            try validate(name, surname, email, password, confirm)
            repository.name = name
            repository.surname = surname
            repository.email = email
            repository.password = password
        } catch {
            viewStateSubject.onNext(.error(error as! RegisterationValidationException))
            return
        }
        
        register()
    }
    
    private func register() {
        // TODO: make actual call
        userRepository.register(credentials: repository.credentials)
            .asObservable()
            .map { _ in () }
            .mapState()
            .bind(to: viewStateSubject)
            .disposed(by: disposeBag)
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
