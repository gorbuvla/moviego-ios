//
//  PromotionAnnotationView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import MapKit
import Cloudinary

//
// MKAnnotationView for promotions, sets custom pin image and a pulsing effect.
//
class PromotionAnnotationView: MKAnnotationView {
    
    var promotion: Promotion? {
        didSet {
            guard let promotion = promotion else { return }
            
            image = Asset.icPromotion.image
            let url = CLDCloudinary.shared.createUrl().generate(promotion.iconId)
            CLDCloudinary.shared.createDownloader().fetchImage(url!, nil, completionHandler: { image, error in
                let scaledImage = image?.scale(to: CGSize(width: 24, height: 24))
                DispatchQueue.main.async {
                    self.image = scaledImage ?? Asset.icPromotion.image
                }
            })
            
            // TODO: add pulse
            
//            let circulatPath = UIBezierPath(arcCenter: .zero, radius: 20, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//
//            let pulseLayer = CAShapeLayer()
//            pulseLayer.path = circulatPath.cgPath
//            pulseLayer.strokeColor = UIColor.clear.cgColor
//            pulseLayer.fillColor = UIColor.secondary.cgColor
//            pulseLayer.lineCap = CAShapeLayerLineCap.round
//            pulseLayer.position = center
//            layer.addSublayer(pulseLayer)
//
//            let animation = CABasicAnimation(keyPath: "transform.scale")
//            animation.toValue = 1.3
//            animation.fromValue = 0.8
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//            animation.autoreverses = true
//            animation.repeatCount = Float.infinity
//
//            pulseLayer.add(animation, forKey: "pulse")
        }
    }
}
