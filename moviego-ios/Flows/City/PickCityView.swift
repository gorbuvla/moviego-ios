//
//  PickCityView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class PickCityView: BaseListView {
    
    weak var continueButton: UIButton!
    
    override func createView() {
        super.createView()
        backgroundColor = UIColor(named: .primary).withAlphaComponent(0.8)
        
        continueButton = button { it in
            it.setTitle("Register", for: .normal)
            it.primaryButton()
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(12)
                make.bottom.equalTo(safeArea.snp.bottom).inset(50)
            }
        }
        
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(safeArea.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top)
        }
    }
}
