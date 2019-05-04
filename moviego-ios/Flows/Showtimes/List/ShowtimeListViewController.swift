//
//  MovieListViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

protocol ShowtimeListNavigationDelegate: class {}

class ShowtimeListViewController: BaseViewController<BaseListView> {
    
    weak var navigationDelegate: ShowtimeListNavigationDelegate?
    private let viewModel: ShowtimeListViewModel
    
    init(viewModel: ShowtimeListViewModel) {
        self.viewModel = viewModel
        super.init()
        tabBarItem.title = "Movies"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.label { it in
            it.text = "Movies & Cinemas Flow"
            it.textColor = .black
            
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}
