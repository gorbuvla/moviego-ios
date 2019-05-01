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
        scrollView = scrollView { it in
            
            scrollContent = it.view { it in
                createScrollContent(contentView: it)
                
                it.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                    make.width.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalTo(safeArea)
                make.bottom.equalTo(0)
            }
        }
    }
    
    func createScrollContent(contentView: UIView) {}
}


//extension BaseViewController where V: BaseScrollView {
//    
//    func keyboardWillChangeFrame(_ notification: Notification) {
//        guard let rectEnd = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
//        
//        let screenHeight = UIScreen.main.bounds.size.height
//        var bottom = screenHeight - rectEnd.origin.y
//        
//        if let tabBar = tabBarController?.tabBar, rectEnd.origin.y != UIScreen.main.bounds.size.height, tabBar.isHidden == false {
//            bottom -= tabBar.frame.height
//        }
//        
//        layout.scrollView.snp.updateConstraints { make in
//            make.bottom.equalTo(-bottom)
//        }
//        
//        UIView.animate(withDuration: duration) { [weak self] in
//            self?.view.layoutIfNeeded()
//        }
//    }
//}
