//
//  LoginVM.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//


import UIKit
import RxSwift
import RxRelay
class LoginVM: NSObject {
    var loginModel: LoginModel?
    var tfUsername = BehaviorRelay<String>(value: "")
    var tfPassword = BehaviorRelay<String>(value: "")
    var charCountValid: Observable<Bool>{
        return Observable.combineLatest(tfUsername.asObservable(), tfPassword.asObservable()){ uname, password in
            uname.count >= 3 && password.count >= 3
        }
    }
    
    func loginService(loginObj:[String:AnyObject],_ completed: @escaping resquestCompleted){
        APIHandler.shared.post(request: .login,parameters: loginObj) { status, message, data, error in
    
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
                        
                        guard let model =  generic.loginModel else{
                            return completed(status , "An error occured. Please try again (203)", data , nil)
                        }
                        self.loginModel = model
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
