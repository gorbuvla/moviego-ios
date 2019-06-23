//
//  ShowtimeDetailView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxCocoa

final class SessionFilterView: BaseView {
    
    weak var cinemaSelect: CinemaSelectControl!
    weak var dateSelect: DateSelectControl!
    
    override func createView() {
        backgroundColor = .bkgLight
        
        ui.stack { it in
            it.axis = .horizontal
            it.spacing = 10
            it.distribution = .fillEqually
            
            cinemaSelect = it.ui.customView(CinemaSelectControl())
            dateSelect = it.ui.customView(DateSelectControl())
            
            it.snp.makeConstraints { make in
                make.edges.equalTo(safeArea).inset(15)
            }
        }
    }
}


