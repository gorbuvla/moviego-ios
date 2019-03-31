//
//  CredentialsProvider.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol CredentialsProvider {
    var credentials: Credentials? { get }
    var user: User? { get }
}

protocol CredentialsStore {
    var credentials: Credentials? { get set }
    var user: User? { get set }
}

extension UserDefaults: CredentialsStore, CredentialsProvider {
    
    static let defaultStore = UserDefaults(suiteName: (Bundle.main.bundleIdentifier ?? "") + ".user+credentials")!
    
    private enum Keys {
        static let credentials = "credentials"
        static let user = "user"
    }
    
    var credentials: Credentials? {
        get { return decode(key: Keys.credentials)}
        set { encode(value: credentials, key: Keys.credentials)}
    }
    
    var user: User? {
        get { return decode(key: Keys.user)}
        set { encode(value: user, key: Keys.user)}
    }
    
    private func decode<Type: Decodable>(key: String) -> Type? {
        guard let data = object(forKey: key) as? Data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Type.self, from: data)
    }
    
    private func encode<Type: Encodable>(value: Type?, key: String) {
        if let value = value {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(value)
            set(data, forKey: key)
        } else {
            removeObject(forKey: key)
        }
        synchronize()
    }
}
