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
    @IBOutlet weak private var dateLabel: UILabel!
    // Mission1-1 UILabel のインスタンス変数を追加
    
    override func prepareForReuse() {
        self.iconImageView.image = nil
        self.messageLabel.text = nil
        self.dateLabel.text = nil
        // Mission1-1 UILabel のインスタンス変数を初期化
    }
    
    func setupComponentsWithMessage(message: Message) {
        self.iconImageView.image = message.icon
        self.messageLabel.text = message.body
        self.dateLabel.text = message.date
        // Mission1-1 UILabel のインスタンス変数に created_at の値を代入
    }
}
