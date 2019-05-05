//
//  ShowtimeCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class ShowtimeCell: BaseTableViewCell<ShowtimeCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "showtimeCell"
    }
    
    var showtime: Showtime? {
        didSet {
            guard let showtime = showtime else { return }
            
            
            layout.movieTitleText.text = showtime.movie.title
            
            
            
        }
    }
}

class ShowtimeCellView: BaseView {
    
    weak var posterImage: UIImageView!
    weak var movieTitleText: UILabel!
    
    override func createView() {
        super.createView()
        
        posterImage = imageView { it in
            it.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(12)
                make.bottom.lessThanOrEqualToSuperview().inset(12)
                make.width.equalTo(60)
                make.height.equalTo(it.snp.height).multipliedBy(4/3)
            }
        }
        
        movieTitleText = label { it in
            it.textStyleLight()
            it.styleHeading3()
            it.snp.makeConstraints { make in
                make.leading.equalTo(posterImage.snp.trailing).offset(12)
                make.top.trailing.equalToSuperview().inset(12)
            }
        }
        
        
    }
}
