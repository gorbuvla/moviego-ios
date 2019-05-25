//
//  BaseMapView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import MapKit

class BaseMapView: BaseView {
    
    weak var mapView: MKMapView!
    
    override func createView() {
        mapView = ui.mapView { it in
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
