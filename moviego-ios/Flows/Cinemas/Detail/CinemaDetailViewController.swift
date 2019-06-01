//
//  CinemaDetailViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift

protocol CinemaDetailNavigationDelegate: class {
    func didSelect(movie: Movie, in cinema: Cinema)
}

class CinemaDetailViewController: BaseViewController<BaseListView>, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel: CinemaDetailViewModel
    
    weak var navigationDelegate: CinemaDetailNavigationDelegate?
    
    init(viewModel: CinemaDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.ReuseIdentifiers.defaultId)
        
        layout.tableView.dataSource = self
        layout.tableView.delegate = self
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 70
        layout.tableView.sectionHeaderHeight = 0
        layout.tableView.estimatedSectionHeaderHeight = 0
        layout.tableView.refreshControl = nil
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: layout.tableView.bounds.width, height: CGFloat(44))
        
        layout.tableView.tableFooterView = spinner
        layout.tableView.tableFooterView?.isHidden = true
        
        // TODO: setup header with cinema info
        
        bindUpdates()
    }
    
    private func bindUpdates() {
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] _ in
                print("Data")
                layout?.tableView.tableFooterView?.isHidden = true
                layout?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.viewState.loading
            .map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = viewModel.movies[safe: indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.ReuseIdentifiers.defaultId, for: indexPath) as! MovieCell
        cell.movie = movie
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationDelegate?.didSelect(movie: viewModel.movies[indexPath.row], in: viewModel.cinema)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastSection = indexPath.section == tableView.numberOfSections - 1
        let isLastRowInSection = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isLastSection && isLastRowInSection && viewModel.canFetchMore {
            layout.tableView.tableFooterView?.isHidden = viewModel.movies.count == 0
            viewModel.fetchNext()
        }
    }
}
