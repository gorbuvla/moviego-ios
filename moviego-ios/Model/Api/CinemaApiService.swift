//
//  CinemaApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 03/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift
import Alamofire

class CinemaApiService  {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchMovies(movieId: Int? = nil, lat: Float? = nil, lng: Float? = nil, radius: Double? = nil) -> Single<[Cinema]> {
        let params: [String: Any?] = [
            "movieId": movieId,
            "lat": lat,
            "lng": lng,
            "radius": radius
        ]
        
        return interactor.request("/api/cinemas", method: .get, parameters: params.nilsRemoved, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Cinema].self)
            .asSingle()
    }
}
