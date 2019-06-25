//
//  MovieApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class MovieApiService  {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchMovies(for cinemaId: Int? = nil, offset: Int = 0, limit: Int = 0) -> Single<[Movie]> {
        let params = [
            "cinemaId": cinemaId,
            "offset": offset,
            "limit": limit
        ]
        return interactor.request("/api/movies", method: .get, parameters: params.nilsRemoved, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Movie].self)
            .asSingle()
    }
}
