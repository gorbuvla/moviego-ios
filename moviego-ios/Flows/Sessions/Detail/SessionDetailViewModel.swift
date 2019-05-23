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
    let sessions: [Session]?
    
    init(movie: Movie, cinema: Cinema, sessions: [Session]? = nil) {
        self.movie = movie
        self.cinema = cinema
        self.sessions = sessions
    }
}
