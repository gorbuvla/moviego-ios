//
//  CinemaDetailViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import MapKit
import SafariServices
import RxSwift

protocol CinemaDetailNavigationDelegate: class {
    func didSelect(movie: Movie, in cinema: Cinema)
}

final class CinemaDetailViewController: BaseViewController<BaseListView> {
    
    private let kHeaderHeight: CGFloat = 300
    
    private let viewModel: CinemaDetailViewModel
    private weak var flexibleHeader: FlexibleCinemaHeader!
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
        self.navigationController?.navigationBar.isTranslucent = true
        
        layout.tableView.dataSource = self
        layout.tableView.delegate = self
        layout.tableView.separatorStyle = .none
        layout.tableView.rowHeight = UITableView.automaticDimension
        layout.tableView.estimatedRowHeight = 70
        layout.tableView.sectionHeaderHeight = 0
        layout.tableView.estimatedSectionHeaderHeight = 0
        layout.tableView.refreshControl = nil
        layout.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.ReuseIdentifiers.defaultId)
        layout.tableView.backgroundColor = .bkgLight
        layout.tableView.contentInset = UIEdgeInsets(top: kHeaderHeight, left: 0, bottom: 0, right: 0)
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: layout.tableView.bounds.width, height: CGFloat(44))
        
        layout.tableView.tableFooterView = spinner
        layout.tableView.tableFooterView?.isHidden = true
        
        let header = FlexibleCinemaHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: kHeaderHeight))
        header.delegate = self
        header.cinema = viewModel.cinema
        view.addSubview(header)
        flexibleHeader = header
        view.bringSubviewToFront(layout.loadingView)
        
        bindUpdates()
    }
    
    private func bindUpdates() {
        viewModel.viewState.data
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak layout] _ in
                layout?.tableView.tableFooterView?.isHidden = true
                layout?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.viewState.loading
            .map { !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: layout.loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.viewState.error
            .observeOn(MainScheduler.instance)
            .bind { [weak self] error in
                self?.handleError(error: error)
            }
            .disposed(by: disposeBag)
    }
}

//
// MARK: UITableView delegate & data source
//
extension CinemaDetailViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        flexibleHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: -scrollView.contentOffset.y)
        
        // TODO: something better + affects navBar of whole navController!!!
        let background = kHeaderHeight + 64 + scrollView.contentOffset.y > kHeaderHeight / 2 ? UIColor.secondary.image() : UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(background, for: .default)
    }
}

//
// MARK: Header delegate
//
extension CinemaDetailViewController: FlexibleCinemaHeaderDelegate {
    func didTapNavigate() {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: viewModel.cinema.lat, longitude: viewModel.cinema.lng)))
        mapItem.openInMaps(launchOptions: nil)
    }
    
    func didTapTaxi() {
        let ul = "https://m.uber.com/ul/?action=setPickup"
                    + "&pickup=my_location"
                    + "&dropoff[formatted_address]=\(viewModel.cinema.name.addingPercentEncoding(withAllowedCharacters: CharacterSet())!)"
                    + "&dropoff[latitude]=\(viewModel.cinema.lat)"
                    + "&dropoff[longitude]=\(viewModel.cinema.lng)"
        
        UIApplication.shared.open(URL(string: ul)!, options: [:])
    }
    
    func didTapWeb() {
        let vc = SFSafariViewController(url: viewModel.cinema.website)
        present(vc, animated: true)
    }
}
