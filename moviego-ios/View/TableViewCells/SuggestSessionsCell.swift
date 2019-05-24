//
//  ShowtimeRecommendationCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 24/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class SuggestSessionsCell: BaseTableViewCell<SessionSuggestView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "suggestSessionCell"
    }
    
    var sessions: [Session]? {
        didSet {
            guard let sessions = sessions else { return }
            
            layout.viewModel = SessionSuggectViewModel(sessions: sessions)
        }
    }
}
