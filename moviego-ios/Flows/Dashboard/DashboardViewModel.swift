//
//  DashboardViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
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

class PagedFetcher<T> {
    private let DEFAULT_PAGE_LIMIT = 10
    private let disposeBag = DisposeBag()
    private let pagerSubject = BehaviorSubject<[T]>(value: [])
    
    private let request: (Int, Int) -> Single<[T]>
    
    private(set) var canFetchMore: Bool = true
    
    var pagedResult: Observable<[T]> {
        return pagerSubject.asObservable()
    }
    
    init(request: @escaping (Int, Int) -> Single<[T]>) {
        self.request = request
    }
    
    func fetchInitial() {
        request(0, DEFAULT_PAGE_LIMIT).asObservable()
            .bind(to: pagerSubject)
            .disposed(by: disposeBag)
    }
    
    func fetchNext() {
        request(pagerSubject.value.count, DEFAULT_PAGE_LIMIT)
            .do(onSuccess: { page in self.canFetchMore = page.count == self.DEFAULT_PAGE_LIMIT })
            .map { page in self.pagerSubject.value + page }
            .asObservable()
            .bind(to: pagerSubject)
            .disposed(by: disposeBag)
    }
}
