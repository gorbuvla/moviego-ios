//
//  ProfileViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import SnapKit

protocol ProfileNavigationDelegate: class {
    // todo: methods
}

class ProfileViewController: ViewController {
    
    weak var navigationDelegate: ProfileNavigationDelegate?
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = "Profile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.label { it in
            it.text = "Profile & Latest Activity"
            it.textColor = .black
            
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}

