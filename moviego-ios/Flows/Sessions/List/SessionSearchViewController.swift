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

protocol SessionSearchNavigationDelegate: class {
    func presentMap(from viewController: UIViewController)
    func presentProfile(from viewController: UIViewController)
    func didSelect(searchItem: SessionSearchItem)
}

class SessionSearchViewController: BaseListController, ProfileAccessoryController {

    weak var navigationDelegate: SessionSearchNavigationDelegate?
    private let viewModel: SessionSearchViewModel
    
    init(viewModel: SessionSearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.title = L10n.Sessions.title
        
        let mapButton = UIBarButtonItem(image: Asset.icMap.image, style: .plain, target: self, action: #selector(didTapMapButton))
        navigationItem.rightBarButtonItem = mapButton
        
        tableView.register(ShowtimeSearchCell.self, forCellReuseIdentifier: ShowtimeSearchCell.ReuseIdentifiers.defaultId)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.sectionHeaderHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.refreshControl = nil
        
        let searchController = UISearchController(searchResultsController:  nil)
        
//        searchController.searchResultsUpdater = self
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
        //searchController.searchBar.barTintColor = .primary
        searchController.searchBar.tintColor = .white
        searchController.searchBar.textField.backgroundColor = .primaryDark
        searchController.searchBar.placeholder = "Search Movies & Cinemas"
        //searchController.searchBar.backgroundColor = .primaryDark
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.searchController = searchController
        
        self.definesPresentationContext = true
        
        navigationItem.leftBarButtonItem = profileAccessoryButton(for: viewModel.profileImageId, action: #selector(didTapProfile))
        
        bindUpdates()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchItem = viewModel.data[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowtimeSearchCell.ReuseIdentifiers.defaultId, for: indexPath) as! ShowtimeSearchCell
        cell.searchItem = searchItem
        cell.selectionStyle = .default
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationDelegate?.didSelect(searchItem: viewModel.data[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastSection = indexPath.section == tableView.numberOfSections - 1
        let isLastRowInSection = indexPath.section == tableView.numberOfSections - 1
        
        if isLastSection && isLastRowInSection && viewModel.canFetchMore {
            viewModel.fetchNext()
        }
    }
    
    private func bindUpdates() {
        viewModel.viewState.loading
            .map { !$0 }
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // TODO: empty label
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak tableView] _ in tableView?.reloadData() })
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
