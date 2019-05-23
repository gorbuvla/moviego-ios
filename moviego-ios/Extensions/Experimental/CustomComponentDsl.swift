//
//  CustomComponentDsl.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

extension DslMaker {
    
    @discardableResult
    func framedField(style: FramedTextField.Style, _ block: (FramedTextField) -> Void) -> FramedTextField {
        return customView(FramedTextField(style: style), block)
    }
}
