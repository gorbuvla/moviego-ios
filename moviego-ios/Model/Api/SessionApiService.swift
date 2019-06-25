//
//  SessionApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class SessionApiService {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchSessions(startingAt: Date, lat: Double?, lng: Double?, limit: Int, offset: Int) -> Single<[Session]> {
        let params: [String: Any?] = [
            "startingAt": startingAt,
            "lat": lat,
            "lng": lng,
            "limit": limit,
            "offset": offset
        ]
        
        return interactor.request("/api/sessions", method: .get, parameters: params.nilsRemoved, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Session].self)
            .asSingle()
    }
    
    func fetchSessions(movieId: Int, cinemaId: Int, startingAt: Date) -> Single<[Session]> {
        let params: [String: Any] = [
            "movieId": movieId,
            "cinemaId": cinemaId,
            "startingAt": startingAt,
            "offset": 0,
            "limit": 100
        ]
        
        return interactor.request("/api/sessions", method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Session].self)
            .asSingle()
    }
}

