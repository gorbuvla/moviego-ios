//
//  PromotionApiService.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 26/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class PromotionApiService {
    
    private let interactor: ApiInteracting
    
    init(interactor: ApiInteracting) {
        self.interactor = interactor
    }
    
    func fetchPromotions() -> Single<[Promotion]> {
        return interactor.request("/api/promotions", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .mapObject(to: [Promotion].self)
            .asSingle()
    }
}
