//
//  ShowtimeRecommendationCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit
import MapKit

class SuggestSessionsCell: BaseTableViewCell<SessionSuggestView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "suggestSessionCell"
    }
    
    func setupDataSource(sessions: [Session], userLocation: CLLocation?, didSelectAction: @escaping (Session) -> ()) {
        layout.viewModel = SessionSuggectViewModel(sessions: sessions, userLocation: userLocation, didSelectAction: didSelectAction)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .bkgLight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
