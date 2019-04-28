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
    private let viewStateObserver: Variable<LoadingResult<Void>>
    
    var viewState: ObservableProperty<Void> {
        get { return viewStateObserver.asObservable() }
    }
    
    init(repository: UserRepositoring) {
        self.repository = repository
        self.viewStateObserver = Variable(LoadingResult(false))
    }
    
    func login(emailOrUsername: String, password: String) {
        do {
            try validateFields(credential: emailOrUsername, password: password)
        } catch {
            viewStateObserver.value = LoadingResult(.error(error))
            return
        }
        
        repository.login(credentials: .password(username: emailOrUsername, password: password))
            .map { _ in () }
            .asObservable() // ???
            .subscribe { self.viewStateObserver.value = LoadingResult($0) }
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
