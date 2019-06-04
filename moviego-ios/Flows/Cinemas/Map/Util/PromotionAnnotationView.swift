//
//  CinemaAnnotationView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 21/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import MapKit

class PromotionCalloutView: BaseView {
    
    private weak var cinemaThumbnail: UIImageView!
    private weak var cinemaLabel: UILabel!
    private weak var detailButton: UIButton!
    
    var promotion: Promotion? {
        didSet {
            guard let promotion = promotion else { return }
            
            print("promotion did set")
            
            cinemaThumbnail.image = Asset.imgCinemaThumbnailPlaceholder.image
            cinemaLabel.text = "Promotion"
        }
    }
    
    override func createView() {
        backgroundColor = .white
        
        cinemaThumbnail = ui.imageView { it in
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(12)
                make.width.equalTo(200)
                make.height.equalTo(100).multipliedBy(0.5)
            }
        }
        
        cinemaLabel = ui.label { it in
            
            it.snp.makeConstraints { make in
                make.top.equalTo(cinemaThumbnail.snp.bottom).offset(10)
                make.width.equalToSuperview().inset(20)
            }
        }
        
        detailButton = ui.button { it in
            it.setTitle("Detail", for: .normal)
            it.primaryButton()
            
            it.snp.makeConstraints { make in
                make.top.equalTo(cinemaLabel.snp.bottom)
                make.width.equalToSuperview()
                make.height.equalTo(40)
                make.bottom.equalToSuperview()
            }
        }
    }
}

class PromotionAnnotationView: MKAnnotationView {
    
    private static let ANIM_DURATION = 0.5
    
    enum ReuseIdentifiers {
        static let defaultId = "cinemaAnnotationView"
    }
    
    private weak var calloutView: PromotionCalloutView?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        self.image = Asset.icMapPinInactive.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
        self.image = Asset.icMapPinInactive.image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? showCallout(animated) : hideCallout(animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.calloutView?.removeFromSuperview()
    }
    
    
    private func showCallout(_ animated: Bool) {
        calloutView?.removeFromSuperview()
        
        let callout = PromotionCalloutView(frame: CGRect(x: 0, y: 0, width: 240, height: 320))
        callout.promotion = (annotation as? PromotionAnnotation)?.promotion
        
        callout.frame.origin.x -= callout.frame.width / 2.0 - (frame.width / 2.0)
        callout.frame.origin.y -= callout.frame.height
        
        addSubview(callout)
        
        calloutView = callout
        
        if animated {
            calloutView?.alpha = 0.0
            UIView.animate(withDuration: PromotionAnnotationView.ANIM_DURATION, animations: { [weak self] in
                self?.calloutView?.alpha = 1.0
            })
        }
    }
    
    private func hideCallout(_ animated: Bool) {
        UIView.animate(withDuration: animated ? PromotionAnnotationView.ANIM_DURATION : 0.0, animations: { [weak self] in
            self?.calloutView?.alpha = 0.0
        }, completion: { [weak self] _ in
            self?.calloutView?.removeFromSuperview()
        })
    }
}
