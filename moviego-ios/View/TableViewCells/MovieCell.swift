//
//  MovieCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class MovieCell: BaseTableViewCell<MovieCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "movieCell"
    }
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            
            layout.posterImage.af_setImage(withURL: movie.poster)
            
        }
    }
    
}

class MovieCellView: BaseView {
    
    weak var posterImage: UIImageView!
    
    
    override func createView() {
        // container
        ui.view { it in
            
            it.layer.borderColor = UIColor.red.cgColor
            it.layer.borderWidth = 2
            
            // poster image
            posterImage = it.ui.imageView { it in
                
                it.snp.makeConstraints { make in
                    make.top.leading.bottom.equalToSuperview()
                    make.height.equalTo(70) // replace with superview once content available
                    make.width.equalTo(it.snp.height).multipliedBy(0.75)
                }
            }
            
            // divider
            it.ui.view { it in
                it.backgroundColor = .black

                it.snp.makeConstraints { make in
                    make.height.equalTo(1)
                    make.leading.equalTo(posterImage.snp.trailing).offset(10)
                    make.trailing.equalToSuperview().inset(10)
                    make.centerY.equalTo(posterImage)
                }
            }
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(20)
            }
        }
    }
}
