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
    private let viewStateSubject = BehaviorSubject(value: State<[City]>.loading)
    private let continuationSubject = PublishSubject<State<City>>()
    
    var viewState: StateObservable<[City]> {
        get { return viewStateSubject.asObservable() }
    }
    
    var continuation: StateObservable<City> {
        return continuationSubject.asObservable()
    }
    
    var data: [City] {
        get { return viewStateSubject.value.value ?? [] }
    }
    
    init(cityApi: CityApiServicing) {
        self.cityApi = cityApi
        super.init()
        fetchCities()
    }
    
    func selectCity(_ city: City) {
        if city.name != "Prague" {
            continuationSubject.onNext(.error(UnsupportedCityError(message: L10n.Registration.ChooseCity.Unsupported.message(city.name))))
            return
        }
        
        saveSelection(city)
            .asObservable()
            .mapState()
            .bind(onNext: { city in
                // because bind:to does not dispose same observer from previous saveSelection...
                self.continuationSubject.onNext(city)
            })
            .disposed(by: disposeBag)
    }
    
    open func saveSelection(_ city: City) -> Single<City> {
        return Single.just(city)
    }
    
    private func fetchCities() {
        cityApi.fetchCities()
            .asObservable()
            .mapState()
            .bind(to: viewStateSubject)
            .disposed(by: disposeBag)
    }
}

struct UnsupportedCityError: Error {
    let message: String
}
