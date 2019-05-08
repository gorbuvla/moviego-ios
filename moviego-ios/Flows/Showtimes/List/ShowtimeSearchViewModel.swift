//
//  MovieListViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Foundation
import CoreLocation
import RxCoreLocation
import RxCocoa
import RxRelay

class ShowtimeSearchViewModel: BaseViewModel {
    
    static let DEFAULT_LIMIT = 10
    
    private let showtimeRepository: ShowtimeRepositoring
    private let userRepository: UserRepositoring
    private let locationManager = CLLocationManager()
    private let viewStateVariable = BehaviorSubject(value: LoadingResult<[ShowtimeSearchItem]>(false))
    
    // stored values by which search is affected
    private let searchLocationRelay = BehaviorRelay<CLLocation?>(value: nil)
    private let searchDateRelay = BehaviorRelay(value: Date())
    
    private var mutableData: [ShowtimeSearchItem] = []
    
    var profileImageId: String? {
        return userRepository.currentUser?.avatarId
    }
    
    var canFetchMore: Bool = true
    
    var lastKnownLocation: CLLocation? {
        get { return locationManager.location }
    }
    
    var viewState: ObservableProperty<[ShowtimeSearchItem]> {
        get { return viewStateVariable.asObservable() }
    }
    
    var data: [ShowtimeSearchItem] {
        return mutableData
    }
    
    init(showtimeRepository: ShowtimeRepositoring, userRepository: UserRepositoring) {
        self.showtimeRepository = showtimeRepository
        self.userRepository = userRepository
        super.init()
        fetchInitial()
    }
    
    func fetchInitial() {
        locationManager.rx.location
            .take(1)
            .bind(onNext: { [weak self] location in
                self?.searchDateRelay.accept(Date())
                self?.searchLocationRelay.accept(location)
                
                self?.fetch(location: location, date: Date(), offset: 0)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchNext() {
        fetch(location: searchLocationRelay.value, date: searchDateRelay.value, offset: mutableData.count)
    }
    
    func requestPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func fetch(location: CLLocation?, date: Date, offset: Int = 0) {
        guard canFetchMore else { return }
        
            showtimeRepository.searchShowtimes(
                    startingFrom: date,
                    lat: location?.coordinate.latitude,
                    lng: location?.coordinate.latitude,
                    limit: ShowtimeSearchViewModel.DEFAULT_LIMIT,
                    offset: offset
                ).asObservable()
            .do(onNext: { searchItems in
                self.canFetchMore = searchItems.count == ShowtimeSearchViewModel.DEFAULT_LIMIT
                self.mutableData = offset == 0 ? searchItems : self.mutableData + searchItems
            })
            .mapLoading()
            .bind(to: viewStateVariable)
            .disposed(by: disposeBag)
    }
}
