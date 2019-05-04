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

enum RegisterCredentials {
    case form(name: String, password: String)
}
