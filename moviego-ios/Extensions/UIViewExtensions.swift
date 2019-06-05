//
//  UIViewExtensions.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import MapKit

extension UIView {
    
    var isVisible: Bool {
        get { return !isHidden }
        set(value) { isHidden = !value }
    }
    
    func applyShadow() {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.cgPath
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
    
    func zoomAnnotations(zoomUser: Bool = false) {
        let zoomRect = annotations
            .filter { !($0 is MKUserLocation) || zoomUser }
            .map { MKMapPoint($0.coordinate) }
            .map { MKMapRect(x: $0.x, y: $0.y, width: 0.01, height: 0.01) }
            .reduce(MKMapRect.null, { acc, rect in acc.union(rect) })
        
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
    }
}
