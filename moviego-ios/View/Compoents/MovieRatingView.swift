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
            imdbLabel.attributedText = formatRatingString(Asset.icImdbBadge, text: "\(imdbScore)")
        }
    }
    
    var tomatoScore: Int = 0 {
        didSet {
            tomatoLabel.attributedText = formatRatingString(Asset.icTomatoesBadge, text: "\(tomatoScore)%")
        }
    }
    
    override func createView() {
        ui.stack { it in
            it.axis = .horizontal
            
            it.ui.customView(RatingView()) { it in
                imdbLabel = it.title
                it.subtitle.text = "ImDb"
            }
            
            it.ui.customView(RatingView()) { it in
                tomatoLabel = it.title
                it.subtitle.text = "Tomatometer"
            }
        }
    }
    
    private func formatRatingString(_ imageAsset: ImageAsset, text: String) -> NSAttributedString {
        let attrString = NSMutableAttributedString()
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = imageAsset.image
        
        attrString.append(NSAttributedString(attachment: imageAttachment))
        attrString.append(NSAttributedString(string: text))
        return attrString
    }
    
    private class RatingView: BaseView {
        
        weak var title: UILabel!
        weak var subtitle: UILabel!
        
        override func createView() {
            ui.stack { it in
                it.axis = .vertical
                
                title = it.ui.label { it in
                    //
                }
                
                subtitle = it.ui.label { it in
                    //
                }
            }
        }
    }
}

extension DslMaker {
    
    @discardableResult
    func movieRatingView(block: (MovieRatingView) -> ()) -> MovieRatingView {
        return customView(MovieRatingView(), block)
    }
}
