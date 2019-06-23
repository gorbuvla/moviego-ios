//
//  SessionDetailViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxRelay
import Foundation

class SessionDetailViewModel: BaseViewModel {
    
    private let cinemaRepository: CinemaRepositoring
    private let cinemaRelay: BehaviorRelay<Cinema?>
    private let dateRelay: BehaviorRelay<Date>
    
    private let sessionsRelay: BehaviorRelay<State<[Session]>>
    private let cinemasRelay: BehaviorRelay<State<[Cinema]>>
    
    let movie: Movie
    let cinema: Cinema?
    
    var cinemas: StateObservable<[Cinema]> {
        get { return cinemasRelay.asObservable() }
    }
    
    var sessions: StateObservable<[Session]> {
        get { return sessionsRelay.asObservable() }
    }
    
    var sessionList: [Session] {
        get { return sessionsRelay.value.value ?? [] }
    }
    
    init(movie: Movie, cinema: Cinema? = nil, cinemaRepository: CinemaRepositoring) {
        self.movie = movie
        self.cinema = cinema
        self.cinemaRepository = cinemaRepository
        self.cinemaRelay = BehaviorRelay(value: cinema)
        self.dateRelay = BehaviorRelay(value: Date())
        
        self.cinemasRelay = BehaviorRelay(value: .loading)
        self.sessionsRelay = BehaviorRelay(value: .loading)
        super.init()
        
        bindUpdates()
    }
    
    func select(_ cinema: Cinema) {
        cinemaRelay.accept(cinema)
    }
    
    func select(_ date: Date) {
        dateRelay.accept(date)
    }
    
    private func bindUpdates() {
        cinemaRepository.fetchCinema(for: movie)
            .asObservable()
            .mapState()
            .bind(to: cinemasRelay)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(cinemaRelay.asObservable().compactMap { $0 }, dateRelay.asObservable()) { ($0, $1) }
            .flatMap { params in
                 self.cinemaRepository.fetchSessions(for: self.movie, in: params.0, startingAt: params.1)
            }
            .mapState()
            .bind(to: sessionsRelay)
            .disposed(by: disposeBag)
    }
}
