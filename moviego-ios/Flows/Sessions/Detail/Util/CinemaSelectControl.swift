//
//  CitySelectControl.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary

class CinemaSelectControl: SelectControl<Cinema> {
    
    private weak var cinemaImage: UIImageView!
    private weak var cinemaLabel: UILabel!
    
    override var emptyText: String {
        get { return "Choose cinema" }
    }
    
    override func itemSelected(item: Cinema?) {
        super.itemSelected(item: item)
        
        guard let cinema = item else { return }
        
        cinemaLabel.text = cinema.name
        cinemaImage.cldSetImage(publicId: cinema.thumnailId ?? "", cloudinary: CLDCloudinary.shared, placeholder: Asset.imgCinemaThumbnailPlaceholder.image)
    }
    
    override func createContent() -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fill
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        stack.addArrangedSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(image.snp.height)
        }
        cinemaImage = image
        
        let label = UILabel()
        label.textStyleDark(opacity: 0.8)
        label.styleHeading3()
        label.numberOfLines = 0
        stack.addArrangedSubview(label)
        cinemaLabel = label
        
        return stack
    }
}
