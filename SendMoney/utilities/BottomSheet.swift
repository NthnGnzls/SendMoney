//
//  BottomSheet.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit

class BottomSheet: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
                let label = UILabel()
                label.text = "Successfully sent money!"
                label.textColor = _colors.primaryGreen
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 0
                view.addSubview(label)
                
                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ])
    }
}
