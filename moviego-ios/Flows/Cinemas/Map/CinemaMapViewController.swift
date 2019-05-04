//
//  CinemaMapViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class CinemaMapViewController: BaseViewController<BaseMapView>, MKMapViewDelegate {
    
    private let viewModel: CinemaMapViewModel
    
    init(viewModel: CinemaMapViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.mapView.delegate = self
        
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] cinemas in
                guard let mapView = layout?.mapView else { return }
                
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        viewModel.viewportDidChange(mapView.currentViewport)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}

struct Viewport {
    let lat: Float
    let lng: Float
    let radius: Double
}

extension MKMapView {
    
    var currentViewport: Viewport {
        get {
            let topRight = convert(CGPoint(x: bounds.width, y: 0), toCoordinateFrom: self)
            let topLeft = convert(CGPoint(x: 0, y: 0), toCoordinateFrom: self)
            let bottomRight = convert(CGPoint(x: bounds.width, y: bounds.height), toCoordinateFrom: self)
            //let bottomLeft = convert(CGPoint(x: 0, y: bounds.height), toCoordinateFrom: self)
            
            let distHorizontal = CLLocation(latitude: topRight.latitude, longitude: topRight.longitude).distance(from: CLLocation(latitude: topLeft.latitude, longitude: topLeft.longitude))
            
            let distVertical = CLLocation(latitude: topRight.latitude, longitude: topRight.longitude).distance(from: CLLocation(latitude: bottomRight.latitude, longitude: bottomRight.longitude))
            
            return Viewport(lat: Float(centerCoordinate.latitude), lng: Float(centerCoordinate.longitude), radius: max(distVertical, distHorizontal))
        }
    }
}

