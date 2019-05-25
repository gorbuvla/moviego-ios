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

class ChooseCityViewController: BaseListController {

    private let viewModel: ChooseCityViewModel
    var navigationDelegate: ChooseCityNavigationDelegate?
    
    init(viewModel: ChooseCityViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.ui.view { it in
            it.backgroundColor = .red
            
            it.snp.makeConstraints { make in
                make.top.equalTo(tableView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(100)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Registration.ChooseCity.title
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = item
        
        view.backgroundColor = .bkgLight
        tableView.backgroundColor = .bkgLight
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.ReuseIdentifiers.defaultId)
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        viewModel.viewState.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.continuation.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                self.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        viewModel.continuation.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak navigationDelegate] d in
                print(d)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let city = viewModel.data[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.ReuseIdentifiers.defaultId, for: indexPath) as! CityCell
        cell.city = city
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = viewModel.data[safe: indexPath.row] else { return }
        
        viewModel.selectCity(city)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func handleUnsupportedError(error: UnsupportedCityError) {
        let alert = UIAlertController(title: "Unsupported", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
