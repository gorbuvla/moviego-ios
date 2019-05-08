//
//  MovieListViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ShowtimeSearchNavigationDelegate: class {
    func presentMap(from viewController: UIViewController)
    func presentProfile(from viewController: UIViewController)
    func didSelect(searchItem: ShowtimeSearchItem)
}

class ShowtimeSearchViewController: BaseViewController<BaseListView>, ProfileAccessoryController, UITableViewDataSource, UITableViewDelegate {

    weak var navigationDelegate: ShowtimeSearchNavigationDelegate?
    private let viewModel: ShowtimeSearchViewModel
    
    init(viewModel: ShowtimeSearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapButton = UIBarButtonItem(image: Asset.icMap.image, style: .plain, target: self, action: #selector(didTapMapButton))
        navigationItem.rightBarButtonItem = mapButton
        
        layout.tableView.delegate = self
        layout.tableView.dataSource = self
        layout.tableView.register(ShowtimeSearchCell.self, forCellReuseIdentifier: ShowtimeSearchCell.ReuseIdentifiers.defaultId)
        
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 70
        layout.tableView.sectionHeaderHeight = 0
        layout.tableView.estimatedSectionHeaderHeight = 0
        
        navigationItem.leftBarButtonItem = profileAccessoryButton(for: viewModel.profileImageId, action: #selector(didTapProfile))
        
        bindUpdates()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchItem = viewModel.data[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = layout.tableView.dequeueReusableCell(withIdentifier: ShowtimeSearchCell.ReuseIdentifiers.defaultId, for: indexPath) as! ShowtimeSearchCell
        cell.searchItem = searchItem
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationDelegate?.didSelect(searchItem: viewModel.data[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastSection = indexPath.section == tableView.numberOfSections - 1
        let isLastRowInSection = indexPath.section == tableView.numberOfSections - 1
        
        if isLastSection && isLastRowInSection && viewModel.canFetchMore {
            viewModel.fetchNext()
        }
    }
    
    private func bindUpdates() {
        viewModel.viewState.loading
            .map { !$0 }
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // TODO: empty label
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] _ in layout?.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        // TODO: errors
    }
    
    private func checkPermissions() {
        
    }
    
    @objc private func didTapMapButton() {
        navigationDelegate?.presentMap(from: self)
    }
    
    @objc private func didTapProfile() {
        navigationDelegate?.presentProfile(from: self)
    }
}
