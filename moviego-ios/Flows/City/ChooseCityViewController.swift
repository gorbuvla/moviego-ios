//
//  ChooseCityViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ChooseCityNavigationDelegate: class {
    func onCityPicked()
}

class ChooseCityViewController: BaseViewController<BaseListView>, UITableViewDataSource, UITableViewDelegate {

    private let viewModel: ChooseCityViewModel
    var navigationDelegate: ChooseCityNavigationDelegate?
    
    init(viewModel: ChooseCityViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Registration.ChooseCity.title
        
        view.backgroundColor = .bkgLight
        layout.tableView.backgroundColor = .bkgLight
        layout.tableView.refreshControl = nil
        
        layout.tableView.delegate = self
        layout.tableView.dataSource = self
        layout.tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.ReuseIdentifiers.defaultId)
        
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 120
        
        viewModel.viewState.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.continuation.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                self.layout.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        viewModel.continuation.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak navigationDelegate] d in
                navigationDelegate?.onCityPicked() })
            .disposed(by: disposeBag)
        
        viewModel.continuation.error
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] error in
                if let error = error as? UnsupportedCityError {
                    self?.handleUnsupportedError(error: error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let city = viewModel.data[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = layout.tableView.dequeueReusableCell(withIdentifier: CityCell.ReuseIdentifiers.defaultId, for: indexPath) as! CityCell
        cell.city = city
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = viewModel.data[safe: indexPath.row] else { return }
        
        viewModel.selectCity(city)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func handleUnsupportedError(error: UnsupportedCityError) {
        let alert = UIAlertController(title: L10n.Registration.ChooseCity.Unsupported.title, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.General.ok, style: .default, handler: nil))
        present(alert, animated: true)
    }
}
