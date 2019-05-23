//
//  BaseListController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 20/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import RxSwift

class BaseListController: UITableViewController {
    
    let disposeBag = DisposeBag()
    weak var loadingView: LoadingView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.scrollsToTop = true
        
        let loadingView = LoadingView()
        loadingView.isHidden = true
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.loadingView = loadingView
    }
}
