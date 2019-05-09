//
//  CinemaDetailViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

class CinemaDetailViewModel: BaseViewModel {
    
    let cinema: Cinema
    
    init(cinema: Cinema) {
        self.cinema = cinema
    }
}
