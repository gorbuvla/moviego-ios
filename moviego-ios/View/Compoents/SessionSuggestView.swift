//
//  TopSessionsView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import CoreLocation

class SessionSuggestView: BaseView, UICollectionViewDelegate {
    
    private weak var collectionView: UICollectionView!
    
    var viewModel: SessionSuggectViewModel? {
        didSet {
            collectionView.dataSource = viewModel
            collectionView.delegate = viewModel
            collectionView.reloadData()
        }
    }
    
    override func createView() {
        backgroundColor = .bkgLight
        
        let sectionTitle = UILabel()
        sectionTitle.styleHeading2()
        sectionTitle.textStyleDark()
        sectionTitle.text = L10n.Dashboard.SessionSuggest.title
        addSubview(sectionTitle)
        sectionTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(5)
        }
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.minimumLineSpacing = 8
        collectionFlowLayout.itemSize = CGSize(width: 144, height: 224)
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .bkgLight
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
        self.collectionView = collectionView
    }
}

class SessionSuggectViewModel: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private(set) var sessions: [Session]
    private(set) var location: CLLocation?
    private(set) var didSelectAction: (Session) -> ()
    
    init(sessions: [Session], userLocation: CLLocation?, didSelectAction: @escaping (Session) -> ()) {
        self.sessions = sessions
        self.location = userLocation
        self.didSelectAction = didSelectAction
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let session = sessions[safe: indexPath.item] else { return UICollectionViewCell() }
        let cell: SuggestedSessionCell = collectionView.dequeueCell(for: indexPath)
        cell.value = (session, location)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let session = sessions[safe: indexPath.row] else { return }
        
        didSelectAction(session)
    }
}
