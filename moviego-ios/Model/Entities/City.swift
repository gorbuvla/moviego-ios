//
//  City.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

struct City: Codable, Equatable {
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let pictureId: String
    let cinemasCount: Int
}
