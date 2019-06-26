//
//  PromotionViewController.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 05/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

//
// TODO: unfinished promo detail
//
class PromotionViewController: UIViewController {
    
    private let promotion: Promotion
    
    init(promotion: Promotion) {
        self.promotion = promotion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Promo of \(promotion.movie.title)"
        view.backgroundColor = .bkgLight
    }
}
