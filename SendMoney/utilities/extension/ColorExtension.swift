//
//  ColorExtension.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//
import UIKit
extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    static func random() -> UIColor {
        return UIColor(red:   .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue:  .random(in: 0...1),
                       alpha: 1.0)
    }
}
