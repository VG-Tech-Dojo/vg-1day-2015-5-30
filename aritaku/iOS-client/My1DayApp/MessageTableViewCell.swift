//
//  MessageTableViewCell.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/04/24.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var username: UILabel!
    @IBOutlet weak private var date: UILabel!
    // Mission1-1 UILabel のインスタンス変数を追加
    var id:Int!
    
    override func prepareForReuse() {
        self.iconImageView.image = nil
        self.messageLabel.text = nil
        self.username.text = nil
        self.date.text = nil
        // Mission1-1 UILabel のインスタンス変数を初期化
        self.id = nil
    }
    
    func setupComponentsWithMessage(message: Message) {
        self.iconImageView.image = message.icon
        self.messageLabel.text = message.body
        self.username.text = message.userName
        self.date.text = message.date
        // Mission1-1 UILabel のインスタンス変数に created_at の値を代入
        self.id = message.id
    }
}
