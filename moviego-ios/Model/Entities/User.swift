//
//  User.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

struct User: Codable {
    let name: String
}

struct UserWithCredentials: Codable {
    let user: User
    let credentials: Credentials
}
