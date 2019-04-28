//
//  RegisterPasswordViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 28/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift

protocol RegisterPasswordNavigationDelegate: class {
    func didTapGoToCity()
}

class RegisterPasswordViewController: BaseViewController<RegisterPasswordView> {
    
    private let viewModel: RegisterPasswordViewModel
    weak var navigationDelegate: RegisterPasswordNavigationDelegate? = nil
    
    init(viewModel: RegisterPasswordViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Enter password"
        
        layout.continueButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak navigationDelegate] in navigationDelegate?.didTapGoToCity() })
            .disposed(by: disposeBag)
    }
}
