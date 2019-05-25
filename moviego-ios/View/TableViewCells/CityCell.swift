//
//  PickCityCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary

class CityCell: BaseTableViewCell<CityCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "cityPickerCell"
    }
    
    var city: City? {
        didSet {
            guard let city = city else { return }
            
            layout.thumbnailImage.cldSetImage(publicId: city.pictureId, cloudinary: CLDCloudinary(configuration: CLDConfiguration(cloudName: "do04iflqy")))
            layout.titleLabel.text = city.name
            layout.subtitleLabel.text = "Cinemas: \(city.cinemasCount)"
        }
    }
}

class CityCellView: BaseShadowedView {
    
    weak var thumbnailImage: UIImageView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    
    override func createContentView(container: UIView) {
        backgroundColor = .bkgLight
        container.backgroundColor = .primary
        
        thumbnailImage = container.ui.imageView { it in
            it.layer.cornerRadius = 4
            it.clipsToBounds = true
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(10)
                make.width.equalToSuperview().inset(10)
                make.height.equalTo(it.snp.width).multipliedBy(0.5)
            }
        }
        
        container.ui.stack { it in
            it.axis = .horizontal
            it.spacing = 10
            it.distribution = .fillEqually
            
            titleLabel = it.ui.label { it in
                // TODO: styles
            }
            
            subtitleLabel = it.ui.label { it in
                // TODO: styles
            }
            
            it.snp.makeConstraints { make in
                make.top.equalTo(thumbnailImage.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
