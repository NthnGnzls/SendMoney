//
//  Untitled.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit
class transactionVC: baseVC{
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = TransactionVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTransactionHistory()
    }
    
    func getTransactionHistory(){
        if Reachability.isConnectedToNetwork(){
            let jsonDat: [String:Any] = [:]
            viewModel.getTransactions(){[weak self] (status, message,data, error) in
                if error != nil{
                    self?.showAlert(title: "", message: "Failed to connect to server. Please try again after a few minutes\(String(describing: error?.localizedDescription))", handler: { (ok) in
                        self?.hideLoader()
                    })
                }else{
                    if status != 100{
                        self?.showAlert(title: "", message: "Failed to connect to server. Please try again after a few minutes ", handler: { (ok) in
                            self?.hideLoader()
                        })
                    }else{
                        self?.hideLoader()
                        self?.tableView.reloadData()
                    }
                }
                self?.hideLoader()
            }
        }else{
            showNoInternetAlert()
        }
    }
}
extension transactionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactionHistoryModel?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell else { return UITableViewCell() }
        
        cell._data = viewModel.transactionHistoryModel?.transactions[indexPath.row]
        
        return cell
    }
}
