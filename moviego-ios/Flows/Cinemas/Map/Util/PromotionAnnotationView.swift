//
//  CinemaAnnotationView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 21/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import MapKit
import Cloudinary
import RxSwift

protocol PromoCalloutDelegate: class {
    func showDetail(of promotion: Promotion)
}

class PromotionCalloutView: BaseView {
    
    private weak var movieLabel: UILabel!
    private weak var sceneThumbnail: UIImageView!
    private weak var sceneDescription: UILabel!
    private weak var detailButton: UIButton!
    
    weak var delegate: PromoCalloutDelegate?
    
    var promotion: Promotion? {
        didSet {
            guard let promotion = promotion else { return }
            
            movieLabel.text = promotion.movie.title
            sceneThumbnail.cldSetImage(publicId: promotion.thumbnailId, cloudinary: CLDCloudinary.shared)
            sceneDescription.text = promotion.description
        }
    }
    
    override func createView() {
        backgroundColor = .white
        
        movieLabel = ui.label { it in
            it.styleHeading1()
            it.textStyleDark()
            it.adjustsFontSizeToFitWidth = true
            
            it.snp.makeConstraints { make in
                make.leading.trailing.top.equalToSuperview()
            }
        }
        
        sceneThumbnail = ui.imageView { it in
            it.layer.cornerRadius = 4
            it.clipsToBounds = true
            
            it.snp.makeConstraints { make in
                make.top.equalTo(movieLabel.snp.bottom).offset(5)
                make.leading.trailing.equalToSuperview()
                make.width.equalTo(250)
                make.height.equalTo(it.snp.width).multipliedBy(0.5)
            }
        }
        
        sceneDescription = ui.label { it in
            it.numberOfLines = 0
            it.textAlignment = .center
            
            it.styleHeading4()
            it.textStyleDark(opacity: 0.5)
            
            it.snp.makeConstraints { make in
                make.top.equalTo(sceneThumbnail.snp.bottom).offset(5)
                make.width.equalToSuperview()
            }
        }
        
        detailButton = ui.button { it in
            it.setTitle("Detail", for: .normal)
            it.accentButton()
            
            let _ = it.rx.tap.bind(onNext: { [weak delegate] in
                delegate?.showDetail(of: self.promotion!)
            })
            
            it.snp.makeConstraints { make in
                make.top.equalTo(sceneDescription.snp.bottom).offset(5)
                make.width.equalToSuperview()
                make.height.equalTo(40)
                make.bottom.equalToSuperview()
            }
        }
    }
}
