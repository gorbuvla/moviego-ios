//
//  Credentials.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

struct Credentials: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

enum LoginCredentials {
    case password(username: String, password: String)
}

struct RegisterCredentials: Codable {
    let name: String
    let surname: String
    let email: String
    let password: String
    let preferredCityId: Int
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
