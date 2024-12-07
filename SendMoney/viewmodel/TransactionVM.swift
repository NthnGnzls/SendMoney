//
//  TransactionVM.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit
class TransactionVM: NSObject {
    var transactionHistoryModel: TransactionHistoryModel?
    
    func getTransactions(_ completed: @escaping resquestCompleted){
        APIHandler.shared.post(request: .login,parameters: ["":""]) { status, message, data, error in
    
            if error != nil{
                completed(status, message, data, error)
            }else{
                if status != 100{
                    completed(status, message, data, nil)
                }else{
                    if status != 100{
                        completed(status, message, data, nil)
                    }else{
                        guard let generic = data as? GenericModel else{
                            return completed(status , "An error occured. \(message) Please try again", data , nil)
                        }
                        
                        guard let model =  generic.transactionHistoryModel else{
                            return completed(status , "An error occured. Please try again (203)", data , nil)
                        }
                        self.transactionHistoryModel = model
                        if let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {

                            UserDefaults.standard.set(encodedObject, forKey: userDefaultsID.offlineHistory)
                        }
                        
                        completed(status, message, data, nil)
                    }
                }
            }
            
        }
        
    }
}
