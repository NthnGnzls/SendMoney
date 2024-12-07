//
//  AppLoader.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//


import Foundation
import UIKit
import NVActivityIndicatorView

class AppLoader: UIView{
    let labelIndicator : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        //label.backgroundColor = .blue
        //label.textColor = UIColor.darkGray
        return label
    }()
    let ivLogo : UIImageView = {
       let gifImageCache = NSCache<NSString,AnyObject>()
       let iv = UIImageView()
        //insert loader icon here
        if let gifimage = gifImageCache.object(forKey: "") as? UIImage {
            iv.image = gifimage
        }
        else {
            iv.image = UIImage.gifImageWithName("")
            if let image = iv.image {
                gifImageCache.setObject(image, forKey: "")
            }
        }
        iv.layer.cornerRadius  = 35
        iv.layer.masksToBounds = true
        return iv
    }()

    let viewHolder: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.5)
        return v
    }()
    
    fileprivate func setupActivityIndicator(_ frame: CGRect) {
        //Set lineWidth to 6 in NVActivityIndicatorShape class
        //Set duration to 0.3 in NVActivityIndicatorAnimationBallClipRotate class
        let activityIndicatorView  = NVActivityIndicatorView(frame: frame, type: .ballClipRotate, color: UIColor.rgb(red: 132, green: 189, blue: 0, alpha: 1.0), padding: self.frame.width / 3)
        activityIndicatorView.padding = self.frame.width - 3
        viewHolder.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    fileprivate func setupLogo() {
        
        ivLogo.frame = CGRect(x: viewHolder.frame.size.width/2-40, y: viewHolder.frame.size.height/2-40, width: 80, height: 80)
        viewHolder.addSubview(ivLogo)
        ivLogo.center = viewHolder.center
        
        // V stands for vertical
        // : means visual format
        // [] container object
        // v means views
        // v'0'- index of item
        // v'()' - size container
        // '-' margin
        // || means  superview
        
//        viewHolder.addConstraintsWithFormat(format: "V:[v0(70)]", views: ivLogo)
//        viewHolder.addConstraintsWithFormat(format: "H:[v0(70)]", views: ivLogo)
//        ivLogo.center = viewHolder.center
//
//        //viewHolder  mag aad ka ng marging
//        viewHolder.addConstraint(NSLayoutConstraint.init(item: ivLogo, attribute: .centerX, relatedBy: .equal, toItem: viewHolder, attribute: .centerX, multiplier: 1, constant: 0))
//        viewHolder.addConstraint(NSLayoutConstraint.init(item: ivLogo, attribute: .centerY, relatedBy: .equal, toItem: viewHolder, attribute: .centerY, multiplier: 1, constant: 0))
       
        
    }
    
//    fileprivate func setupLabelIndicator() {
//        viewHolder.addSubview(labelIndicator)
//        viewHolder.addConstraintsWithFormat(format: "V:[v0]-25-[v1]", views: ivLogo,labelIndicator)
//        viewHolder.addConstraintsWithFormat(format: "H:|[v0]|", views:labelIndicator) //buong width/ horizontal view same with viewholder
//        viewHolder.addConstraint(NSLayoutConstraint.init(item: ivLogo, attribute: .centerX, relatedBy: .equal, toItem: viewHolder, attribute: .centerX, multiplier: 1, constant: 0))
//        labelIndicator.text = ""
//    }
    
    func removeLoader(){
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
//     init(vc: UIViewController) {
//        super.init(frame: vc.view.frame)
//        vc.view.addSubview(self)
//        addSubview(viewHolder)
//        viewHolder.frame = vc.view.frame
//        //setupActivityIndicator(frame)
//        setupLogo()
//        //setupLabelIndicator()
//    }
//    public static let shared
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(viewHolder)
        viewHolder.frame = frame
        setupActivityIndicator(frame)
        //setupLogo()
        //setupLabelIndicator()
    }
    
    
    static let shared =  AppLoader()
//    func animate(){
//        self.addSubview(viewHolder)
//        viewHolder.frame = self.frame
//        //setupActivityIndicator(frame)
//        setupLogo()
//        //setupLabelIndicator()
//    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder not initialize.")
    }
    
    
}


