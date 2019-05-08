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
import RxCoreLocation

protocol CinemaMapNavigationDelegate {
    func didTapShowDetail(of cinema: Cinema)
    func didTapNavigateCinema(cinema: Cinema)
}

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
        modalClosable()
        layout.mapView.delegate = self
        
        viewModel.locationManager.rx.location
            .take(1)
            .mapRegion(width: 300, height: 300)
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] region in
                layout?.mapView.setRegion(region, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.viewState.data
            .map { cinemas in cinemas.map { CinemaMapAnnotation(cinema: $0) } }
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] annotations in
                guard let mapView = layout?.mapView else { return }
                
                let present = mapView.annotations.compactMap { $0 as? CinemaMapAnnotation }
                mapView.addAnnotations(annotations.filter { !present.contains($0) })
            })
            .disposed(by: disposeBag)
        
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        viewModel.viewportDidChange(mapView.currentViewport)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CinemaMapAnnotation else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cinema_pin")
            ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "cinema_pin")
        
        annotationView.image = Asset.icMapPin.image
        annotationView.canShowCallout = true
        annotationView.clusteringIdentifier = "cluster_id"
        return annotationView
    }
}

struct Viewport {
    let lat: Float
    let lng: Float
    let radius: Double
}

extension ObservableType where Element == CLLocation? {
    
    func mapRegion(width: CLLocationDistance, height: CLLocationDistance) -> Observable<MKCoordinateRegion> {
        return compactMap { location in
            guard let location = location else { return nil }
            
            return MKCoordinateRegion(center: location.coordinate, latitudinalMeters: width, longitudinalMeters: height)
        }
    }
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

