//
//  HomeVM.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit
class HomeVM: NSObject {
    var newsModel: NewsModel?
    var balanceInquiryModel: BalanceInquiryModel?
    
    func getNews(_ completed: @escaping resquestCompleted){
        APIHandler.shared.get(request: .news,parameters: ["":""]) { status, message, data, error in
    
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
                        
                        guard let model =  generic.newsModel else{
                            return completed(status , "An error occured. Please try again (203)", data , nil)
                        }
                        self.newsModel = model
                        completed(status, message, data, nil)
                    }
                }
            }
            
        }
        
    }
    
    func getBalance(_ completed: @escaping resquestCompleted){
        APIHandler.shared.get(request: .balanceInquiry,parameters: ["":""]) { status, message, data, error in
    
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
                        
                        guard let model =  generic.balanceInquiryModel else{
                            return completed(status , "An error occured. Please try again (203)", data , nil)
                        }
                        self.balanceInquiryModel = model
                        completed(status, message, data, nil)
                    }
                }
            }
            
        }
        
    }
}
