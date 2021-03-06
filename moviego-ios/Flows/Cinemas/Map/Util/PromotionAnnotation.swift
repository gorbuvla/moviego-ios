//
//  PromotionAnnotation.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import MapKit

class PromotionAnnotation: NSObject, MKAnnotation {
    
    enum ReuseIdentifiers {
        static let defaultId = "promoId"
    }
    
    let promotion: Promotion
    
    init(promotion: Promotion) {
        self.promotion = promotion
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: promotion.lat, longitude: promotion.lng)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return promotion.movie.imdbId == (object as? PromotionAnnotation)?.promotion.movie.imdbId
    }
}
