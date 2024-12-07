//
//  NewsModel.swift
//  SendMoney
//
//  Created by Nathan G on 12/8/24.
//

import UIKit

class NewsModel: NSObject, NSCoding{
    var newsFeed = [NewsFeed]()
    
    func encode(with coder: NSCoder) {
        coder.encode(newsFeed, forKey: "newsFeed")
       
    }
    
    required init?(coder: NSCoder) {
        self.newsFeed = coder.decodeDouble(forKey: "news_feed") as? [NewsFeed] ?? []
       
    }
    
    init(json: [String:Any]){
        for item in json["news_feed"] as? [[String:Any]] ?? []{
            self.newsFeed.append(NewsFeed.init(json: item))
        }
    }
    
}

class NewsFeed: NSObject{
    var id: Int?
    var title: String?
    var desc: String?
    var img_url: String?
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(desc, forKey: "description")
        coder.encode(img_url, forKey: "img_url")
       
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeInteger(forKey: "id")
        self.title = coder.decodeObject(forKey: "title") as? String ?? ""
        self.desc = coder.decodeObject(forKey: "desccription") as? String ?? ""
        self.img_url = coder.decodeObject(forKey: "img_url") as? String ?? ""
       
    }
    
    init(json: [String:Any]){
        self.id = json["id"] as? Int ?? 0
        self.title = json["title"] as? String ?? ""
        self.desc = json["description"] as? String ?? ""
        self.img_url = json["img_url"] as? String ?? ""
    }
}
/*
 "news_feed": [
             {
                 "id": 0,
                 "title": "News one",
                 "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                 "img_url": "https://www.maya.ph/hubfs/Maya%20Credit%20Blogs%20Image/How%20Your%20Maya%20Credit%20Card%20Can%20Be%20a%20Part%20of%20Your%20Broader%20Personal%20Financial%20Strategy/shutterstock_1299402838.jpg"
             },
 */
