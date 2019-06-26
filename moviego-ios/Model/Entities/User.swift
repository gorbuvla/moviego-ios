//
//  User.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

struct UserWithCredentials: Codable {
    let id: Int
    let name: String
    let email: String
    let avatarId: String?
    let city: City
    let credentials: Credentials
    
    var user: User {
        get { return User(id: id, name: name, email: email, avatarId: avatarId, preferredCityId: city.id) }
    }
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let avatarId: String?
    let preferredCityId: Int
}

struct ServiceUser: Codable {
    let avatarId: String?
    let name: String
}
