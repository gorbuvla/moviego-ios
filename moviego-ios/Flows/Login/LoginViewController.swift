//
//  LoginViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginNavigationDelegate: class {
    
    func didTapRegister()
    
    func didFinishLogin()
}

class LoginViewController: BaseViewController<LoginView> {
    
    private let viewModel: LoginViewModel
    
    weak var navigationDelegate: LoginNavigationDelegate?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        combinedFormInput.map { $0.isNotEmpty && $1.isNotEmpty }
            .bind(to: layout.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        layout.loginButton.rx.tap
            .withLatestFrom(combinedFormInput)
            .bind(onNext: { [weak viewModel] credential, password in viewModel?.login(emailOrUsername: credential, password: password) })
            .disposed(by: disposeBag)
        
        layout.registerButton.rx.tap
            .bind(onNext: { [weak navigationDelegate] in navigationDelegate?.didTapRegister() })
            .disposed(by: disposeBag)
        
        viewModel.viewState.loading
            .map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.error
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] error in
                switch error {
                case LoginValidationException.emailOrUsernameFieldError(let errorStr):
                    layout?.emailOrUsernameField.error = errorStr
                case LoginValidationException.passwordFieldError(let errorStr):
                    layout?.passwordField.error = errorStr
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layout.logoImage.snp.remakeConstraints { (make) in
            make.height.width.equalTo(180)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.layout.controlStack.isHidden = false
            })
        })
    }
    
    private var combinedFormInput: Observable<(String, String)> {
        get { return Observable.combineLatest(layout.emailOrUsernameField.textField.rx.text.orEmpty, layout.passwordField.textField.rx.text.orEmpty) }
    }
}
