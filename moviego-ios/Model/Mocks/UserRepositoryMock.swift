//
//  UserRepositoryMock.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 25/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxRelay

class MockedUserRepository: UserRepositoring {
    
    private var credentialsStore: CredentialsStore
    private let userVariable: BehaviorRelay<User?>
    
    var currentUser: User? {
        return userVariable.value
    }
    
    var user: Observable<User?> {
        get { return userVariable.asObservable() }
    }
    
    init(credentialsStore: CredentialsStore) {
        self.credentialsStore = credentialsStore
        self.userVariable = BehaviorRelay(value: credentialsStore.user)
    }
    
    func changeCity(to city: City) -> Completable {
        return Observable.just(()).asSingle().asCompletable() // jackie chan meme
    }
    
    func login(credentials: LoginCredentials) -> Single<User> {
        guard case .password(let email, let password) = credentials else { return Single.error(ApiException.unauthorized) }
        
        var singleSource: Single<UserWithCredentials> = Single.error(ApiException.unauthorized)
        
        if email == "movielover@moviego.me" && password == "password" {
            singleSource = Single.just(UserWithCredentials(id: 1, name: "Hackerman", email: "movielover@moviego.me", avatarId: "user_avatars/hackerman.jpg", city: City(id: 2, name: "Prague", pictureId: "id", cinemasCount: 2), credentials: Credentials(accessToken: "AT", refreshToken: "RT", expiresIn: 3600))).delay(.seconds(1), scheduler: MainScheduler.instance)
        }
        
        return singleSource.do(onSuccess: { [weak self] userWithCredentials in
            print("all ok, \(self == nil)")
            self?.credentialsStore.user = userWithCredentials.user
            self?.credentialsStore.credentials = userWithCredentials.credentials
            self?.userVariable.accept(userWithCredentials.user)
        }).map { $0.user }
    }
    
    func register(credentials: RegisterCredentials) -> Single<User> {
        return Single.just(User(id: 1, name: credentials.name, email: credentials.surname, avatarId: nil, preferredCityId: credentials.preferredCityId))
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .do(onSuccess: { u in
                self.userVariable.accept(u)
            })
    }
    
    func logout() -> Completable {
        return Completable.create { [weak self] completable in
            self?.credentialsStore.user = nil
            self?.credentialsStore.credentials = nil
            self?.userVariable.accept(nil)
            
            completable(.completed)
            return Disposables.create {}
        }
    }
}
