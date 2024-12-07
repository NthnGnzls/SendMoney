//
//  LoginModel.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//

import UIKit

class LoginModel: NSObject, NSCoding{
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
class PersonalDetails: NSObject, NSCoding{
    var first_name: String?
    var last_name: String?
    
    func encode(with coder: NSCoder) {
        coder.encode(first_name, forKey: "first_name")
        coder.encode(last_name, forKey: "last_name")
    }
    
    required init?(coder: NSCoder) {
        self.first_name = coder.decodeObject(forKey: "first_name") as? String ?? ""
        self.last_name = coder.decodeObject(forKey: "last_name") as? String ?? ""
    }
    
    init(json: [String:Any]){
        self.first_name = json["first_name"] as? String ?? ""
        self.last_name = json["last_name"] as? String ?? ""
    }
}
class Transactions: NSObject, NSCoding{
    var transaction_id: Int?
    var title: String?
    var desc: String?
    var amount: Double?
    var date: String?
    var ref_num: String?
    
    func encode(with coder: NSCoder) {
        coder.encode(transaction_id, forKey: "transaction_id")
        coder.encode(title, forKey: "title")
        coder.encode(desc, forKey: "desc")
        coder.encode(amount, forKey: "amount")
        coder.encode(date, forKey: "date")
        coder.encode(ref_num, forKey: "ref_num")
    }
    
    required init?(coder: NSCoder) {
        self.transaction_id = coder.decodeInteger(forKey: "transaction_id")
        self.title = coder.decodeObject(forKey: "title") as? String ?? ""
        self.desc = coder.decodeObject(forKey: "desc") as? String ?? ""
        self.amount = coder.decodeDouble(forKey: "amount")
        self.date = coder.decodeObject(forKey: "date") as? String ?? ""
        self.ref_num = coder.decodeObject(forKey: "ref_num") as? String ?? ""
    }
    
    init(json: [String:Any]){
        self.transaction_id = json["transaction_id"] as? Int ?? 0
        self.title = json["title"] as? String ?? ""
        self.desc = json["description"] as? String ?? ""
        self.amount = json["amount"] as? Double ?? 0.0
        self.date = json["date"] as? String ?? ""
        self.ref_num = json["ref_num"] as? String ?? ""
    }
}
/*
 {
     "status": "success",
     "message": "Login successful",
     "data": {
         "wallet_balance": 500.00,
         "personal_details": {
             "first_name": "Juan",
             "last_name": "dela Cruz"
         },
         "transactions": [
             {
                 "transaction_id": 0,
                 "title": "Remittance 1",
                 "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                 "date": "December 5, 2024",
                 "amount": 200,
                 "ref_num": "1A2B3C4D5E6F"
             }
         ]
     }
 }
 
 */
