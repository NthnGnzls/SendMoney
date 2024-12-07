//
//  profileVC.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//
import UIKit
class profileVC: baseVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func logout(_ sender: Any) {
        let defaults = UserDefaults.standard
            for (key, _) in defaults.dictionaryRepresentation() {
                defaults.removeObject(forKey: key)
            }
        showLoginScreen()
    }
}
