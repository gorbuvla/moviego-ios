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
    private let cinemasRelay = BehaviorRelay(value: State<[Cinema]>.loading)
    private let promotionsRelay = BehaviorRelay(value: [Promotion]())
    private let repository: CinemaRepositoring
    
    private let locationManager: CLLocationManager
    
    var selectedAnnotation: MKAnnotation? = nil
    
    var cinemasState: StateObservable<[Cinema]> {
        get { return cinemasRelay.asObservable() }
    }
    
    var promotionsState: Observable<[Promotion]> {
        get {
            return Observable.combineLatest(locationManager.rx.location.compactMap { $0 }, promotionsRelay) { ($0, $1) }
                .map {
                    let (location, promotions) = $0
                    return promotions.filter { location.distance(from: $0.location) < Double(Environment.promotionRadius) }
                }
                .distinctUntilChanged()
        }
    }
    
    init(repository: CinemaRepositoring) {
        self.repository = repository
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
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
            .bind(to: cinemasRelay)
            .disposed(by: disposeBag)
        
        repository.fetchPromotions()
            .asObservable()
            .bind(to: promotionsRelay)
            .disposed(by: disposeBag)
    }
}
