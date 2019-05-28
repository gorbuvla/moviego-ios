//
//  CinemaBottomSheetView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Cloudinary

class CinemaBottomSheetView: BaseView {
    
    private weak var header: CinemaCardHeader!
    
    var cinema: Cinema? {
        didSet {
            guard let cinema = cinema else { return }
            
            // header setup
            header.titleLabel.text = cinema.name
            header.addressLabel.text = cinema.address
            header.thumbnailImage.cldSetImage(cinema.thumnailId ?? "", cloudinary: CLDCloudinary.shared, placeholder: Asset.imgCinemaThumbnailPlaceholder.image)
            
            // footer setup
            // TODO: top movies x button
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyShadow()
    }
    
    override func createView() {
        backgroundColor = .white
        layer.cornerRadius = 4
        
        ui.stack { it in
            
            it.ui.customView(CinemaCardHeader()) { it in
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                }
            }
            
            it.ui.view { it in
                it.backgroundColor = .black // TODO: debug
                
                it.snp.makeConstraints { make in
                    make.height.equalTo(1)
                    make.width.equalToSuperview().inset(30)
                }
            }
            
            
            // TODO: future footer
            it.ui.view { it in
                it.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(80)
                }
            }
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            }
        }
    }
    
    private class CinemaCardHeader: BaseView {
        
        weak var thumbnailImage: UIImageView!
        weak var titleLabel: UILabel!
        weak var addressLabel: UILabel!
        
        override func createView() {
            thumbnailImage = ui.imageView { it in
                it.layer.cornerRadius = 4
                it.clipsToBounds = true
                
                it.snp.makeConstraints { make in
                    make.width.equalTo(120)
                    make.height.equalTo(it.snp.width).multipliedBy(0.5)
                    make.top.leading.trailing.equalToSuperview()
                }
            }
            
            titleLabel = ui.label { it in
                it.styleHeading2()
                it.textStyleDark()
                
                it.snp.makeConstraints { make in
                    make.leading.equalTo(thumbnailImage.snp.trailing).inset(10)
                    make.top.trailing.equalToSuperview()
                }
            }
            
            addressLabel = ui.label { it in
                it.styleHeading4()
                it.textStyleDark(opacity: 0.4)
                
                it.snp.makeConstraints { make in
                    make.leading.equalTo(thumbnailImage.snp.trailing).inset(10)
                    make.top.equalTo(titleLabel.snp.bottom).inset(5)
                    make.bottom.trailing.equalToSuperview()
                }
            }
        }
    }
}
