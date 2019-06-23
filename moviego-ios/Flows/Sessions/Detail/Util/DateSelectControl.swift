//
//  DateSelectControl.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 23/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class DateSelectControl: SelectControl<Date> {
    
    private weak var dateLabel: UILabel!
    
    override var emptyText: String {
        get { return "Choose Date" }
    }
    
    override func itemSelected(item: Date?) {
        super.itemSelected(item: item)
        
        guard let date = item else { return }
        
        dateLabel.text = date.toString(with: "dd:MM")
    }
    
    override func createContent() -> UIView {
        let label = UILabel()
        label.styleHeading2()
        label.textAlignment = .center
        label.textStyleDark(opacity: 0.8)
        dateLabel = label
        return label
    }
}
