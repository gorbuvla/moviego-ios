//
//  Transaction.swift
//  ios-skeleton
//
//  Created by Vlad Gorbunov on 31/03/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let id: Int
    let amountInAccountCurrency: Int
    let direction: TrDirection
}

struct TransactionInfo: Codable {
    let accountNumber: String
    let accountName: String
    let bankCode: String
}

enum TrDirection: String {
    case incoming = "INCOMING"
    case outgoing = "OUTGOING"
}

extension TrDirection: Codable {
    
}

struct TransactionListResponse: Codable {
    let items: [Transaction]
}

struct TransactionInfoResponse: Codable {
    let contraAccount: TransactionInfo
}
