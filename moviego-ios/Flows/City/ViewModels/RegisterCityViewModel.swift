//
//  RegisterCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxCocoa

class RegisterCityViewModel: BaseViewModel, CitySelectModeling {
    private let cityApi: CityApiServicing
    private let repository: RegistrationRepositoring
    private let viewStateObserver: Variable<LoadingResult<[(City, Bool)]>>
    
    private
    
    var viewState: ObservableProperty<[(City, Bool)]> {
        get { return viewStateObserver.asObservable() }
    }
    
    var cities: [(City, Bool)] {
        get { return viewStateObserver.value.data?.element ?? [] }
    }
    
    init(cityApi: CityApiServicing, repository: RegistrationRepositoring) {
        self.cityApi = cityApi
        self.repository = repository
        self.viewStateObserver = Variable(LoadingResult(false))
    }
    
    func selectCity(_ city: City) {
        guard cities.isNotEmpty else { return }
        
        let selection = cities.map { option in (option.0, option.0 == city ? !option.1 : false) }
        viewStateObserver.value = LoadingResult(.next(selection))
    }
    
    private func fetchCities() {
        cityApi.fetchCities()
            .map { cities in cities.map { ($0, false) } }
            .asObservable()
            .mapLoading()
            .bind(to: viewStateObserver)
            .disposed(by: disposeBag)
    }
}
