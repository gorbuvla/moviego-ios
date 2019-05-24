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
            
            layout.titleLabel.text = movie.title
            layout.yearLabel.text = movie.year
            layout.posterImage.af_setImage(withURL: movie.poster)
            layout.ratingView.imdbScore = movie.imdbRating
            layout.ratingView.tomatoScore = 96
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.bkgLight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MovieCellView: BaseView {
    
    private weak var container: UIView!
    weak var posterImage: UIImageView!
    weak var titleLabel: UILabel!
    weak var yearLabel: UILabel!
    weak var ratingView: MovieRatingView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.applyShadow()
    }
    
    override func createView() {
        // container
        backgroundColor = UIColor.bkgLight
        container = ui.view { it in
            it.backgroundColor = .primary
            it.layer.cornerRadius = 4
            it.applyShadow()
            
            // poster image
            posterImage = it.ui.imageView { it in
                it.layer.cornerRadius = 4
                it.clipsToBounds = true
                
                it.snp.makeConstraints { make in
                    make.top.leading.bottom.equalToSuperview().inset(10)
                    make.height.equalTo(100) // replace with superview once content available
                    make.width.equalTo(it.snp.height).multipliedBy(0.75)
                }
            }
            
            // divider
            let divider = it.ui.view { it in
                it.backgroundColor = .separator

                it.snp.makeConstraints { make in
                    make.height.equalTo(1)
                    make.leading.equalTo(posterImage.snp.trailing).offset(10)
                    make.trailing.equalToSuperview().inset(10)
                    make.centerY.equalTo(posterImage)
                }
            }
            
            // top section
            it.ui.stack { it in
                it.axis = .vertical
                
                it.spacing = 5
                
                titleLabel = it.ui.label { it in
                    it.textColor = .title
                    it.fontSize = 15
                }
                
                yearLabel = it.ui.label { it in
                    it.textColor = .subtitle
                    it.fontSize = 12
                }
                
                it.snp.makeConstraints { make in
                    make.top.trailing.equalToSuperview().inset(10)
                    make.leading.equalTo(posterImage.snp.trailing).offset(10)
                    make.bottom.equalTo(divider.snp.top).offset(-15)
                }
            }
            
            ratingView = it.ui.movieRatingView { it in
                
                it.snp.makeConstraints { make in
                    make.bottom.trailing.equalToSuperview().inset(6)
                    make.leading.equalTo(posterImage.snp.trailing).offset(10)
                    make.top.equalTo(divider.snp.top).inset(6)
                }
            }
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
        }
    }
}
