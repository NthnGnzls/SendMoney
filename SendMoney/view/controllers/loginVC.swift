//
//  loginVC.swift
//  SendMoney
//
//  Created by Nathan G on 12/5/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
class loginVC: baseVC{
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var viewModel = LoginVM()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = tfUsername.rx.text.map{ $0 ?? "" }.bind(to: viewModel.tfUsername)
        _ = tfPassword.rx.text.map{ $0 ?? "" }.bind(to: viewModel.tfPassword)
        _ = viewModel.charCountValid.subscribe(onNext: {
            [weak self] charCountValid in
            self?.btnLogin.backgroundColor = charCountValid ? _colors.primaryGreen : .systemGray
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func btnLogin(_ sender: Any) {
        if viewModel.tfUsername.value == "johntestaccount" && viewModel.tfPassword.value == "password#1"{
            submitLogin()
        }else{
            self.showAlert(title: "Please try again", message: alertsMessage.invalidCredentials, handler: { (ok) in
                self.hideLoader()
            })
        }
    }
    
    func submitLogin(){
        if Reachability.isConnectedToNetwork(){
            let jsonDat: [String:Any] = [:]
            viewModel.loginService(loginObj: [:]){[weak self] (status, message,data, error) in
                if error != nil{
                    self?.showAlert(title: "", message: "Failed to connect to server. Please try again after a few minutes\(error?.localizedDescription)", handler: { (ok) in
                        self?.hideLoader()
                    })
                }else{
                    if status != 100{
                        self?.showAlert(title: "", message: "Failed to connect to server. Please try again after a few minutes ", handler: { (ok) in
                            self?.hideLoader()
                        })
                    }else{
                        self?.hideLoader()
                        self?.showMainScreen()
                    }
                }
                self?.hideLoader()
            }
        }else{
            showNoInternetAlert()
        }
    }
    
    
}
