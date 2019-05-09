//
//  CinemaDetailViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class CinemaDetailViewController: BaseViewController<CinemaDetailView> {
    
    private let viewModel: CinemaDetailViewModel
    
    init(viewModel: CinemaDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Cinema.Detail.title(viewModel.cinema.name)
        layout.titleLabel.text = viewModel.cinema.name
    }
}

