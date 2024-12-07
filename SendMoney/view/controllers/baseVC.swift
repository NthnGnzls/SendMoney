//
//  baseVC.swift
//  SendMoney
//
//  Created by Nathan G on 12/5/24.
//

import Foundation
import UIKit

class baseVC: UIViewController{
    
    lazy var loader: AppLoader = {
        let load = AppLoader(frame: UIScreen.main.bounds)
        return load
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showNoInternetAlert(){
        self.hideLoader()
        self.showAlert(title: alertsMessage.internetRequired, message: "", handler: {
            (AlertAction) in
            switch AlertAction{
            case .okButton:
                print("Okay")
            case .cancelButton:
                print("cancel")
            }
        })
    }
    
    func showAlert(title: String , message: String , handler:@escaping(AlertAction)->Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
       
            handler(AlertAction.okButton)
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hideLoader(){
        loader.removeLoader()
    }
    
    func showMainScreen(){
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreen") as UIViewController
        viewController.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            viewController.isModalInPresentation = true // available in IOS13
        }
        self.present(viewController, animated: false, completion: nil)
    }
    func showLoginScreen(){
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as UIViewController
        viewController.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            viewController.isModalInPresentation = true // available in IOS13
        }
        self.present(viewController, animated: false, completion: nil)
    }
}
enum AlertAction{
    case okButton
    case cancelButton
}
