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
    private weak var filterHeader: SessionFilterView!
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
        
        layout.tableView.backgroundColor = .bkgLight
        layout.tableView.dataSource = self
        layout.tableView.delegate = self
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 70
        layout.tableView.sectionHeaderHeight = 0
        layout.tableView.estimatedSectionHeaderHeight = 0
        layout.tableView.refreshControl = nil
        layout.tableView.register(SessionCell.self, forCellReuseIdentifier: SessionCell.ReuseIdentifiers.defaultId)
        layout.tableView.contentInset = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        
        let header = FlexibleSessionHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: kHeaderHeight))
        header.delegate = self
        header.movie = viewModel.movie
        view.addSubview(header)
        flexibleHeader = header
        view.bringSubviewToFront(layout.loadingView)
        
        let tableHeader = SessionFilterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        filterHeader = tableHeader
        layout.tableView.tableHeaderView = tableHeader
        
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
        
        viewModel.selectedCinema
            .observeOn(MainScheduler.instance)
            .bind { [weak filterHeader] cinema in
                filterHeader?.cinemaSelect.itemSelected(item: cinema)
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedDate
            .observeOn(MainScheduler.instance)
            .bind { [weak filterHeader] date in
                filterHeader?.dateSelect.itemSelected(item: date)
            }
            .disposed(by: disposeBag)
        
        filterHeader.cinemaSelect.rx.controlEvent(.touchUpInside)
            .bind {
                // TODO: present options
            }
            .disposed(by: disposeBag)
        
        filterHeader.dateSelect.rx.controlEvent(.touchUpInside)
            .bind {
                // TODO: present options
            }
            .disposed(by: disposeBag)
    }
}

//
// MARK: UITableView data source & delegate
//
extension SessionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sessionList.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = viewModel.sessionList.key(at: section)
        return viewModel.sessionList[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sessionList.key(at: section).rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = viewModel.sessionList.key(at: indexPath.section)
        let session = viewModel.sessionList[key]![indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: SessionCell.ReuseIdentifiers.defaultId) as! SessionCell
        cell.session = session
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        flexibleHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: -scrollView.contentOffset.y)
        
        // TODO: something better + affects navBar of whole navController!!!
        let background = kHeaderHeight + 64 + scrollView.contentOffset.y > kHeaderHeight / 2 ? UIColor.secondary.image() : UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(background, for: .default)
    }
}

//
// MARK: FlexibleSessionHeaderDelegate
//
extension SessionDetailViewController: FlexibleSessionHeaderDelegate {
    func didTapInviteFriends() {
        let share = L10n.Session.shareMessage(viewModel.movie.title)
        let controller = UIActivityViewController(activityItems: [share], applicationActivities: nil)
        controller.excludedActivityTypes = [.postToWeibo, .postToTencentWeibo, .postToFacebook, .airDrop] // exclude all undesired activity types eligible for string sharing
        present(controller, animated: true, completion: nil)
    }
}
