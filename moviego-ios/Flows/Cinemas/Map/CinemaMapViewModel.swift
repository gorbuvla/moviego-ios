//
//  CinemaMapViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import CoreLocation

class CinemaMapViewModel: BaseViewModel {
    
    private let viewportSubject = PublishSubject<Viewport>()
    private let viewStateVariable = Variable(LoadingResult<[Cinema]>(false))
    private let repository: CinemaRepositoring
    
    let locationManager: CLLocationManager
    
    var viewState: ObservableProperty<[Cinema]> {
        get { return viewStateVariable.asObservable() }
    }
    
    init(repository: CinemaRepositoring) {
        self.repository = repository
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func viewportDidChange(_ viewport: Viewport) {
        viewportSubject.onNext(viewport)
    }
    
    private func bindUpdates() {
        viewportSubject.debounce(1, scheduler: MainScheduler.instance)
            .flatMap { viewport in self.repository.fetchByGeo(lat: viewport.lat, lng: viewport.lng, radius: viewport.radius) }
            .mapLoading() // TODO: this should emit loading every time viewport changes... 
            .bind(to: viewStateVariable)
            .disposed(by: disposeBag)
    }
}

