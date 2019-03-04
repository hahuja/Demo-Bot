//
//  Message.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation


import UIKit
import CoreLocation
import MapKit

class Message: NSObject {
    
    //MARK: Properties
    var text: String
    var subTitle: String
    var owner: MessageOwner
    var cardType: CardType
    
    var timestamp: Int
    var listItems: Array<Any> = []
    var objectItem: Dictionary<String, AnyObject>?
    var messageImage : UIImage?
    var userLocation : CLLocation?
    
    var timeAgo: String {
        get {
            //let messageDate = Date.init(timeIntervalSince1970: TimeInterval(timestamp))
            return ""//messageDate.timeAgo
        }
    }
    
    //MARK: Init
    init(text: String, owner: MessageOwner, timestamp: Int, cardType : CardType = .generalBOT) {
        self.text = text
        self.subTitle = ""
        self.owner = owner
        self.timestamp = timestamp
        self.cardType = .generalBOT
    }
    
    class func getMessages(botResponse: BotResponse) -> Array<Message> {
        
        var messages = [Message]()
        let message = Message.getBasicInfoMessage(botResponse: botResponse)
        messages.append(message)
        let cardTypeStr = String(describing: message.cardType)
        CoreDataInput.saveMessage(text: message.text, timeStamp: Int(Date().timeIntervalSince1970), cardType: cardTypeStr)
        
        
        return messages
    }
    
    class func getBasicInfoMessage(botResponse: BotResponse) -> Message {
        
        let message = Message(text: "I am BOT.", owner: .bot, timestamp: Int(Date().timeIntervalSince1970), cardType: .generalBOT)
        message.text = botResponse.outputText!
        
        return message
    }
    
    class func getHelloMessageFromBOT() -> Message {
        let message = Message(text: "Hi there, What would you like me to do today?", owner: .bot, timestamp: Int(Date().timeIntervalSince1970), cardType: .generalBOT)
        message.cardType = .generalBOT
        let cardTypeStr = String(describing: message.cardType)
        CoreDataInput.saveMessage(text: message.text, timeStamp: Int(Date().timeIntervalSince1970), cardType: cardTypeStr)
        return message
    }
    
    class func getTypingLoaderMessage() -> Message {
        let message = Message(text: "Bot is typing..", owner: .bot, timestamp: Int(Date().timeIntervalSince1970), cardType: .typingLoader)
        message.cardType = .typingLoader
        return message
    }

}
