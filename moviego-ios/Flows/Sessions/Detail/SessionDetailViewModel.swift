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
    
    private let movieRelay: BehaviorRelay<State<Movie>>
    private let sessionsRelay: BehaviorRelay<State<[SessionType:[Session]]>>
    private let cinemasRelay: BehaviorRelay<State<[Cinema]>>
    
    var selectedCinema: Observable<Cinema?> {
        get { return cinemaRelay.asObservable() }
    }
    
    var selectedDate: Observable<Date> {
        get { return dateRelay.asObservable() }
    }
    
    var cinemas: StateObservable<[Cinema]> {
        get { return cinemasRelay.asObservable() }
    }

    var sessions: StateObservable<[SessionType:[Session]]> {
        get { return sessionsRelay.asObservable() }
    }
    
    var movie: StateObservable<Movie> {
        get { return movieRelay.asObservable() }
    }
    
    var sessionList: [SessionType:[Session]] {
        get { return sessionsRelay.value.value ?? [:] }
    }
    
    init(movieId: Int, cinemaRepository: CinemaRepositoring) {
        self.cinemaRepository = cinemaRepository
        self.cinemaRelay = BehaviorRelay(value: nil)
        self.dateRelay = BehaviorRelay(value: Date())
        
        self.movieRelay = BehaviorRelay(value: .loading)
        self.cinemasRelay = BehaviorRelay(value: .loading)
        self.sessionsRelay = BehaviorRelay(value: .loading)
        super.init()
        
        bindUpdates(movieId)
    }
    
    init(movie: Movie, cinema: Cinema? = nil, cinemaRepository: CinemaRepositoring) {
        self.cinemaRepository = cinemaRepository
        self.cinemaRelay = BehaviorRelay(value: cinema)
        self.dateRelay = BehaviorRelay(value: Date())
        
        self.movieRelay = BehaviorRelay(value: .value(movie))
        self.cinemasRelay = BehaviorRelay(value: .loading)
        self.sessionsRelay = BehaviorRelay(value: .loading)
        super.init()
        
        bindUpdates(movie)
    }
    
    func select(_ cinema: Cinema) {
        cinemaRelay.accept(cinema)
    }
    
    func select(_ date: Date) {
        dateRelay.accept(date)
    }
    
    private func bindUpdates(_ movieId: Int) {
        cinemaRepository.fetchMovie(id: movieId)
            .asObservable()
            .do(onNext: { [weak self] movie in self?.bindUpdates(movie) })
            .mapState()
            .bind(to: movieRelay)
            .disposed(by: disposeBag)
    }
    
    private func bindUpdates(_ movie: Movie) {
        movieRelay.accept(.value(movie))
        
        cinemaRepository.fetchCinema(for: movie)
            .asObservable()
            .mapState()
            .bind(to: cinemasRelay)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(cinemaRelay.asObservable().compactMap { $0 }, dateRelay.asObservable()) { ($0, $1) }
            .flatMap { params in
                self.cinemaRepository.fetchSessions(for: movie, in: params.0, startingAt: params.1)
                    .map { sessions in Dictionary(grouping: sessions, by: { $0.type })
                }
            }
            .mapState()
            .bind(to: sessionsRelay)
            .disposed(by: disposeBag)
    }
}
