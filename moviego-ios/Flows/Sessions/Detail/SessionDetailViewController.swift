//
//  ShowtimeDetailViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class SessionDetailViewController: BaseViewController<SessionDetailView> {
    
    private let viewModel: SessionDetailViewModel
    
    init(viewModel: SessionDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.labelText.text = "\(viewModel.movie.title) at \(viewModel.cinema.name)"
    }
}
