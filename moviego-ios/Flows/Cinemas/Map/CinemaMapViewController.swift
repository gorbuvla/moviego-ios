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

protocol CinemaMapNavigationDelegate: class {
    func didTapShowDetail(of cinema: Cinema)
}

class CinemaMapViewController: BaseViewController<CinemaMapView>, MKMapViewDelegate {
    
    private let viewModel: CinemaMapViewModel
    
    weak var navigationDelegate: CinemaMapNavigationDelegate?
    
    init(viewModel: CinemaMapViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Cinema.Map.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIActivityIndicatorView(style: .gray))
        modalClosable()
        
        layout.mapView.delegate = self
        layout.bottomCard.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.isEnabled = true
        layout.mapView.addGestureRecognizer(tapGestureRecognizer)
        
//        viewModel.locationManager.rx.location
//            .take(1)
//            .mapRegion(width: 1000, height: 1000)
//            .observeOn(MainScheduler.instance)
//            .bind(onNext: { [weak layout] region in
//                layout?.mapView.setRegion(region, animated: true)
//            })
//            .disposed(by: disposeBag)
        
        viewModel.viewState.data
            .map { cinemas in cinemas.map { CinemaAnnotation(cinema: $0) } }
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] annotations in
                guard let mapView = layout?.mapView else { return }
                
                let present = mapView.annotations.compactMap { $0 as? CinemaAnnotation }
                mapView.addAnnotations(annotations.filter { !present.contains($0) })
            })
            .disposed(by: disposeBag)
        
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        viewModel.viewportDidChange(mapView.currentViewport)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let cinemaAnnotation = view.annotation as? CinemaAnnotation {
            mapView.setCenter(cinemaAnnotation.coordinate, animated: true)
            
            // TODO: change to selected icon
            
            layout.bottomCard.cinema = cinemaAnnotation.cinema
            showBottomSheet()
            viewModel.selectedAnnotation = cinemaAnnotation
        }
    }
    
    func showBottomSheet() {
        if let _ = viewModel.selectedAnnotation {
            UIView.transition(with: self.layout.bottomCard, duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.layout.bottomCard.isHidden = false
            })
        } else {
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.layout.bottomCard.snp.remakeConstraints { make in
                    make.leading.trailing.equalTo(self.safeArea).inset(16)
                    make.bottom.equalTo(self.safeArea).inset(20)
                }
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.layout.bottomCard.isHidden = false
                })
            })
        }
    }
    
    func hideBottomSheet() {
        layout.bottomCard.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(safeArea).inset(16)
            make.top.equalTo(layout.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.layout.bottomCard.isHidden = true
            })
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CinemaAnnotation {
            let reuseId = CinemaAnnotationView.ReuseIdentifiers.defaultId
            
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view.image = Asset.icMapPinInactive.image
            view.canShowCallout = true
            return view
        }
        
        // TODO: handle annotations for prizes
        return nil
    }
    
    @objc private func handleMapTap(sender: UIGestureRecognizer) {
        let tapLocation = sender.location(in: layout)
        if let subview = layout.hitTest(tapLocation, with: nil) {
            if subview.isKind(of: NSClassFromString("MKAnnotationContainerView")!) {
                viewModel.selectedAnnotation = nil
                hideBottomSheet()
            }
        }
    }
}

extension CinemaMapViewController: CinemaBottomSheetDelegate {
    func didTapDetail() {
        if let annotation = viewModel.selectedAnnotation as? CinemaAnnotation {
            navigationDelegate?.didTapShowDetail(of: annotation.cinema)
        }
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

