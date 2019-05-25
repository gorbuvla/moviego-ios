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
    private let viewStateSubject = BehaviorSubject<LoadingResult<[Movie]>>(value: LoadingResult(false))
    private let sessionStateSubject = BehaviorSubject<LoadingResult<[Session]>>(value: LoadingResult(false))
    
    var viewState: ObservableProperty<[Movie]> {
        return viewStateSubject.asObserver()
    }
    
    var topSessions: ObservableProperty<[Session]> {
        return sessionStateSubject.asObservable()
    }
    
    var movies: [Movie] {
        get { return viewStateSubject.value.data?.element ?? [] }
    }
    
    var sessions: [Session] {
        get { return sessionStateSubject.value.data?.element ?? [] }
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
            .mapLoading()
            .bind(to: viewStateSubject)
            .disposed(by: disposeBag)
        
        locationManager.rx.location
            .take(1)
            .asObservable()
            .flatMap { location in
                self.repository.fetchSessions(startingFrom: Date(), lat: location?.coordinate.latitude, lng: location?.coordinate.longitude, limit: 10, offset: 0)
            }
            .mapLoading()
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

extension BehaviorSubject {
    
    var value: Element {
        return try! self.value()
    }
}
