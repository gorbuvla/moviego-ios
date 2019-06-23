//
//  SessionCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

final class SessionCell: BaseTableViewCell<SessionCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "sessionCell"
    }
    
    var session: Session? {
        didSet {
            guard let session = session else { return }
            
            layout.timeLabel.text = session.startsAt.toString(with: "HH:mm")
            layout.typeLabel.text = session.type.rawValue
        }
    }
}

final class SessionCellView: BaseShadowedView {

    weak var timeLabel: UILabel!
    weak var typeLabel: UILabel!
    
    override func createContentView(container: UIView) {
        backgroundColor = .bkgLight
        container.backgroundColor = .white
        container.ui.stack { it in
            it.axis = .horizontal
            it.distribution = .fill
            
            timeLabel = it.ui.label { it in
                it.styleHeading3()
            }
            
            typeLabel = it.ui.label { it in
                it.styleHeading4()
            }
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(15)
            }
        }
    }
}
