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

class LoginViewController: BaseViewController<LoginView>, UITextFieldDelegate {
    
    private let viewModel: LoginViewModel
    weak var navigationDelegate: LoginNavigationDelegate?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hasNavigationBar() -> Bool {
        return false
    }
    
    override func shouldObserveKeyboardChanges() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.emailOrUsernameField.textField.delegate = self
        layout.passwordField.textField.delegate = self
    
        if Environment.isDev {
            layout.emailOrUsernameField.textField.text = "movielover@moviego.me"
            layout.passwordField.textField.text = "password1"
        }
        
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
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.error
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] error in
                switch error {
                case LoginValidationException.emailOrUsernameFieldError(let errorStr):
                    self?.layout.emailOrUsernameField.error = errorStr
                case LoginValidationException.passwordFieldError(let errorStr):
                    self?.layout.passwordField.error = errorStr
                case ApiException.unauthorized:
                    self?.layout.passwordField.error = "Bad credentials"
                default:
                    self?.handleError(error: error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layout.logoImage.snp.remakeConstraints { (make) in
            make.height.width.equalTo(180)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.layout.controlStack.isHidden = false
            })
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case layout.emailOrUsernameField.textField:
            layout.passwordField.textField.becomeFirstResponder()
        case layout.passwordField.textField:
            layout.passwordField.textField.resignFirstResponder()
            
            guard let email = layout.emailOrUsernameField.textField.text,
                  let password = layout.passwordField.textField.text else {
                return false
            }
            
            if email.isNotEmpty && password.isNotEmpty {
                viewModel.login(emailOrUsername: email, password: password)
            }
        default: break
        }
        return false
    }
    
    override func receiveKeyboardChange(_ offset: CGFloat, _ duration: Double) {
        layout.scrollView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-offset)
        }
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    private var combinedFormInput: Observable<(String, String)> {
        get { return Observable.combineLatest(layout.emailOrUsernameField.textField.rx.text.orEmpty, layout.passwordField.textField.rx.text.orEmpty) }
    }
}
