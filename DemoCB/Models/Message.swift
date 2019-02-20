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
    init(text: String, owner: MessageOwner, timestamp: Int, cardType : CardType = .general) {
        self.text = text
        self.subTitle = ""
        self.owner = owner
        self.timestamp = timestamp
        self.cardType = .general
    }
    
    class func getMessages(botResponse: BotResponse) -> Array<Message> {
        
        var messages = [Message]()
        let message = Message.getBasicInfoMessage(botResponse: botResponse)
        messages.append(message)
        
        return messages
    }
    
    class func getBasicInfoMessage(botResponse: BotResponse) -> Message {
        
        let message = Message(text: "I am BOT.", owner: .bot, timestamp: Int(Date().timeIntervalSince1970), cardType: .general)
        
        message.text = "No reply from bot"
        
        return message
    }

}
