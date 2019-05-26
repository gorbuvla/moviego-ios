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

protocol RegistrUserNavigationDelegate: class {
    func didTapNext()
}

class RegisterUserViewController: BaseViewController<RegisterUserView>, UITextFieldDelegate {
    
    private let viewModel: RegisterUserViewModel
    var navigationDelegate: RegistrUserNavigationDelegate?
    
    init(viewModel: RegisterUserViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldObserveKeyboardChanges() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Registration.User.title
        layout.nameTextField.textField.delegate = self
        layout.surnameTextField.textField.delegate = self
        layout.emailTextField.textField.delegate = self
        layout.passwordTextField.textField.delegate = self
        layout.confirmTextField.textField.delegate = self
        
        layout.continueButton.rx.tap
            .withLatestFrom(combinedFormInput) { $1 }
            .bind(onNext: { [weak viewModel] (name, surname, email, password, confirm) in
                viewModel?.submit(name: name, surname: surname, email: email, password: password, confirm: confirm)
            })
            .disposed(by: disposeBag)

        combinedFormInput.map { (name, surname, email, password, confirm) in
                name.isNotEmpty && surname.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirm.isNotEmpty
            }
            .bind(to: layout.continueButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.viewState.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak navigationDelegate] _ in navigationDelegate?.didTapNext() })
            .disposed(by: disposeBag)
        
        viewModel.viewState.error
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] error in
                if let error = error as? RegisterationValidationException {
                    self?.handleValidationError(error: error)
                } else {
                    self?.handleError(error: error)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.viewState
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak navigationDelegate] _ in navigationDelegate?.didTapNext() },
                onError: { [weak self] error in self?.handleError(error: error as! RegisterationValidationException) }
            )
            .disposed(by: disposeBag)
        
        layout.continueButton.rx.tap
            .bind(onNext: { [weak navigationDelegate] in navigationDelegate?.didTapNext() })
            .disposed(by: disposeBag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case layout.nameTextField.textField:
            layout.surnameTextField.textField.becomeFirstResponder()
        case layout.surnameTextField.textField:
            layout.emailTextField.textField.becomeFirstResponder()
        case layout.emailTextField.textField:
            layout.passwordTextField.becomeFirstResponder()
        case layout.passwordTextField.textField:
            layout.confirmTextField.textField.becomeFirstResponder()
        case layout.confirmTextField.textField:
            layout.confirmTextField.textField.resignFirstResponder()
            
            guard let name = layout.nameTextField.textField.text,
                let surname = layout.surnameTextField.textField.text,
                let email = layout.emailTextField.textField.text,
                let password = layout.passwordTextField.textField.text,
                let confirm = layout.confirmTextField.textField.text else {
                    return false
                }
            
            if name.isNotEmpty && surname.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirm.isNotEmpty {
                viewModel.submit(name: name, surname: surname, email: email, password: password, confirm: confirm)
            }
        default: break
        }
        
        return false
    }
    
    override func receiveKeyboardChange(_ offset: CGFloat, _ duration: Double) {
        layout.footerView.snp.updateConstraints { make in
            make.bottom.equalTo(safeArea).offset(-offset)
        }
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    private func handleValidationError(error: RegisterationValidationException) {
        switch error {
        case .nameFieldError(let errorStr):
            layout.nameTextField.error = errorStr
        case .surnameFieldError(let errorStr):
            layout.surnameTextField.error = errorStr
        case .emailFieldError(let errorStr):
            layout.emailTextField.error = errorStr
        case .passwordFieldError(let errorStr):
            layout.passwordTextField.error = errorStr
        case .confirmFieldError(let errorStr):
            layout.confirmTextField.error = errorStr
        }
    }
    
    private var combinedFormInput: Observable<(String, String, String, String, String)> {
        get {
            return Observable.combineLatest(
                layout.nameTextField.textField.rx.text.orEmpty,
                layout.surnameTextField.textField.rx.text.orEmpty,
                layout.emailTextField.textField.rx.text.orEmpty,
                layout.passwordTextField.textField.rx.text.orEmpty,
                layout.confirmTextField.textField.rx.text.orEmpty
            )
        }
    }
}
