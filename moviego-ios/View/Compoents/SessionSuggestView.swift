//
//  TopSessionsView.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class SessionSuggestView: BaseView, UICollectionViewDelegate {
    
    private weak var collectionView: UICollectionView!
    
    var viewModel: SessionSuggectViewModel? {
        didSet {
            collectionView.dataSource = viewModel
            collectionView.reloadData()
        }
    }
    
    override func createView() {
        backgroundColor = .red
        
        let sectionTitle = UILabel()
        sectionTitle.text = L10n.Sessions.Suggest.title
        addSubview(sectionTitle)
        sectionTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview()
        }
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.minimumLineSpacing = 24
        collectionFlowLayout.itemSize = CGSize(width: 108, height: 132)
        collectionFlowLayout.scrollDirection = .horizontal
        //collectionFlowLayout.sectionInset = UIEdgeInsets(0, 16, 0, 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(132)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        self.collectionView = collectionView
    }
}

class SessionSuggectViewModel: NSObject, UICollectionViewDataSource {
    
    private(set) var sessions: [Session]
    
    init(sessions: [Session]) {
        self.sessions = sessions
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SuggestedSessionCell = collectionView.dequeueCell(for: indexPath)
        cell.session = sessions[safe: indexPath.item]
        return cell
    }
}
