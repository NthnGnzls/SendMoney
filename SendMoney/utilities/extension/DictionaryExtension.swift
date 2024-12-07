//
//  DictionaryExtension.swift
//  SendMoney
//
//  Created by Nathan G on 12/7/24.
//

import Foundation
extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: .prettyPrinted) else {
                                                                return nil
        }
        guard  let prettyPrintedString = String(data: theJSONData, encoding: .init(rawValue: String.Encoding.utf8.rawValue)) else { return "" }
        return prettyPrintedString
    }
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }

}
