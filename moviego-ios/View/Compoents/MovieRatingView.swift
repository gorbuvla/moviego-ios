//
//  MovieRatingView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class MovieRatingView: BaseView {
    
    private weak var imdbLabel: UILabel!
    private weak var tomatoLabel: UILabel!
    
    var imdbScore: Float = 0.0 {
        didSet {
            imdbLabel.text =  "\(imdbScore)"
        }
    }
    
    var tomatoScore: String? = nil {
        didSet {
            tomatoLabel.text = tomatoScore
        }
    }
    
    override func createView() {
        ui.stack { it in
            it.axis = .horizontal
            it.spacing = 0
            it.distribution = .fillEqually
            
            
            it.ui.customView(RatingView()) { it in
                imdbLabel = it.title
                it.subtitle.text = L10n.Dashboard.Movie.imdbBadge
                it.iconImage.image = Asset.icImdbBadge.image
            }
            
            it.ui.customView(RatingView()) { it in
                tomatoLabel = it.title
                it.subtitle.text = L10n.Dashboard.Movie.tomatoesBadge
                it.iconImage.image = Asset.icTomatoesBadge.image
            }

            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private class RatingView: BaseView {
        
        weak var iconImage: UIImageView!
        weak var title: UILabel!
        weak var subtitle: UILabel!
        
        override func createView() {
            ui.stack { it in
                it.axis = .vertical
                it.spacing = 0
                it.distribution = .fillEqually
                
                it.ui.view { it in
                    iconImage = it.ui.imageView { it in
                        it.snp.makeConstraints { make in
                            make.leading.top.bottom.equalToSuperview()
                            make.width.height.equalTo(20)
                        }
                    }
                    
                    title = it.ui.label { it in
                        it.textStyleDark(opacity: 0.7)
                        it.styleParagraphNormall()
                        
                        it.snp.makeConstraints { make in
                            make.leading.equalTo(iconImage.snp.trailing).offset(2)
                            make.top.bottom.trailing.equalToSuperview()
                        }
                    }
                    
                    it.snp.makeConstraints { make in
                        make.height.equalTo(24)
                    }
                }
                
                subtitle = it.ui.label { it in
                    it.styleHeading3()
                    it.textStyleDark(opacity: 0.5)
                }
                
                it.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        }
    }
}

extension ViewDslMaker {
    
    @discardableResult
    func movieRatingView(block: (MovieRatingView) -> ()) -> MovieRatingView {
        return customView(MovieRatingView(), block)
    }
}
