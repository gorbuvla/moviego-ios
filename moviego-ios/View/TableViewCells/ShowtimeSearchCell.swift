//
//  ShowtimeCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 04/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import AlamofireImage

class ShowtimeSearchCell: BaseTableViewCell<ShowtimeCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "showtimeCell"
    }
    
    var searchItem: SessionSearchItem? {
        didSet {
            guard let movie = searchItem?.movie,
                  let cinema = searchItem?.cinema,
                  let showtimes = searchItem?.showtimes else { return }
            
            layout.movieTitleText.text = movie.title
            layout.ratingLabel.attributedText = ratingAttributedString(imdbScore: movie.imdbRating, tomatoesScore: movie.rottenTomatoesRating)
            layout.cinemaTitleText.text = cinema.name
            layout.posterImage.af_setImage(withURL: movie.poster)
            
            
        }
    }
    
    private func ratingAttributedString(imdbScore: Float, tomatoesScore: String) -> NSAttributedString {
        let attrString = NSMutableAttributedString()
        
        let imdbAttachment = NSTextAttachment()
        imdbAttachment.image = Asset.icImdbBadge.image
        
        let tomatoesAttachment = NSTextAttachment()
        tomatoesAttachment.image = Asset.icTomatoesBadge.image
        
        attrString.append(NSAttributedString(attachment: imdbAttachment))
        attrString.append(NSAttributedString(string: ": \(imdbScore), "))
        attrString.append(NSAttributedString(attachment: tomatoesAttachment))
        attrString.append(NSAttributedString(string: ": \(tomatoesScore)"))
        return attrString
    }
}

class ShowtimeCellView: BaseView {
    
    weak var posterImage: UIImageView!
    weak var movieTitleText: UILabel!
    weak var ratingLabel: UILabel!
    weak var cinemaTitleText: UILabel!
    
    override func createView() {
        super.createView()
        backgroundColor = .white
        
        posterImage = ui.imageView { it in
            it.layer.cornerRadius = 6.0
            it.clipsToBounds = true
            it.contentMode = .scaleAspectFill
            
            it.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(12)
                make.bottom.lessThanOrEqualToSuperview().inset(12)
                make.width.equalTo(60)
                make.height.equalTo(it.snp.width).multipliedBy(1.34)
            }
        }
        
        let chevronIndicator = ui.imageView(image: Asset.icChevron.image) { it in
            it.tintColor = UIColor(named: .primary)
            
            it.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(12)
                make.centerY.equalToSuperview()
            }
        }
        
        ui.stack { it in
            it.axis = .vertical
            it.spacing = 5
            
            movieTitleText = it.ui.label { it in
                it.textStyleDark()
                it.styleHeading2()
//                it.snp.makeConstraints { make in
//                    make.leading.equalTo(posterImage.snp.trailing).offset(12)
//                    make.top.trailing.equalToSuperview().inset(12)
//                }
            }
            
            ratingLabel = it.ui.label { it in
                it.textStyleDark()
                it.styleHeading3()
            }
            
            cinemaTitleText = it.ui.label { it in
                it.textStyleDark()
                it.styleHeading3()
            }
            
            it.snp.makeConstraints { make in
                make.leading.equalTo(posterImage.snp.trailing).offset(10)
                make.top.bottom.equalToSuperview().inset(12)
                make.trailing.lessThanOrEqualTo(chevronIndicator.snp.leading).offset(5)
            }
        }
    }
}
