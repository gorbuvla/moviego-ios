//
//  UserRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

protocol UserRepositoring {
    var user: Observable<User?> { get }
    
    func login(credentials: LoginCredentials) -> Single<User>
    func logout() -> Completable
}

class UserRepository: UserRepositoring {
    
    private var credentialsStore: CredentialsStore
    private let oauthApi: OAuthApiServicing
    private let userVariable: Variable<User?>
    
    var user: Observable<User?> {
        get { return userVariable.asObservable() }
    }
    
    init(credentialsStore: CredentialsStore, oauthApi: OAuthApiServicing) {
        self.oauthApi = oauthApi
        self.credentialsStore = credentialsStore
        self.userVariable = Variable(credentialsStore.user)
    }

    func login(credentials: LoginCredentials) -> Single<User> {
        var request: Single<UserWithCredentials>? = nil
        
        switch credentials {
        case .password(let email, let password):
            request = oauthApi.login(email: email, password: password)
        }
            
        return request!.do(onSuccess: { [weak self] userWithCredentials in
            self?.credentialsStore.user = userWithCredentials.user
            self?.credentialsStore.credentials = userWithCredentials.credentials
            self?.userVariable.value = userWithCredentials.user
        }).map { $0.user }
    }
    
    func logout() -> Completable {
        return Completable.create { [weak self] completable in
            self?.credentialsStore.user = nil
            self?.credentialsStore.credentials = nil
            self?.userVariable.value = nil
            
            completable(.completed)
            return Disposables.create {}
        }
    }
}

class MockedUserRepository: UserRepositoring {
    
    private let credentialsStore: CredentialsStore
    private let userState: Variable<User?>
    
    var user: Observable<User?> {
        get { return userState.asObservable() }
    }
    
    init(credentialsStore: CredentialsStore) {
        self.credentialsStore = credentialsStore
        self.userState = Variable(credentialsStore.user)
    }
    
    func login(credentials: LoginCredentials) -> Single<User> {
        return Single.just(User(name: "Mocked User")).delay(3, scheduler: MainScheduler.instance)
            .do(onSuccess: { user in
                self.userState.value = user
            })
    }
    
    func logout() -> Completable {
        return Single.just(()).asCompletable()
    }
}
