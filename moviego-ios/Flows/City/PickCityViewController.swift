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

protocol PickCityNavigationDelegate: class {
    func onPickSuccess()
}

class PickCityViewController: BaseViewController<PickCityView>, UITableViewDataSource, UITableViewDelegate {

    private let viewModel: CitySelectModeling
    var navigationDelegate: PickCityNavigationDelegate?
    
    init(viewModel: CitySelectModeling) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.tableView.delegate = self
        layout.tableView.dataSource = self
        layout.tableView.register(PickCityCell.self, forCellReuseIdentifier: PickCityCell.ReuseIdentifiers.defaultId)
        
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 50
        
        viewModel.viewState.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.continuationState.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                print(data)
                self.layout.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        viewModel.viewState.data.map { options in options.contains(where: { option in option.1 }) }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.continuationState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak navigationDelegate] in navigationDelegate?.onPickSuccess() })
            .disposed(by: disposeBag)
    
        layout.continueButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] in self?.viewModel.register() })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let option = viewModel.data[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = layout.tableView.dequeueReusableCell(withIdentifier: PickCityCell.ReuseIdentifiers.defaultId, for: indexPath) as! PickCityCell
        cell.option = option
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let (city, _) = viewModel.data[safe: indexPath.row] else { return }
        
        viewModel.selectCity(city)
    }
}
