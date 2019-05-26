//
//  DashboardViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import CoreLocation
import RxCoreLocation

class DashboardViewModel: BaseViewModel {
    
    private let locationManager: CLLocationManager
    private let fetcher: PagedFetcher<Movie>
    private let repository: CinemaRepositoring
    private let viewStateSubject = BehaviorSubject<State<[Movie]>>(value: .loading)
    private let sessionStateSubject = BehaviorSubject<State<[Session]>>(value: .loading)
    
    var viewState: StateObservable<[Movie]> {
        return viewStateSubject.asObserver()
    }
    
    var topSessions: StateObservable<[Session]> {
        return sessionStateSubject.asObservable()
    }
    
    var movies: [Movie] {
        get { return viewStateSubject.value.value ?? [] }
    }
    
    var sessions: [Session] {
        get { return sessionStateSubject.value.value ?? [] }
    }
    
    var canFetchMore: Bool {
        get { return fetcher.canFetchMore }
    }
    
    init(repository: CinemaRepositoring) {
        self.repository = repository
        self.fetcher = PagedFetcher(request: repository.fetchMovies)
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        super.init()
        bindUpdates()
        fetchInitial()
    }
    
    func fetchInitial() {
        fetcher.fetchInitial()
    }
    
    func fetchNext() {
        fetcher.fetchNext()
    }
    
    private func bindUpdates() {
        fetcher.pagedResult
            .mapState()
            .bind(to: viewStateSubject)
            .disposed(by: disposeBag)        
        
        locationManager.rx.location
            .take(1)
            .asObservable()
            .flatMap { location in
                self.repository.fetchSessions(startingFrom: Date(), lat: location?.coordinate.latitude, lng: location?.coordinate.longitude, limit: 10, offset: 0)
            }
            .mapState()
            .bind(to: sessionStateSubject)
            .disposed(by: disposeBag)
    }
}
