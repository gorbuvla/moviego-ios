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

class ShowtimeListViewModel: BaseViewModel {
    
    private let repository: ShowtimeRepositoring
    private let viewStateVariable = Variable(LoadingResult<[Showtime]>(false))
    
    var viewState: ObservableProperty<[Showtime]> {
        get { return viewStateVariable.asObservable() }
    }
    
    var data: [Showtime] {
        get { return viewStateVariable.value.data?.element ?? [] }
    }
    
    init(repository: ShowtimeRepositoring) {
        self.repository = repository
    }
    
    func fetchInitial() {
        
        repository.fetchShowtimes(for: nil, movieId: nil, startingFrom: Date(), lat: nil, lng: nil, orderBy: .time, limit: 20, offset: 0)
    }
    
    func fetchNext() {
        
    }
}
