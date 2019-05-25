//
//  BasePickCityViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

class ChooseCityViewModel: BaseViewModel {
    
    private let cityApi: CityApiServicing
    private let viewStateSubject = BehaviorSubject(value: LoadingResult<[City]>(false))
    private let continuationSubject = PublishSubject<LoadingResult<City>>()
    
    var viewState: ObservableProperty<[City]> {
        get { return viewStateSubject.asObservable() }
    }
    
    var continuation: ObservableProperty<City> {
        return continuationSubject.asObservable()
    }
    
    var data: [City] {
        get { return viewStateSubject.value.data?.element ?? [] }
    }
    
    init(cityApi: CityApiServicing) {
        self.cityApi = cityApi
        super.init()
        fetchCities()
    }
    
    func selectCity(_ city: City) {
        saveSelection(city)
            .asObservable()
            .mapLoading()
            .bind(to: continuationSubject)
            .disposed(by: disposeBag)
    }
    
    open func saveSelection(_ city: City) -> Single<City> {
        return Single.just(city)
    }
    
    private func fetchCities() {
        cityApi.fetchCities()
            .asObservable()
            .mapLoading()
            .bind(to: viewStateSubject)
            .disposed(by: disposeBag)
    }
}
