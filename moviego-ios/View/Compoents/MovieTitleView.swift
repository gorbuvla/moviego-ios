//
//  MovieTitleView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class MovieTitleView: BaseView {
    
    private weak var titleLabel: UILabel!
    private weak var yearLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var year: String? {
        didSet {
            yearLabel.text = year
        }
    }
    
    override func createView() {
        ui.stack { it in
            it.axis = .vertical
            it.spacing = 5
            
            titleLabel = it.ui.label { it in
                it.styleParagraphNormall()
            }
            
            yearLabel = it.ui.label { it in
                it.styleParagraphSmall()
            }
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
