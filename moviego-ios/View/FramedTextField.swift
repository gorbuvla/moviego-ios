//
//  FramedTextField.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift

class FramedTextField: BaseView {
    
    enum Style {
        case light
        case dark
        
        var textColor: UIColor {
            switch self {
            case .light: return .secondary
            case .dark: return .primary
            }
        }
        
        var bgColor: UIColor {
            switch self {
            case .light: return UIColor.primary.withAlphaComponent(0.6)
            case .dark: return UIColor.secondary.withAlphaComponent(0.6)
            }
        }
        
        var selectedColor: UIColor {
            switch self {
            case .light: return .primary
            case .dark: return .secondary
            }
        }
        
        var activeBorderColor: UIColor {
            switch self {
            case .light: return .secondary
            case .dark: return .primary
            }
        }
        
        var inactiveBorderColor: UIColor {
            switch self {
            case .light: return UIColor.secondary.withAlphaComponent(0.6)
            case .dark: return UIColor.primary.withAlphaComponent(0.6)
            }
        }
        
        var placeholderColor: UIColor {
            switch self {
            case .light: return UIColor(named: .textDark).withAlphaComponent(0.6)
            case .dark: return UIColor(named: .bkgLight).withAlphaComponent(0.6)
            }
        }
    }

    enum State {
        case active
        case inactive
    }
    
    private var controlEventsBag: DisposeBag = DisposeBag()
    private var style: Style = .dark
    
    weak var backgroundView: UIView!
    weak var titleLabel: UILabel!
    weak var textField: UITextField!
    weak var secureInputButton: UIButton!
    weak var errorLabel: UILabel!
    
    var state: State = .inactive {
        didSet {
            updateAppearance()
        }
    }
    
    var placeholderText: String? = nil {
        didSet {
            titleLabel.text = placeholderText?.uppercased()
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
            secureInputButton.isHidden = !isSecureTextEntry
        }
    }
    
    var error: String? {
        didSet {
            errorLabel.text = error
        }
    }
    
    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        bind()
        updateAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createView() {
        
        titleLabel = ui.label { it in
            it.textColor = style.textColor
            it.styleLabel()
            
            it.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
            }
        }
        
        backgroundView = ui.view { it in
            it.layer.cornerRadius = 15
            it.layer.borderWidth = 3
            it.layer.borderColor = UIColor.white.cgColor
            
            it.ui.stack { it in
                textField = it.ui.textField { it in
                    it.textColor = style.textColor
                    it.placeholder = "Placeholder"
                    it.styleParagraphLarge()
                }
                
                secureInputButton = it.ui.button { it in
                    it.isHidden = true
                    it.setImage(Asset.secureOff.image, for: .normal)
                    it.addTarget(self, action: #selector(didTapSecureInput), for: .touchUpInside)
                }
                
                it.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.top.bottom.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            }
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(7)
                make.height.equalTo(50)
            }
        }
        
        errorLabel = ui.label { it in
            it.styleError()
            
            it.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(backgroundView.snp.bottom).offset(3)
                make.height.equalTo(15)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func updateAppearance() {
        // TODO: theming
        let activeBorderColor = error == nil ? self.style.activeBorderColor : UIColor.red
        let inactiveBorderColor = error == nil ? self.style.inactiveBorderColor : UIColor.red
        
        switch state {
        case .active:
            backgroundView.layer.borderColor = activeBorderColor.cgColor
            backgroundView.layer.borderWidth = 1
            backgroundView.backgroundColor = style.selectedColor
        case .inactive:
            backgroundView.layer.borderColor = inactiveBorderColor.cgColor
            backgroundView.layer.borderWidth = 1
            backgroundView.backgroundColor = style.bgColor
        }
    }
    
    private func bind() {
        textField.rx.controlEvent(.editingDidBegin)
            .bind(onNext: { [weak self] in self?.state = .active })
            .disposed(by: controlEventsBag)
        
        textField.rx.controlEvent(.editingDidEnd)
            .bind(onNext: { [weak self] in self?.state = .inactive })
            .disposed(by: controlEventsBag)
        
        textField.rx.controlEvent(.valueChanged).map { nil }
            .bind(to: errorLabel.rx.text)
            .disposed(by: controlEventsBag)
    }
    
    @objc private func didTapSecureInput() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        
        let asset = textField.isSecureTextEntry ? Asset.secureOff : Asset.secureOn
        secureInputButton.setImage(asset.image, for: .normal)
    }
}
