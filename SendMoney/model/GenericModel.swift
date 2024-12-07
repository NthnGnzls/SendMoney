//
//  GenericModel.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//
	

import UIKit

class GenericModel: NSObject {
    var status: Int?
    var message: String?
    var loginModel : LoginModel?
    var newsModel : NewsModel?
    var sendMoneyModel : SendMoneyModel?
    var transactionHistoryModel : TransactionHistoryModel?
    var balanceInquiryModel : BalanceInquiryModel?
    init(json: [String: Any]){
        self.status = json["status"] as? Int ?? 0
        self.message = json["message"] as? String ?? ""
        self.loginModel = LoginModel.init(json: json["data"] as? [String:Any] ?? [:])
        self.newsModel = NewsModel.init(json: json["data"] as? [String:Any] ?? [:])
        self.sendMoneyModel = SendMoneyModel.init(json: json["data"] as? [String:Any] ?? [:])
        self.transactionHistoryModel = TransactionHistoryModel.init(json: json["data"] as? [String:Any] ?? [:])
        self.balanceInquiryModel = BalanceInquiryModel.init(json: json["data"] as? [String:Any] ?? [:])
    }
}
