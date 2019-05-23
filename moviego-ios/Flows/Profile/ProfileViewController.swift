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

class ProfileViewController: BaseViewController<UIView> {
    
    weak var navigationDelegate: ProfileNavigationDelegate?
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalClosable()
        view.backgroundColor = .white
        view.ui.label { it in
            it.text = "Profile & Latest Activity"
            it.textColor = .black
            
            it.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}

