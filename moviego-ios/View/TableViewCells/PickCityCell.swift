//
//  PickCityCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary

class PickCityCell: BaseTableViewCell<PickCityCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "cityPickerCell"
    }
    
    var option: (City, Bool)? {
        didSet {
            guard let (city, selected) = option else { return }
            
            layout.backgroundColor = selected ? UIColor(named: .primaryBlue).withAlphaComponent(0.6) : UIColor.gray
            // TODO: provide cloud config
            layout.cityPreviewImage.cldSetImage(publicId: city.pictureId, cloudinary: CLDCloudinary(configuration: CLDConfiguration(cloudName: "test")))
            layout.cityTitleLabel.text = city.name
            layout.cinemaCountLabel.text = "Cinemas: \(city.cinemaCount)"
        }
    }
}

class PickCityCellView: BaseView {
    
    weak var cityPreviewImage: UIImageView!
    weak var cityTitleLabel: UILabel!
    weak var cinemaCountLabel: UILabel!
    
    override func createView() {
        super.createView()
        
        view { it in
            it.layer.cornerRadius = 13
            it.backgroundColor = UIColor(named: .primaryBlue).withAlphaComponent(0.5)
            
            cityPreviewImage = it.imageView { it in
                it.layer.cornerRadius = 13
                
                it.snp.makeConstraints { make in
                    make.top.leading.trailing.equalToSuperview().inset(12)
                    make.width.equalToSuperview().inset(12)
                    make.height.equalTo(it.snp.width).multipliedBy(0.4)
                }
            }
            
            it.stack { it in
                it.axis = .horizontal
                it.spacing = 10
                it.distribution = .fillEqually
                
                
                cityTitleLabel = it.label { it in
                    // TODO: styles
                }
                
                cinemaCountLabel = it.label { it in
                    // TODO: styles
                }
            }
        }
    }
}

