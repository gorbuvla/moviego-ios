//
//  CinemaMapView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import SnapKit

class CinemaMapView: BaseMapView {
    
    weak var bottomCard: CinemaBottomSheetView!
    weak var bottomSheetConstraint: Constraint!
    
    override func createView() {
        super.createView()
        bottomCard = ui.customView(CinemaBottomSheetView()) { it in
            it.snp.makeConstraints { make in
                make.leading.trailing.equalTo(safeArea).inset(16)
                bottomSheetConstraint = make.bottom.equalTo(safeArea).inset(-2000).constraint
            }
        }
    }
}
