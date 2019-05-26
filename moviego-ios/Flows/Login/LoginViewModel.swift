//
//  LoginViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

class LoginViewModel: BaseViewModel {
    
    private let repository: UserRepositoring
    private let viewStateSubject = PublishSubject<State<()>>()
    
    var viewState: StateObservable<()> {
        get { return viewStateSubject.asObservable() }
    }
    
    init(repository: UserRepositoring) {
        self.repository = repository
    }
    
    func login(emailOrUsername: String, password: String) {
        do {
            try validateFields(credential: emailOrUsername, password: password)
        } catch {
            viewStateSubject.onNext(.error(error))
            return
        }
        
        repository.login(credentials: .password(username: emailOrUsername, password: password))
            .asObservable()
            .map { _ in () }
            .mapState()
            .bind(to: viewStateSubject)
            .disposed(by: disposeBag)
    }
    
    private func validateFields(credential: String, password: String) throws {
        guard password.count >= 8 else {
            throw LoginValidationException.passwordFieldError("Password must be at least 8 digits long")
        }
    }
}

enum LoginValidationException: Error {
    case emailOrUsernameFieldError(String)
    case passwordFieldError(String)
}
