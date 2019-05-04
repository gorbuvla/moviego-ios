//
//  CinemaApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 03/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Alamofire

protocol CinemaApiServicing {
    
    func fetchByDistance(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]>
    
    func fetchBy(by: CinemaOrderBy, lat: Float?, lng: Float?) -> Single<[Cinema]>
}

enum CinemaOrderBy: String {
    case distance = "distance"
    case userRating = "userRating"
}


class CinemaApiService: CinemaApiServicing  {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchByDistance(lat: Float?, lng: Float?, radius: Double?) -> Single<[Cinema]> {
        let params: [String: Any?] = [
            "lat": lat,
            "lng": lng,
            "radius": radius
        ]
        
        return interactor.request("/cinemas", method: .get, parameters: params.nilsRemoved, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Cinema].self)
            .asSingle()
    }
    
    func fetchBy(by: CinemaOrderBy, lat: Float?, lng: Float?) -> Single<[Cinema]> {
        let params: [String: Any?] = [
            "lat": lat,
            "lng": lng,
            "orderBy": by.rawValue
        ]
        
        return interactor.request("/cinemas", method: .get, parameters: params.nilsRemoved, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Cinema].self)
            .asSingle()
    }
}
