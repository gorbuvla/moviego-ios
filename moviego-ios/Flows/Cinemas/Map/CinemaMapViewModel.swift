//
//  CinemaMapViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import CoreLocation
import RxCoreLocation
import RxRelay
import MapKit

class CinemaMapViewModel: BaseViewModel {
    
    private let viewportSubject = PublishSubject<Viewport>()
    private let viewStateVariable = BehaviorRelay(value: State<[Cinema]>.loading)
    private let repository: CinemaRepositoring
    
    let locationManager: CLLocationManager
    
    var selectedAnnotation: MKAnnotation? = nil
    
    var viewState: StateObservable<[Cinema]> {
        get { return viewStateVariable.asObservable() }
    }
    
    init(repository: CinemaRepositoring) {
        self.repository = repository
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        super.init()
        bindUpdates()
    }
    
    func viewportDidChange(_ viewport: Viewport) {
        viewportSubject.onNext(viewport)
    }
    
    private func bindUpdates() {
        viewportSubject.take(1).debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { viewport in self.repository.fetchCinemas(lat: viewport.lat, lng: viewport.lng, radius: viewport.radius) }
            .mapState()
            .bind(to: viewStateVariable)
            .disposed(by: disposeBag)
    }
}

