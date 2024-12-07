//
//  constants.swift
//  SendMoney
//
//  Created by Nathan G on 12/5/24.
//

import Foundation
import UIKit
typealias resquestCompleted =  (_ status:Int, _ message:String, _ data: Any?, _ error: NSError?)-> Void

class constants: NSObject{
    static let BASE_URL =  "http://demo4087150.mockable.io/"
    static let PATH_LOGIN = "maya-login"
    static let PATH_NEWS = "news"
    static let PATH_SEND_MONEY = "send_money"
    static let PATH_TRANSACTIONS = "transaction_history"
    static let PATH_BALANCE_INQUIRY = "balanceInquiry"
}

struct _colors {
    static let primaryGreen: UIColor = UIColor(red: 0.0/255.0, green: 239.0/255.0, blue: 152.0/255.0, alpha: 1.0)
    static let primaryBlack: UIColor = UIColor(red: 36.0/255.0, green: 37.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    
}
struct userDefaultsID{
    static let fname = "fname"
    static let lname = "lname"
    static let offlineHistory = "offlineHistory"
}

struct alertsMessage{
    static let internetRequired = "An internet connection is required."
    static let invalidCredentials = "Username/Password is incorrect"
    static let logout = "Are you sure you want to log out?"
   
}
