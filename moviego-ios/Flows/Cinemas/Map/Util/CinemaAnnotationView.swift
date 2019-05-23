//
//  CinemaAnnotationView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 21/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import MapKit

class CinemaCalloutView: BaseView {
    
    private weak var cinemaThumbnail: UIImageView!
    private weak var cinemaLabel: UILabel!
    private weak var detailButton: UIButton!
    
    var cinema: Cinema? {
        didSet {
            guard let cinema = cinema else { return }
            
            cinemaThumbnail.image = Asset.imgCinemaThumbnailPlaceholder.image
            cinemaLabel.text = cinema.name
        }
    }
    
    override func createView() {
        backgroundColor = .white
        
        cinemaThumbnail = ui.imageView { it in
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(12)
                make.width.equalToSuperview()
                make.height.equalTo(it.snp.width).multipliedBy(0.5)
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

class CinemaAnnotationView: MKAnnotationView {
    
    private static let ANIM_DURATION = 0.5
    
    enum ReuseIdentifiers {
        static let defaultId = "cinemaAnnotationView"
    }
    
    private weak var calloutView: CinemaCalloutView?
    
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
        
        let callout = CinemaCalloutView()
        callout.cinema = (annotation as? CinemaAnnotation)?.cinema
        
        callout.frame.origin.x -= callout.frame.width / 2.0 - (frame.width / 2.0)
        callout.frame.origin.y -= callout.frame.height
        
        addSubview(callout)
        calloutView = callout
        
        if animated {
            calloutView?.alpha = 0.0
            UIView.animate(withDuration: CinemaAnnotationView.ANIM_DURATION, animations: { [weak self] in
                self?.calloutView?.alpha = 1.0
            })
        }
    }
    
    private func hideCallout(_ animated: Bool) {
        UIView.animate(withDuration: animated ? CinemaAnnotationView.ANIM_DURATION : 0.0, animations: { [weak self] in
            self?.calloutView?.alpha = 0.0
        }, completion: { [weak self] _ in
            self?.calloutView?.removeFromSuperview()
        })
    }
}
