//
//  TransactionTableViewCell.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit
import Nuke
class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var receipientName: UILabel!
    @IBOutlet weak var refNo: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    var _data: Transactions?{
        didSet{
            self.date.text = _data?.date ?? ""
            self.amount.text = String(describing: "\(_data?.amount ?? 0.0)")
            self.refNo.text = _data?.ref_num ?? ""
            self.receipientName.text = _data?.title ?? ""
        }
    }
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
