//
//  sendMoneyVC.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit
class sendMoneyVC: baseVC{
    
    @IBOutlet weak var tfInput: UITextField!
    var viewModel = SendMoneyVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfInput.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func sendMoney(_ sender: Any) {
        self.sendMoney()
    }
    func sendMoney(){
        if Reachability.isConnectedToNetwork(){
            let jsonDat: [String:Any] = [:]
            viewModel.sendMoney(){[weak self] (status, message,data, error) in
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
                        self?.showBottomSheet()
                        self?.hideLoader()
                    }
                }
                self?.hideLoader()
            }
        }else{
            showNoInternetAlert()
        }
    }
    
    func showBottomSheet(){
        let bottomSheetVC = BottomSheet()
                if let sheet = bottomSheetVC.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.prefersGrabberVisible = true
                }
                present(bottomSheetVC, animated: true, completion: nil)
    }
}

extension sendMoneyVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let allowedCharacters = "0123456789."
               let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
               let characterSet = CharacterSet(charactersIn: string)
               
               // Check if the input is valid
               if !allowedCharacterSet.isSuperset(of: characterSet) {
                   return false
               }
               
               // Prevent multiple decimal points
               if string == ".", textField.text?.contains(".") == true {
                   return false
               }
        return true
       }
}
