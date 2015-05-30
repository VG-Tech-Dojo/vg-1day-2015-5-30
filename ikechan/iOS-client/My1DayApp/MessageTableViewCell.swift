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
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    // Mission1-1 UILabel のインスタンス変数を追加
    
    override func prepareForReuse() {
        self.iconImageView.image = nil
        self.messageLabel.text = nil
        self.createdLabel.text = nil
        self.nameLabel.text = nil;
    }
    
    func setupComponentsWithMessage(message: Message) {
        self.iconImageView.image = message.icon
        self.messageLabel.text = message.body
        self.createdLabel.text = message.created_at
        self.nameLabel.text = message.username
    }
}
