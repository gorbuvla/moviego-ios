//
//  TodayViewController.swift
//  TodaySessionsExtension
//
//  Created by Vlad Gorbunov on 24/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import CoreData
import NotificationCenter

//
// UIViewController for Today Extension showing top movies in a single row.
//
final class TodayViewController: UIViewController, NCWidgetProviding {
    
    private weak var collectionView: UICollectionView?
    private let sectionInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    private let kItemsPerRow: CGFloat = 5
    private let viewModel = TodaySessionsViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.ReuseIdentifiers.defaultId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
        viewModel.delegate = self
        
        collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        collectionView?.frame = view.frame
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}

extension TodayViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.ReuseIdentifiers.defaultId, for: indexPath) as! TodayMovieCollectionViewCell
        
        cell.movie = viewModel.object(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dHeight = view.bounds.height - sectionInsets.top - sectionInsets.bottom
        let dWidth = dHeight * 0.67
        let available = view.bounds.width - sectionInsets.left - sectionInsets.right - kItemsPerRow * 4
        let kWidth = available / kItemsPerRow
        
        let width = min(kWidth, dWidth)
        let height = width * 1.33
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.object(at: indexPath)
        
        extensionContext?.open(URL(string: "moviego://movie?id=\(movie.id)")!, completionHandler: nil)
    }
}

extension TodayViewController: TodaySessionsDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.reloadData()
    }
}
