//
//  BaseListView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import SnapKit

class BaseListView: BaseView {
    
    weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    weak var loadingView: LoadingView!
    
    override func createView() {
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
        
        let loadingView = LoadingView()
        loadingView.isHidden = true
        self.ui.addView(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.loadingView = loadingView
    }
}
