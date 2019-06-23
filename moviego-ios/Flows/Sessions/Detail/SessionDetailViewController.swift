//
//  ShowtimeDetailViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SessionDetailViewController: BaseViewController<BaseListView> {
    
    private let kHeaderHeight = CGFloat(300)
    private weak var flexibleHeader: FlexibleSessionHeader!
    private let viewModel: SessionDetailViewModel
    
    init(viewModel: SessionDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.movie.title
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        layout.tableView.dataSource = self
        layout.tableView.delegate = self
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 70
        layout.tableView.sectionHeaderHeight = 0
        layout.tableView.estimatedSectionHeaderHeight = 0
        layout.tableView.refreshControl = nil
        layout.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customId")
        layout.tableView.contentInset = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        
        let header = FlexibleSessionHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: kHeaderHeight))
        header.delegate = self
        header.movie = viewModel.movie
        view.addSubview(header)
        flexibleHeader = header
        view.bringSubviewToFront(layout.loadingView)
        
        bindUpdates()
    }
    
    private func bindUpdates() {
        Observable.merge(viewModel.cinemas.loading, viewModel.sessions.loading)
            .map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.sessions.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] _ in
                layout?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension SessionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sessionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customId") as! UITableViewCell
        let session = viewModel.sessionList[indexPath.row]
        cell.textLabel?.text = "\(session.type) \(session.startsAt)"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        flexibleHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: -scrollView.contentOffset.y)
        
        // TODO: something better + affects navBar of whole navController!!!
        let background = kHeaderHeight + 64 + scrollView.contentOffset.y > kHeaderHeight / 2 ? UIColor.secondary.image() : UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(background, for: .default)
    }
}

extension SessionDetailViewController: FlexibleSessionHeaderDelegate {
    func didTapPlayVideo() {
        
    }
}
