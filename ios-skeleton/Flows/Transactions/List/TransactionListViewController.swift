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

class BaseViewController<V: UIView>: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var layout: V {
        get { return view as! V }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = V.init()
    }
    
}

class BaseListView: UIView {
    
    weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    //weak var activityIndicator: UIActivityIndicatorView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        self.tableView = tableView
        self.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl

//        let activityIndicator = UIActivityIndicatorView(style: .gray)
//        //activityIndicator.hidesWhenStopped = true
//        self.addSubview(activityIndicator)
//        self.activityIndicator = activityIndicator
    }
}

class BaseListViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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

        layout.tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "abc")

        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 50
        
//        viewModel.viewState.loading.map { !$0 }
//            .observeOn(MainScheduler.instance)
//            .bind(to: contentView.activityIndicator.rx.isHidden)
//            .disposed(by: disposeBag)

        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in self.layout.tableView.reloadData() })
            .disposed(by: disposeBag)

        //contentView.activityIndicator.startAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transaction = viewModel.data?[indexPath.row] else { return UITableViewCell() }
        let cell = layout.tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath) as! TransactionTableViewCell
        cell.transaction = transaction
        return cell
    }
}
