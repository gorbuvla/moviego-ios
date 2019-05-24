//
//  BaseCollectionViewCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class BaseCollectionViewCell<V: UIView>: UICollectionViewCell {
    
    private(set) weak var layout: V!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = V.init()
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.layout = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
