//
//  SessionDetailViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class SessionDetailViewModel: BaseViewModel {
    
    let movie: Movie
    let cinema: Cinema
    
    init(movie: Movie, cinema: Cinema) {
        self.movie = movie
        self.cinema = cinema
    }
}
