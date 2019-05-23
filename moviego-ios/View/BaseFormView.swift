//
//  BaseFormView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class BaseFormView: BaseView {
    
    weak var scrollContent: UIView!
    weak var continueButton: UIButton!
    
    override func createView() {
        backgroundColor = UIColor(named: .primary).withAlphaComponent(0.8)
        
        continueButton = ui.button { it in
            it.primaryButton()
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                make.bottom.equalTo(safeArea).inset(50)
            }
        }
        
        ui.scrollView { it in
            
            scrollContent = it.ui.view { it in
                
                it.snp.makeConstraints { make in
                    make.top.equalToSuperview().inset(20)
                    make.leading.trailing.equalToSuperview().inset(12)
                    make.width.equalToSuperview().inset(12)
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalTo(safeArea)
                make.bottom.equalTo(continueButton.snp.top).inset(-20)
                
            }
        }
    }
}
