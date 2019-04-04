//
//  UserRepository.swift
//  ios-skeleton
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
        return Single.just(User(name: "Mocked User"))
    }
    
    func logout() -> Completable {
        return Single.just(()).asCompletable()
    }
}
