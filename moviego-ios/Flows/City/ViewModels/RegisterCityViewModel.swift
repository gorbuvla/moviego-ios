//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxCocoa

class RegisterCityViewModel: BasePickCityViewModel {
    
    private let repository: RegistrationRepositoring
    private let continuationSubject: PublishSubject<LoadingResult<()>> = PublishSubject.init()
    
    override var continuationState: ObservableProperty<()> {
        get { return continuationSubject.asObservable() }
    }
    
    init(cityApi: CityApiServicing, repository: RegistrationRepositoring) {
        self.repository = repository
        super.init(cityApi: cityApi)
    }
    
    override func selectCity(_ city: City) {
        super.selectCity(city)
        
        // TODO: notify data source
    }
    
    override func register() {
        // TODO: send api request, handle result appropriately
    }
}
