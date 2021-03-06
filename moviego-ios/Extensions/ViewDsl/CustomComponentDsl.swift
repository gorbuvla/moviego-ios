//
//  CustomComponentDsl.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

extension ViewDslMaker {
    
    @discardableResult
    func framedField(style: FramedTextField.Style, _ block: (FramedTextField) -> Void) -> FramedTextField {
        return customView(FramedTextField(style: style), block)
    }
    
    @discardableResult
    func divider(color: UIColor = .separator, inset: Float = 12) -> UIView {
        return view { it in
            it.backgroundColor = color
            
            it.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.leading.trailing.equalToSuperview().inset(inset)
            }
        }
    }
}
