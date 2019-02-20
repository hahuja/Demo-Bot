//
//  MessageConstants.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

struct BotConstants {
    static let dontRecognize = "Sorry, I am not able to assist at this time"
    static let unknown = "Sorry, Unknown error occured"
}

enum CardType {
    case generalSender, generalBOT, typingLoader
}

enum HorizontalSubType {
    case imageOnly, textOnly, imageWithText
}

enum MessageOwner {
    case sender, bot
}

struct ChatBotCellId {
    static let generalSenderCell                = "SenderMessageCell"
    static let generalBOTCell                   = "BOTMessageCell"
    static let typingLoaderCell                 = "TypingLoaderCell"
    
//    static let generalImageSenderCell           = "SRImageSenderMessageCell"
//    static let generalImageBOTCell              = "SRImageBOTMessageCell"
//    
    
//    static let horizontalCardImageBOTCell       = "SRHorizontalImageTableCell"
//    static let horizontalCardTextBOTCell        = "SRHorizontalTextTableCell"
//    static let dateCardBOTCell                  = "SRDatePickerTableCell"
//    static let pickerCardBOTCell                = "SRPickerTableCell"
//    
//    static let verticalOptionsCardBOTCell       = "SRVerticalOptionsTableCell"
//    static let verticalImageOptionsCardBOTCell  = "SRVerticalImageAndOptionsTableCell"
//    static let addCommentsCell                  = "SRAddCommentsCell"
//    static let mapViewCell                      = "SRMapTableViewCell"
}
