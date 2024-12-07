//
//  TransactionHistoryModel.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit

class TransactionHistoryModel: NSObject, NSCoding{
    func encode(with coder: NSCoder) {
        coder.encode(wallet_balance, forKey: "wallet_balance")
        coder.encode(personal_details, forKey: "personal_details")
        coder.encode(transactions, forKey: "transactions")
    }
    
    required init?(coder: NSCoder) {
        self.wallet_balance = coder.decodeDouble(forKey: "wallet_balance")
        self.personal_details = coder.decodeObject(forKey: "personal_details") as? PersonalDetails
        self.transactions = coder.decodeObject(forKey: "transactions") as? [Transactions] ?? []
    }
    
    var wallet_balance: Double?
    var personal_details: PersonalDetails?
    var transactions = [Transactions]()
    
    init(json: [String:Any]){
        self.wallet_balance = json["wallet_balance"] as? Double
        self.personal_details = PersonalDetails.init(json: json["personal_details"] as? [String:Any] ?? [:])
        for item in json["transactions"] as? [[String:Any]] ?? []{
            self.transactions.append(Transactions.init(json: item))
        }
    }
}

