//
//  SendMoneyModel.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit
class SendMoneyModel: NSObject{
    var message: String?
    
    init(json: [String:Any]){
        self.message = json["message"] as? String ?? ""
    }
}
