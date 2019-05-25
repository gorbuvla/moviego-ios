//
//  RegistrationRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift

protocol RegistrationRepositoring {
    
    var name: String? { get set }
    var surname: String? { get set }
    var email: String? { get set }
    var password: String? { get set }
    var city: City? { get set }
    
    var credentials: RegisterCredentialsDTO { get }
}

struct RegisterCredentialsDTO {
    let name: String
    let surname: String
    let email: String
    let password: String
    let city: City
}

class RegistrationRepository: RegistrationRepositoring {
    
    var name: String?
    var surname: String?
    var email: String?
    var password: String?
    var city: City?
    
    var credentials: RegisterCredentialsDTO {
        get {
            assert(name != nil && surname != nil && email != nil && password != nil && city != nil)
            return RegisterCredentialsDTO(name: name!, surname: surname!, email: email!, password: password!, city: city!)
        }
    }
}

