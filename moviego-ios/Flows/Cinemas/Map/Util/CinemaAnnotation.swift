//
//  CinemaMapAnnotation.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 08/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import MapKit

class CinemaAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let cinema: Cinema
    
    init(cinema: Cinema) {
        title = cinema.name
        subtitle = cinema.address
        self.cinema = cinema
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: cinema.lat, longitude: cinema.lng)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return cinema.id == (object as? CinemaAnnotation)?.cinema.id
    }
}
