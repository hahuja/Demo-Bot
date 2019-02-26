//
//  ChatBotCellLoadExtension.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

extension ChatBotVC {
    
    func cellType(_ indexPath: IndexPath) -> UITableViewCell {
        
        let message = self.items[indexPath.section]
        
        switch message.cardType {
            
        case .generalSender:
            let cellId = ChatBotCellId.generalSenderCell
            return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SenderMessageCell
            
        case .generalBOT:
            let cellId = ChatBotCellId.generalBOTCell
            return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BOTMessageCell
            
        case .typingLoader:
            let cellId = ChatBotCellId.typingLoaderCell
            return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TypingLoaderCell
        
        }
    }
    
    func setupTableView() {
        registerCells()
        self.tableView.estimatedRowHeight = self.barHeight
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.contentInset.bottom = self.barHeight
        self.tableView.scrollIndicatorInsets.bottom = self.barHeight
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "TypingLoaderCell", bundle: nil), forCellReuseIdentifier: ChatBotCellId.typingLoaderCell)
    }
    
    func setupInputBar() {
        
        inputTextField.setLeftPaddingPoints()
        self.sendButton.isEnabled = false
        let lightGrayImg = self.sendButton.imageView!.image!.color(color: UIColor.lightGray)
        self.sendButton.setImage(lightGrayImg, for: .normal)
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
}


