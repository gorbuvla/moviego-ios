//
//  TopSessionCollectionViewCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import AlamofireImage

class SuggestedSessionCell: BaseCollectionViewCell<SuggestedSessionView> {
    
    var session: Session? {
        didSet {
            guard let session = session else { return }
            
            layout.titleLabel.text = L10n.Session.titleWithYear(session.movie.title, session.movie.year)
            layout.subtitleLabel.text = L10n.Session.subtitleFormat(session.cinema.name, "600m") // TODO: compute actual distance
            layout.posterThumbnail.af_setImage(withURL: session.movie.poster)
        }
    }
}

class SuggestedSessionView: BaseView {
    
    private weak var container: UIView!
    weak var posterThumbnail: UIImageView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.applyShadow()
    }
    
    override func createView() {
        container = ui.view { it in
            it.layer.cornerRadius = 4
            
            posterThumbnail = it.ui.imageView { it in
                
                it.snp.makeConstraints { make in
                    make.height.equalTo(120)
                    make.width.equalTo(it.snp.height).multipliedBy(0.75)
                    make.top.leading.trailing.equalToSuperview().inset(8)
                }
            }
            
            titleLabel = it.ui.label { it in
                it.numberOfLines = 0
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(8)
                    make.top.equalTo(posterThumbnail.snp.bottom).offset(10)
                }
            }
            
            subtitleLabel = it.ui.label { it in
                it.numberOfLines = 0
                it.snp.makeConstraints { make in
                    make.leading.trailing.bottom.equalToSuperview().inset(8)
                    make.top.equalTo(titleLabel.snp.bottom).inset(5)
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(5)
            }
        }
    }
}
