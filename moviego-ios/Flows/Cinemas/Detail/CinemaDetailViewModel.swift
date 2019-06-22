//
//  CinemaDetailViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import RxRelay

final class CinemaDetailViewModel: BaseViewModel {
    
    private let viewStateRelay = BehaviorRelay<State<[Movie]>>(value: .loading)
    private let fetcher: PagedFetcher<Movie>
    private let repository: CinemaRepositoring
    let cinema: Cinema
    
    var canFetchMore: Bool {
        get { return fetcher.canFetchMore }
    }
    
    var viewState: StateObservable<[Movie]> {
        get { return viewStateRelay.asObservable() }
    }
    
    var movies: [Movie] {
        get { return viewStateRelay.value.value ?? [] }
    }
    
    init(cinema: Cinema, repository: CinemaRepositoring) {
        self.cinema = cinema
        self.repository = repository
        self.fetcher = PagedFetcher(request: { offset, limit in repository.fetchMovies(for: cinema, offset: offset, limit: limit) })
        super.init()
        self.fetcher.fetchInitial()
        bindUpdates()
    }
    
    func fetchNext() {
        fetcher.fetchNext()
    }
    
    private func bindUpdates() {
        fetcher.pagedResult
            .mapState()
            .bind(to: viewStateRelay)
            .disposed(by: disposeBag)
    }
}
