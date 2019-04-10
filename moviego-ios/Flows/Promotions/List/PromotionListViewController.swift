//
//  PromotionListViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class PromotionListViewController: BaseViewController<BaseListView> {
    
    private let viewModel: PromotionListViewModel
    
    init(viewModel: PromotionListViewModel) {
        self.viewModel = viewModel
        super.init()
        tabBarItem.title = "Promotions"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
