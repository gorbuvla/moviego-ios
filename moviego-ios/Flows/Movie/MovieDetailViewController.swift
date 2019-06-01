//
//  MovieViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 01/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController<BaseListView> {
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.movie.title
    }
}
