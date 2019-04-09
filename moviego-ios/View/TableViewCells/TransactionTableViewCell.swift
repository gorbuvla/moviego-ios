//
//  TransactionCell.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import UIKit

class TransactionTableViewCell: BaseTableViewCell<TransactionCellView> {
    
    enum ReuseIdentifiers {
        static let defaultId = "transactionCell"
    }
    
    var transaction: Transaction? {
        didSet {
            guard let transaction = transaction else { return }
            
            layout.transactionIdText.text = "Transaction id: \(transaction.id)"
            layout.amountText.text = "Amount: \(transaction.amountInAccountCurrency)"
            // TODO
            //view.directionText.text = transaction.direction
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TransactionCellView: BaseView {
    
    weak var transactionIdText: UITextView!
    weak var amountText: UITextView!
    weak var directionText: UITextView!
    
    override func createView() {
        let transactionIdText = UITextView()
        transactionIdText.textColor = .black
        transactionIdText.backgroundColor = .yellow
        self.addSubview(transactionIdText)
        transactionIdText.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(0.5)
        }
        self.transactionIdText = transactionIdText
        
        let amountText = UITextView()
        amountText.textColor = .black
        self.addSubview(amountText)
        amountText.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(transactionIdText.snp.bottom)
        }
        self.amountText = amountText
        
        let directionText = UITextView()
        self.addSubview(directionText)
        directionText.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalTo(transactionIdText.snp.bottom)
        }
        self.directionText = directionText
    }
}
