//
//  BaseViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift

//
// UINavigationController that sets up provided view.
//
class BaseViewController<V: UIView>: UIViewController {
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    var layout: V {
        get { return view as! V }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // cos u cant override stored properties... and i dont want to provide getter & setter each time, facepalm...
    func hasNavigationBar() -> Bool {
        return true
    }
    
    func shouldObserveKeyboardChanges() -> Bool {
        return false
    }
    
    override func loadView() {
        super.loadView()
        view = V.init()
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.isEnabled = false
        view.addGestureRecognizer(tapGestureRecognizer)
        self.tapGestureRecognizer = tapGestureRecognizer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
        
        tapGestureRecognizer.isEnabled = shouldObserveKeyboardChanges()
        tapGestureRecognizer.rx.event
            .bind(onNext: { _ in self.view.endEditing(true) })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!hasNavigationBar(), animated: animated)
        
        if shouldObserveKeyboardChanges() {
            Observable.merge(keyboardOpenObservable, keyboardCloseObservable)
                .takeUntil(rx.methodInvoked(#selector(viewWillDisappear(_:))))
                .bind(onNext: { (offset, duration) in self.receiveKeyboardChange(offset, duration) })
                .disposed(by: disposeBag)
        }
    }
    
    func receiveKeyboardChange(_ offset: CGFloat, _ duration: Double) {}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    func modalClosable() {
        let closeButton = UIBarButtonItem(image: Asset.icClose.image, style: .plain, target: self, action: #selector(close))
        closeButton.tintColor = .white
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private var keyboardOpenObservable: Observable<(CGFloat, Double)> {
        get { return NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).mapOffsetDuration() }
    }
    
    private var keyboardCloseObservable: Observable<(CGFloat, Double)> {
        get { return NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).mapOffsetDuration().map { (0, $1)} }
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}

extension Observable where Element == Notification {
    
    func mapOffsetDuration() -> Observable<(CGFloat, Double)> {
        return self.map { notification in
            let offset = UIScreen.main.bounds.size.height - ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.origin.y ?? CGFloat(0))
            let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            return (offset, duration)
        }
    }
}

extension BaseViewController where V: UIView {
    
    func handleError(error: Error) {
        var errorMessage = ""
        switch error {
        default: errorMessage = "Something weird happened...."
        }
        
        let errorAlert = UIAlertController(title: "Uncategorized error", message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(errorAlert, animated: true)
    }
}
