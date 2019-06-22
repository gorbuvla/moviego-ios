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
    
    private let cinemaRelay: BehaviorRelay<Cinema?>
    private let dateRelay: BehaviorRelay<Date>
    
    let movie: Movie
    let cinema: Cinema?
    
    init(movie: Movie, cinema: Cinema? = nil) {
        self.movie = movie
        self.cinema = cinema
        self.cinemaRelay = BehaviorRelay(value: cinema)
        self.dateRelay = BehaviorRelay(value: Date())
    }
}
