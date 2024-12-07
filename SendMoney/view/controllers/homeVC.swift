//
//  homeVC.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//
import UIKit
class homeVC: baseVC{
    
    @IBOutlet weak var btnShowBalance: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnViewHistory: UIButton!
    @IBOutlet weak var btnSendMoney: UIButton!
    @IBOutlet weak var labelBalance: UILabel!
    var viewModel = HomeVM()
    var isTextHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNews()
        self.getBalance()
       
    }
    
    @IBAction func hideShowBalance(_ sender: Any) {
        toggleTextVisibility()
    }
    
    @IBAction func sendMoney(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func viewHistory(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
 
    func setupViews(){
        self.tableView.estimatedRowHeight = 190
        self.tableView.separatorStyle = .none
    }
    func toggleTextVisibility() {
        if isTextHidden {
            hideTextWithAsterisks()
        } else {
            labelBalance.text = self.viewModel.balanceInquiryModel?.current_balance ?? "0.00"
        }
        isTextHidden.toggle()  // Toggle the state
    }
    func hideTextWithAsterisks() {
        guard let originalText = labelBalance.text else { return }
            let asteriskText = String(repeating: "*", count: originalText.count)
        labelBalance.text = asteriskText
        }
    
    func getNews(){
        if Reachability.isConnectedToNetwork(){
            let jsonDat: [String:Any] = [:]
            viewModel.getNews(){[weak self] (status, message,data, error) in
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
                        self?.tableView.reloadData()
                    }
                }
                self?.hideLoader()
            }
        }else{
            showNoInternetAlert()
        }
    }
    
    func getBalance(){
        if Reachability.isConnectedToNetwork(){
            let jsonDat: [String:Any] = [:]
            viewModel.getBalance(){[weak self] (status, message,data, error) in
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
                        self?.labelBalance.text = self?.viewModel.balanceInquiryModel?.current_balance ?? "0.00"
                        self?.hideTextWithAsterisks()
                    }
                }
                self?.hideLoader()
            }
        }else{
            showNoInternetAlert()
        }
    }
}

extension homeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsModel?.newsFeed.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as? newsTableViewCell else { return UITableViewCell() }
        
        cell._data = viewModel.newsModel?.newsFeed[indexPath.row]
        
        return cell
    }
    
    
}
