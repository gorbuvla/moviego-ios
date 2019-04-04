//
//  TransactionListViewController.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

protocol TransactionListNavigationDelegate {
    func didSelect(transaction: Transaction)
}

class TransactionListViewController: BaseViewController<BaseListView>, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: TransactionListViewModel
    
    init(viewModel: TransactionListViewModel) {
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
        layout.tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.ReuseIdentifiers.defaultId)

        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 50
        
        viewModel.viewState.loading.map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in self.layout.tableView.reloadData() })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transaction = viewModel.data?[indexPath.row] else { return UITableViewCell() }
        
        let cell = layout.tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.ReuseIdentifiers.defaultId, for: indexPath) as! TransactionTableViewCell
        cell.transaction = transaction
        return cell
    }
}
