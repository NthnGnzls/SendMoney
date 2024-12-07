//
//  newsTableViewCell.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//


import UIKit
import Nuke
class newsTableViewCell: UITableViewCell {
    
    var _data: NewsFeed?{
        didSet{
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: ""),
                failureImage: UIImage(named: "")
            )
            
            self.lblTitle.text = _data?.title ?? ""
            self.lblDescription.text = _data?.desc ?? ""
            Nuke.loadImage(with: URL(string: self._data?.img_url ?? "")!, options: options, into: self.imgBackground)
        }
    }
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
