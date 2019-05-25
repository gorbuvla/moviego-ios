//
//  BaseScrollView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class BaseScrollView: BaseView {
    
    weak var scrollView: UIScrollView!
    weak var scrollContent: UIView!
    
    override func createView() {
        super.createView()
        scrollView = ui.scrollView { it in
            
            scrollContent = it.ui.view { it in
                createScrollContent(contentView: it)
                
                it.snp.makeConstraints { make in
                    make.top.bottom.leading.trailing.equalToSuperview()
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func createScrollContent(contentView: UIView) {}
}

class BaseFormView: BaseScrollView {
    
    weak var footerView: UIView!
    weak var continueButton: UIButton!
    
    var nextButtonTitle: String {
        return "Next"
    }
    
    override func createView() {
        super.createView()
        footerView = ui.view { it in
            it.backgroundColor = .red
            it.setContentHuggingPriority(.required, for: .vertical)

            continueButton = it.ui.button { it in
                it.secondaryButton()
                it.setTitle(nextButtonTitle, for: .normal)

                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(20)
                    make.bottom.equalToSuperview().inset(30)
                    make.height.equalTo(40)
                }
            }

            it.snp.makeConstraints { make in
                make.top.equalTo(scrollView.snp.bottom)
                make.leading.trailing.bottom.equalTo(safeArea)
                make.height.equalTo(0).priority(250)
                make.height.greaterThanOrEqualTo(0)
            }
        }
    }
}
