//
//  MovieDetailViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    
    private let repository: CinemaRepositoring
    let movie: Movie
    
    init(movie: Movie, repository: CinemaRepositoring) {
        self.movie = movie
        self.repository = repository
    }
}
