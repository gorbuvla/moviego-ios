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
    
    private var credentialsStore: CredentialsStore
    private let userVariable: Variable<User?>
    
    var user: Observable<User?> {
        get { return userVariable.asObservable() }
    }
    
    init(credentialsStore: CredentialsStore) {
        self.credentialsStore = credentialsStore
        self.userVariable = Variable(credentialsStore.user)
    }
    
    func login(credentials: LoginCredentials) -> Single<User> {
        guard case .password(let email, let password) = credentials else { return Single.error(ApiException.unauthorized) }
        
        var singleSource: Single<UserWithCredentials> = Single.error(ApiException.unauthorized)
        
        if email == "movielover@moviego.me" && password == "password" {
            singleSource = Single.just(UserWithCredentials(id: 1, name: "Hackerman", email: "movielover@moviego.me", avatarId: "user_avatars/hackerman", city: City(id: 2, name: "Prague", pictureId: "id", cinemasCount: 2), credentials: Credentials(accessToken: "AT", refreshToken: "RT", expiresIn: 3600)))
        }

        return singleSource.do(onSuccess: { [weak self] userWithCredentials in
                self?.credentialsStore.user = userWithCredentials.user
                self?.credentialsStore.credentials = userWithCredentials.credentials
                self?.userVariable.value = userWithCredentials.user
            }).map { $0.user }
            .delay(3, scheduler: MainScheduler.instance)
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
