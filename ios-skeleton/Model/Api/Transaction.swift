//
//  Transaction.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation


struct TransactionListResponse {
    let items: [Transaction]
}

struct Transaction: Codable {
    let id: Int
    let amountInAccountCurrency: Int
    let direction: TrDirection
}

enum TrDirection: String {
    case incoming = "INCOMING"
    case outgoing = "OUTGOING"
}

extension TrDirection: Codable {
    
}
