//
//  BalanceInquiryModel.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//
import UIKit
class BalanceInquiryModel: NSObject{
    
    var current_balance: String?
    init (json: [String:Any]){
        self.current_balance = json["current_balance"] as? String ?? ""
    }
}
   
