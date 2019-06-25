//
//  UserRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

protocol UserRepositoring {
    
    var currentUser: User? { get }
    var user: Observable<User?> { get }
    
    func login(credentials: LoginCredentials) -> Single<User>
    func register(credentials: RegisterCredentials) -> Single<User>
    func logout() -> Completable
    
    func changeCity(to city: City) -> Completable
}

class UserRepository: UserRepositoring {
    
    private var credentialsStore: CredentialsStore
    private let oauthApi: OAuthApiServicing
    private let userVariable: BehaviorSubject<User?>
    
    var currentUser: User? {
        get { return try! userVariable.value() }
    }
    
    var user: Observable<User?> {
        get { return userVariable.asObservable() }
    }
    
    init(credentialsStore: CredentialsStore, oauthApi: OAuthApiServicing) {
        self.oauthApi = oauthApi
        self.credentialsStore = credentialsStore
        self.userVariable = BehaviorSubject(value: credentialsStore.user)
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
            self?.userVariable.onNext(userWithCredentials.user)
        }).map { $0.user }
    }
    
    func register(credentials: RegisterCredentials) -> Single<User> {
        return oauthApi.register(credentials: credentials)
            .do(onSuccess: { [weak self] userWithCredentials in
                self?.credentialsStore.user = userWithCredentials.user
                self?.credentialsStore.credentials = userWithCredentials.credentials
                self?.userVariable.onNext(userWithCredentials.user)
            })
            .map { $0.user }
    }
    
    func logout() -> Completable {
        return Completable.create { [weak self] completable in
            self?.credentialsStore.user = nil
            self?.credentialsStore.credentials = nil
            self?.userVariable.onNext(nil)
            
            completable(.completed)
            return Disposables.create {}
        }
    }
    
    func changeCity(to city: City) -> Completable {
        return Observable.just(()).asSingle().asCompletable() // jackie chan meme
    }
}
