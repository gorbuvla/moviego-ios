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
            
            layout.thumbnailImage.cldSetImage(publicId: city.pictureId, cloudinary: CLDCloudinary.shared)
            layout.titleLabel.text = city.name.uppercased()
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
                make.top.leading.trailing.equalToSuperview().inset(15)
                make.width.equalToSuperview().inset(15)
                make.height.equalTo(it.snp.width).multipliedBy(0.5)
            }
        }
        
        container.ui.stack { it in
            it.axis = .vertical
            it.spacing = 10
            it.distribution = .equalCentering
            
            titleLabel = it.ui.label { it in
                it.styleParagraphNormall()
            }
            
            it.ui.view { it in
                it.backgroundColor = .separator
                
                it.snp.makeConstraints { make in
                    make.height.equalTo(1)
                    make.width.equalToSuperview().multipliedBy(0.5)
                }
            }
            
            subtitleLabel = it.ui.label { it in
                it.styleParagraphSmall()
            }
            
            it.snp.makeConstraints { make in
                make.top.equalTo(thumbnailImage.snp.bottom).offset(8)
                make.leading.trailing.bottom.equalToSuperview().inset(15)
            }
        }
    }
}
