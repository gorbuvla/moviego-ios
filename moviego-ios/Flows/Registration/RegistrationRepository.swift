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
    
    var email: String? { get set }
    var name: String? { get set }
    var password: String? { get set }
    //var city: City { get set } // todo: uncomment once api model added
    
    var credentials: Observable<RegisterCredentialsDTO> { get }
}

struct RegisterCredentialsDTO {
    var name: String? = nil
    var email: String? = nil
    var password: String? = nil
}

class RegistrationRepository: RegistrationRepositoring {
    
    private let credentialsvariable = Variable<RegisterCredentialsDTO>(RegisterCredentialsDTO(name: nil, email: nil, password: nil))
    
    var email: String? {
        didSet {
           credentialsvariable.value.email = email
        }
    }
    
    var name: String? {
        didSet {
            credentialsvariable.value.name = name
        }
    }
    
    var password: String? {
        didSet {
            credentialsvariable.value.password = password
        }
    }
    
    var credentials: Observable<RegisterCredentialsDTO> {
        get { return credentialsvariable.asObservable() }
    }
}

