//
//  ChatBotResponseHandler.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

extension ChatBotVC : ChatDelegate {
    
    
    func didReceiveResponseFor(chatModel: ChatModel?, errorModel: ErrorModel?) {
        if (errorModel != nil) {
            print("Show some error message")
            let alert = UIAlertController(title: "Error", message: "\(String(describing: errorModel!.messageToBeDisplayed))", preferredStyle: UIAlertController.Style.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (errorModel == nil) && (chatModel == nil) {
            let alert = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            print("Update UI")
            guard let block = LexHelper.helper.responseBlock else {
                return
            }
            
            var result = BotResponse()
            result.outputText = chatModel!.messageDict["message"] as? String
            self.removeLoaderMessages()
            block(result)
            return
        }
        self.removeLoaderMessages()
//        helper.removeActivityIndicator(view: self.view)
    }
    
    
    func handleBOTResponse() {
        
        let helper = LexHelper.helper
        helper.onSendingText = { (text) in
            let message = Message.init(text: text, owner: .sender, timestamp: Int(Date().timeIntervalSince1970), cardType: .generalSender)
            message.cardType = .generalSender
            self.addMessage(message)
            self.inputTextField.text = ""
            self.textFieldDidChange(self.inputTextField)
        }
        
        helper.onChangeBotState = { (state) in
            if (state == BotState.requesting) {
                self.sendButton.isEnabled = false
                self.sendButton.alpha = 0.7
                self.addLoaderMessage()
            } else {
                self.sendButton.isEnabled = true
                self.sendButton.alpha = 1.0
                self.removeLoaderMessages()
            }
        }
        
        helper.responseBlock = { (result) in
            
            if let text = result.outputText {
                
                if result.responseType == .information {
                    self.addMessages(Message.getMessages(botResponse: result))
                } else if text == BotConstants.dontRecognize {
                    self.composeMessageFromBOT(text)
                } else {
                    self.composeMessageFromBOT(text)
                }
            }
        }
        
        
    }
    
    func addLoaderMessage() {
        let loadingMessages = items.filter { (message) -> Bool in
            message.cardType == .typingLoader
        }
        
        if loadingMessages.count != 0 {
            for msg in loadingMessages {
                if let idx = self.items.index(of: msg) {
                    self.items.remove(at: idx)
                }
            }
        }
        self.addMessage(Message.getTypingLoaderMessage())
    }
    
    func removeLoaderMessages() {
        let loadingMessages = items.filter { (message) -> Bool in
            message.cardType == .typingLoader
        }
        
        if loadingMessages.count != 0 {
            for msg in loadingMessages {
                if let idx = self.items.index(of: msg) {
                    self.items.remove(at: idx)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    func composeMessageFromBOT(_ text: String) {
        let message = Message.init(text: text, owner: .bot, timestamp: Int(Date().timeIntervalSince1970))
        addMessage(message)
    }
    
    func addMessages(_ messages: Array<Message>) {
        
        if messages.count == 0 {
            return
        }
        
        items.append(contentsOf: messages)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.tableView.tableViewScrollToBottom(animated: true)
    }
    
    func addMessage(_ message: Message) {
        addMessages([message])
    }
    
    func removeMessage(_ message: Message) {
        if let index = self.items.index(of: message) {
            self.items.remove(at: index)
            self.tableView.reloadData()
        }
    }
    
    
}

