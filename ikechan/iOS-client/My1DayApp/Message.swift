//
//  Message.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/05/15.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

class Message {
    let body: String!
    let icon: UIImage?
    let created_at: String!
    let username: String!
    
    init?(dictionary: [String: AnyObject]) {
        if let body: String = dictionary["body"] as? String, let icon: String = dictionary["icon"] as? String, let created_at: String = dictionary["created_at"] as? String, let username: String = dictionary["username"] as? String {
            self.body = body
            self.icon = ImageHelper.imageWithBase64EncodedString(icon)
            self.created_at = created_at
            self.username = username;
        } else {
            self.body = nil
            self.icon = nil
            self.created_at = nil
            self.username = nil
            
            return nil
        }
    }
}
