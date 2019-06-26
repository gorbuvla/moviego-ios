//
//  TodayMovieCollectionViewCell.swift
//  TodaySessionsExtension
//
//  Created by Vlad Gorbunov on 26/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import AlamofireImage

final class TodayMovieCollectionViewCell: UICollectionViewCell {
    
    enum ReuseIdentifiers {
        static let defaultId = "todayMovieCell"
    }
    
    weak var poster: UIImageView!
    
    var movie: DBMovie? {
        didSet {
            guard let movie = movie, let posterUrl = URL(string: movie.posterId ?? "") else { return }
            
            poster.af_setImage(withURL: posterUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        let poster = UIImageView()
        poster.layer.cornerRadius = 4
        poster.layer.borderWidth = 2
        poster.layer.borderColor = UIColor.white.cgColor
        poster.clipsToBounds = true
        poster.contentMode = .scaleAspectFill
        contentView.addSubview(poster)
        poster.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.poster = poster
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
