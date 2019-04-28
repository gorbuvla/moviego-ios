//
//  BasePickCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

protocol CitySelectModeling {
    
    var viewState: ObservableProperty<[(City, Bool)]> { get }
    
    var continuationState: ObservableProperty<()> { get }
    
    var data: [(City, Bool)] { get }
    
    func selectCity(_ city: City)
    
    func register()
}

class BasePickCityViewModel: BaseViewModel, CitySelectModeling {
    
    private let cityApi: CityApiServicing
    private let viewStateObserver: Variable<LoadingResult<[(City, Bool)]>>
    
    var viewState: ObservableProperty<[(City, Bool)]> {
        get { return viewStateObserver.asObservable() }
    }
    
    var continuationState: ObservableProperty<()> {
        get { return PublishSubject.init().asObservable() }
    }
    
    var data: [(City, Bool)] {
        get { return viewStateObserver.value.data?.element ?? [] }
    }
    
    init(cityApi: CityApiServicing) {
        self.cityApi = cityApi
        self.viewStateObserver = Variable(LoadingResult(false))
        super.init()
        fetchCities()
    }
    
    func selectCity(_ city: City) {
        guard let cities = viewStateObserver.value.data?.element else { return }
        
        let selection = cities.map { option in (option.0, option.0 == city ? !option.1 : false) }
        viewStateObserver.value = LoadingResult(.next(selection))
    }
    
    func register() {}
    
    private func fetchCities() {
        cityApi.fetchCities()
            .map { cities in
                print("fetched cities: \(cities)")
                return cities.map { ($0, false) }
            }
            .asObservable()
            .mapLoading()
            .bind(to: viewStateObserver)
            .disposed(by: disposeBag)
    }
}
