//
//  RegisterNameViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol UserRegistrationNavigationDelegate: class {
    func didTapContinue()
}

class RegisterUserViewController: BaseViewController<RegisterUserView> {
    
    private let viewModel: RegisterUserViewModel
    var navigationDelegate: UserRegistrationNavigationDelegate?
    
    init(viewModel: RegisterUserViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Enter info"
        
//        combinedFormInput.map { $0.isNotEmpty && $1.isNotEmpty }
//            .bind(to: layout.continueButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        layout.continueButton.rx.tap
            .bind(onNext: { [weak navigationDelegate] in navigationDelegate?.didTapContinue() })
            .disposed(by: disposeBag)
    }
    
    private var combinedFormInput: Observable<(String, String)> {
        get { return Observable.combineLatest(layout.nameTextField.textField.rx.text.orEmpty, layout.emailTextField.textField.rx.text.orEmpty) }
    }
}
