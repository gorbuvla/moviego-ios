//
//  DashboardViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DashboardNavigatioNDelegate: class {
    func didSelectMovie(movie: Movie)
    func didSelectSession(session: Session)
    func presentCinemaMap(from viewController: UIViewController)
}

class DashboardViewController: BaseViewController<BaseListView>, UITableViewDataSource, UITableViewDelegate {
    
    private let TOP_SESSIONS_CELL_INDEX = 2
    
    private let viewModel: DashboardViewModel
    
    weak var navigationDelegate: DashboardNavigatioNDelegate?
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Dashboard.title.uppercased()
        let mapButton = UIBarButtonItem(image: Asset.icMap.image, style: .plain, target: self, action: #selector(didTapMapButton))
        navigationItem.rightBarButtonItem = mapButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.Dashboard.logout, style: .plain, target: self, action: #selector(didTapLogout))
        
        layout.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.ReuseIdentifiers.defaultId)
        layout.tableView.register(SuggestSessionsCell.self, forCellReuseIdentifier: SuggestSessionsCell.ReuseIdentifiers.defaultId)
        
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
        
        bindUpdates()
    }
    
    private func bindUpdates() {
        viewModel.movieState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] _ in
                layout?.tableView.tableFooterView?.isHidden = true
                layout?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.sessionState
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] _ in layout?.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        viewModel.movieState.loading
            .map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // TODO: handle errors & empty
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count + min(viewModel.sessions.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == TOP_SESSIONS_CELL_INDEX && !viewModel.sessions.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: SuggestSessionsCell.ReuseIdentifiers.defaultId) as! SuggestSessionsCell
            cell.setupDataSource(sessions: viewModel.sessions, userLocation: viewModel.lastLocation, didSelectAction: self.didSelectSession(session:))
            cell.selectionStyle = .none
            return cell
        }
        
        let movieIndex = indexPath.row > TOP_SESSIONS_CELL_INDEX ? indexPath.row - min(1, viewModel.sessions.count) : indexPath.row
        
        guard let movie = viewModel.movies[safe: movieIndex] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.ReuseIdentifiers.defaultId, for: indexPath) as! MovieCell
        cell.movie = movie
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !(indexPath.row == TOP_SESSIONS_CELL_INDEX && viewModel.sessions.isNotEmpty) else { return }
        
        let movieIndex = indexPath.row > TOP_SESSIONS_CELL_INDEX ? indexPath.row - min(1, viewModel.sessions.count) : indexPath.row
        navigationDelegate?.didSelectMovie(movie: viewModel.movies[movieIndex])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastSection = indexPath.section == tableView.numberOfSections - 1
        let isLastRowInSection = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isLastSection && isLastRowInSection && viewModel.canFetchMore {
            layout.tableView.tableFooterView?.isHidden = viewModel.movies.count == 0
            viewModel.fetchNext()
        }
    }
    
    private func didSelectSession(session: Session) {
        navigationDelegate?.didSelectSession(session: session)
    }
    
    @objc private func didTapMapButton() {
        navigationDelegate?.presentCinemaMap(from: self)
    }
    
    @objc private func didTapLogout() {
        viewModel.logout()
    }
}
