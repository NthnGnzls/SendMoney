//
//  APIHandler.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//


import UIKit
import Alamofire
public enum RequestType {
    case login
    case news
    case sendMoney
    case transactionHistory
    case balanceInquiry
}
enum NetworkError: Error {
    case unauthorized
    case serverError
    case badRequest
}
class APIHandler: NSObject {	
    static let shared = APIHandler()
    private let requestTimeOut = 10.0 // In Seconds
    fileprivate func urlBuilder(_ request: RequestType, _ url: inout String?,tailURL:String? = "") {
        switch request {
        case .login:
            url = constants.BASE_URL + constants.PATH_LOGIN
        case .news:
            url = constants.BASE_URL + constants.PATH_NEWS
        case .sendMoney:
            url = constants.BASE_URL + constants.PATH_SEND_MONEY
        case .transactionHistory:
            url = constants.BASE_URL + constants.PATH_TRANSACTIONS
        case .balanceInquiry:
            url = constants.BASE_URL + constants.PATH_BALANCE_INQUIRY
        default:
            print("default")
        }					
    }
   
    fileprivate func logRequest(_ url: String?, _ headers: HTTPHeaders?, _ parameters: Parameters) {
        print("\n\n\nPOST REQUEST --- \nURL \(url ?? "Not available") \n\n HEADER VALUE - \n\(headers ?? [:]) \n with Params --- \n\n \(parameters.prettyPrintedJSON ?? "") \n ---- \n\n\n")
    }
    
    func post(request: RequestType, parameters: Parameters, handler:@escaping resquestCompleted) {
        let headers:HTTPHeaders = ["content-type":"application/json"]
           var url : String?
           urlBuilder(request, &url)
           logRequest(url, headers, parameters)
        AF.request(url ?? "", method: .post, parameters: ["":""] , encoding: JSONEncoding.default, headers: headers).responseJSON { response in
               switch response.result{
               case .success:
                   guard let httpCode = response.response?.statusCode else{
                       return handler( 0 , "Unable to read response code. \n Please try again later." , nil, nil)
                   }
                   switch httpCode{
                   case 200:
                       guard let responseDict = response.value as? [String: Any] else{ return handler(5, "Serialization Error" , nil, nil)}
                       let genericResponse = GenericModel.init(json: responseDict)
                       return handler(
                           100,
                           "\(genericResponse.message ?? "") (\(String(describing: genericResponse.status ?? 0)))",
                           genericResponse,
                           nil
                       )
                    
                   case 401:
                       return handler(401, "Something went wrong." , nil, NSError.init(domain: "The request did not include an authentication token or the authentication token was expired.", code: httpCode, userInfo: nil))
                    
                   default:
                       return handler(httpCode, "Something went wrong." , nil, nil)
                   }
            
               case .failure(let error as NSError):
                   if let afError = error as? AFError {
                       switch afError {
                       case .sessionTaskFailed(let sessionTaskError):
                           print("HTTP Status Code: \(sessionTaskError._code)")
                           if sessionTaskError._code == NSURLErrorTimedOut {
                               let errorContent = "\n POST REQUEST1 --- \nURL \(url ?? "Not available")\n with Params --- \n\n \(parameters.prettyPrintedJSON ?? "") \n ---- \n \(error)"
                               
                           }
                       default:                           print("Other Alamofire Error: \(afError)")
                       }
                   }
                   return handler( response.response?.statusCode ?? 0 , "" , nil, error)
                    
               default:
                   return handler(500, "Failed to fetch data from database" , nil, nil)
               }
           }
       }
   
    
    func get(request: RequestType , parameters: Parameters, handler:@escaping resquestCompleted) {
        let headers:HTTPHeaders = ["content-type":"application/json"]
        var url : String?
        urlBuilder(request, &url)
        logRequest(url, headers, parameters)
        AF.request(url ?? "", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result{
               case .success:
                   guard let httpCode = response.response?.statusCode else{
                       return handler( 0 , "Unable to read response code. \n Please try again later." , nil, nil)
                   }
                   switch httpCode{
                   case 200:
                       let responseDict = response.value as? [String: Any] ?? [:]
                       let genericResponse = GenericModel.init(json: responseDict)
                       handler(
                           100,
                           "\(genericResponse.message ?? "") (\(String(describing: genericResponse.status ?? 0)))",
                           genericResponse,
                           nil
                       )
                    
                   case 401:
                       return handler(401, "Something went wrong." , nil, NSError.init(domain: "The request did not include an authentication token or the authentication token was expired.", code: httpCode, userInfo: nil))
                    
                   default:
                       return handler(httpCode, "Something went wrong." , nil, nil)
                   }
            
               case .failure(let error as NSError):
                if let afError = error as? AFError {
                    switch afError {
                    case .sessionTaskFailed(let sessionTaskError):
                        if sessionTaskError._code == NSURLErrorTimedOut {
                            let errorContent = "\n GET REQUEST --- \nURL \(url ?? "Not available")\n with Params --- \n\n \(parameters.prettyPrintedJSON ?? "") \n ---- \n \(error)"
                        
                        }
                    default:
                        // Handle other types of AFError if needed
                        print("Other Alamofire Error: \(afError)")
                    }
                }
                   return handler( response.response?.statusCode ?? 0 , "" , nil, error)
                    
               default:
                   return handler(500, "Something went wrong." , nil, nil)
               }
        }
    }
 
    
}
