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
        view.addSubview(header)
        flexibleHeader = header
        view.bringSubviewToFront(layout.loadingView)
        
        let tableHeader = SessionFilterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        filterHeader = tableHeader
        layout.tableView.tableHeaderView = tableHeader
        
        bindUpdates()
    }
    
    private func bindUpdates() {
        Observable.merge(viewModel.cinemas.loading, viewModel.sessions.loading, viewModel.movie.loading)
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
        
        viewModel.movie.data
            .observeOn(MainScheduler.instance)
            .bind { [weak self] movie in
                self?.flexibleHeader.movie = movie
            }
            .disposed(by: disposeBag)
        
        Observable.merge(viewModel.sessions.error, viewModel.movie.error)
            .observeOn(MainScheduler.instance)
            .bind  { [weak self] error in
                self?.handleError(error: error)
            }
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
        viewModel.movie.first()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] state in
                guard let movie = state?.value, let `self` = self else { return }
                
                let share = L10n.Session.shareMessage(movie.title) + " moviego://movie?id=\(movie.id)"
                let controller = UIActivityViewController(activityItems: [share], applicationActivities: nil)
                controller.excludedActivityTypes = [.postToWeibo, .postToTencentWeibo, .postToFacebook, .airDrop] // exclude all undesired activity types eligible for string sharing
                self.present(controller, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
