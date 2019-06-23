//
//  FlexibleSessionHeader.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

protocol FlexibleSessionHeaderDelegate: class {
    func didTapPlayVideo()
    func didTapInviteFriends()
}

final class FlexibleSessionHeader: FlexibleHeaderView {
    
    weak var thumbnailImage: UIImageView!
    
    private weak var posterImage: UIImageView!
    private weak var titleView: MovieTitleView!
    private weak var ratingView: MovieRatingView!
    private weak var inviteButton: UIButton!
    
    var delegate: FlexibleSessionHeaderDelegate?
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            
            titleView.title = movie.title
            titleView.year = movie.year
            
            ratingView.imdbScore = movie.imdbRating
            ratingView.tomatoScore = movie.rottenTomatoesRating
            
            posterImage.af_setImage(withURL: movie.poster)
        }
    }
    
    override func getFlexibleView() -> UIView {
        // TODO: video player
        let imageView = GradientImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Asset.imgHeaderPlaceholder.image
        thumbnailImage = imageView
        return imageView
    }
    
    override func createCardContent(parent: UIView) {
        inviteButton = parent.ui.button { it in
            it.setTitle("Invite friends".capitalized, for: .normal)
            it.accentButton()
            
            it.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.bottom.leading.trailing.equalToSuperview()
            }
        }
        
        posterImage = parent.ui.imageView { it in
            it.layer.cornerRadius = 4
            it.clipsToBounds = true
            
            it.snp.makeConstraints { make in
                make.bottom.equalTo(inviteButton.snp.top).inset(-20)
                make.leading.equalToSuperview().inset(10)
                make.width.equalTo(130)
                make.height.equalTo(it.snp.width).multipliedBy(1.33)
            }
        }
        
        parent.ui.stack { it in
            it.axis = .vertical
            it.spacing = 10
            
            titleView = it.ui.customView(MovieTitleView()) { it in
                it.snp.makeConstraints { make in make.leading.trailing.equalToSuperview() }
            }
            
            it.ui.divider(inset: 0)
            
            ratingView = it.ui.customView(MovieRatingView()) { it in
                it.snp.makeConstraints { make in make.leading.trailing.equalToSuperview() }
            }
            
            it.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview().inset(20)
                make.leading.equalTo(posterImage.snp.trailing).inset(-20)
                make.bottom.equalTo(inviteButton.snp.top).inset(-20)
            }
        }
    }
}
