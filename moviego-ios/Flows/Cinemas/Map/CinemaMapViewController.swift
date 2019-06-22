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

protocol CinemaMapNavigationDelegate: class {
    func didTapShowDetail(of cinema: Cinema)
    func didTapShowDetail(of promotion: Promotion)
}

class CinemaMapViewController: BaseViewController<CinemaMapView> {
    
    private weak var activityIndicator: UIActivityIndicatorView!
    private let viewModel: CinemaMapViewModel
    
    var navigationDelegate: CinemaMapNavigationDelegate?
    
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
        
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator = activityIndicator
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: activityIndicator)]
        
        modalClosable()
        
        layout.mapView.delegate = self
        layout.mapView.showsUserLocation = true
        layout.bottomCard.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.isEnabled = true
        layout.mapView.addGestureRecognizer(tapGestureRecognizer)
        
        viewModel.cinemasState.loading
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak activityIndicator] loading in
                loading ? activityIndicator?.startAnimating() : activityIndicator?.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.cinemasState.data
            .map { cinemas in cinemas.map { CinemaAnnotation(cinema: $0) } }
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] annotations in
                guard let mapView = layout?.mapView else { return }
                
                let present = mapView.annotations.compactMap { $0 as? CinemaAnnotation }
                mapView.addAnnotations(annotations.filter { !present.contains($0) })
                mapView.zoomAnnotations()
            })
            .disposed(by: disposeBag)
        
        viewModel.promotions
            .map { promotions in promotions.map { PromotionAnnotation(promotion: $0) }}
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] annotations in
                guard let mapView = layout?.mapView else { return }
                
                let remove = mapView.annotations.filter { $0 is PromotionAnnotation }
                mapView.removeAnnotations(remove)
                mapView.addAnnotations(annotations)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func showBottomSheet() {
        if let _ = viewModel.selectedAnnotation as? CinemaAnnotation {
            UIView.transition(with: self.layout.bottomCard, duration: 0.5, options: .transitionFlipFromTop, animations: {})
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.layout.bottomSheetConstraint.update(inset: 20)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    private func hideBottomSheet() {
        if let annotation = viewModel.selectedAnnotation as? CinemaAnnotation {
            layout.mapView.view(for: annotation)?.image = Asset.icMapPinInactive.image
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layout.bottomSheetConstraint.update(inset: -2000)
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func handleMapTap(sender: UIGestureRecognizer) {
        let tapLocation = sender.location(in: layout)
        if let subview = layout.hitTest(tapLocation, with: nil) {
            if subview.isKind(of: NSClassFromString("MKAnnotationContainerView")!) {
                hideBottomSheet()
                viewModel.selectedAnnotation = nil
            }
        }
    }
}

//
// MARK: - MKMapViewDelegate
//
extension CinemaMapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        viewModel.viewportDidChange(mapView.currentViewport)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Different animations are applied when closing/switching item in card, so distinguish between
        // a promotion and cinema clicks.
        if let promoAnnotation = view.annotation as? PromotionAnnotation {
            if let annotation = viewModel.selectedAnnotation as? CinemaAnnotation {
                mapView.view(for: annotation)?.image = Asset.icMapPinInactive.image
                hideBottomSheet()
            }
            
            viewModel.selectedAnnotation = promoAnnotation
        }
        
        if let cinemaAnnotation = view.annotation as? CinemaAnnotation {
            mapView.setCenter(cinemaAnnotation.coordinate, animated: true)
            
            if let annotation = viewModel.selectedAnnotation as? CinemaAnnotation {
                mapView.view(for: annotation)?.image = Asset.icMapPinInactive.image
            }
            
            view.image = Asset.icMapPinActive.image
            layout.bottomCard.cinema = cinemaAnnotation.cinema
            showBottomSheet()
            viewModel.selectedAnnotation = cinemaAnnotation
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CinemaAnnotation {
            let reuseId = CinemaAnnotation.ReuseIdentifiers.defaultId
            
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view.image = viewModel.selectedAnnotation?.isEqual(annotation) == true ? Asset.icMapPinActive.image : Asset.icMapPinInactive.image
            view.canShowCallout = false
            return view
        }
        
        if let annotation = annotation as? PromotionAnnotation {
            let reuseId = PromotionAnnotation.ReuseIdentifiers.defaultId
            
            let view: PromotionAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? PromotionAnnotationView ?? PromotionAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view.promotion = annotation.promotion
            let callout = PromotionCalloutView()
            callout.promotion = annotation.promotion
            callout.delegate = self
            
            view.detailCalloutAccessoryView = callout
            view.image = Asset.icPromotion.image
            view.canShowCallout = true
            
            return view
        }
        return nil
    }
}

//
// MARK: - PromoCalloutDelegate
//
extension CinemaMapViewController: PromoCalloutDelegate {
    func showDetail() {
        if let annotation = viewModel.selectedAnnotation as? PromotionAnnotation {
            navigationDelegate?.didTapShowDetail(of: annotation.promotion)
        }
    }
}

//
// MARK: - CinemaBottomSheetDelegate
//
extension CinemaMapViewController: CinemaBottomSheetDelegate {
    func didTapDetail() {
        if let annotation = viewModel.selectedAnnotation as? CinemaAnnotation {
            navigationDelegate?.didTapShowDetail(of: annotation.cinema)
        }
    }
}

//
// Support structs
//
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
