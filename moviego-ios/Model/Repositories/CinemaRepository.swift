//
//  CinemaRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

protocol CinemaRepositoring {
    
    func fetchByGeo(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]>
    
    func fetch(by orderBy: CinemaOrderBy, lat: Float?, lng: Float?) -> Single<[Cinema]>
}


