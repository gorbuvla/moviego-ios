//
//  CinemaMapView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class CinemaMapView: BaseMapView {
    
    weak var bottomCard: UIView!
    
    override func createView() {
        super.createView()
        
        bottomCard = ui.view { it in
            it.snp.makeConstraints { make in
                make.leading.trailing.equalTo(safeArea).inset(16)
                make.bottom.equalTo(safeArea).inset(20)
            }
        }
    }
}
