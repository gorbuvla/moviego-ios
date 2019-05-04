//
//  ShowtimeApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 02/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift

protocol ShowtimeApiServicing {
    
    func fetchShowtimes(for cinema: Cinema, movieId: Int?, startingFrom: Date, limit: Int, offset: Int) -> Single<[Showtime]>
    
    func fetchShowtimes(movieId: Int?, startingFrom: Date, lat: Float?, lng: Float?, orderBy: ShowtimeOrderBy, limit: Int, offset: Int) -> Single<[Showtime]>
}

class ShowtimeApiService {}
