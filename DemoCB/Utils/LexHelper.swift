//
//  LexHelper.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

enum BotState {
    case idle, requesting
}

class LexHelper: NSObject {
    
    private let delayDuration: Double = 0.1
    
    static let helper = LexHelper()
    var botList = [Bot]()
    
    var currentBOT: Bot?
    
    typealias DidGetResponseFromBOT = (BotResponse) -> Void
    var responseBlock: DidGetResponseFromBOT?
    
    typealias OnSendingText = (String) -> Void
    var onSendingText: OnSendingText?
    
    typealias OnSendingImage = (String) -> Void
    var onSendingImage: OnSendingImage?
    
    typealias DidChangeBotState = (BotState) -> Void
    var onChangeBotState: DidChangeBotState?
    
    //MARK:- On initilization
    
    override init() {
        super.init()
        setUpLex()
    }
    
    //MARK:- Private functions
    
    func setUpLex() {
        
    }
    
    //MARK:- Public functions
    
    /*!
     * @discussion : Function in such a way, a query can be passed to chat bot from anywhere or from any screen and chat bot screen will add a cell for query. This will reduce lot of data passing between controllers and classes and reduce more code to write. All the queries will go lex helper and lex helper will revert to chat bot to add cell for query
     
     * @param: rowText is the text which will be visible in cell row for user.
     * @param: actutalText is the text which may be different from visible text that user is viewing but internally is passing to BOT for perticulat goal. For example. "cancel" is the actualText and "Cancel feedback" is rowText. Function aims to show "Cancel feedback" but to send to Bot the text "cancle" which is understable to Bot. if no actualText than rowText will be passed to bot
     * @sessionAttributes: sessionAttributes are additional key-value pairs which can be sent in specific case.
     
     */
    
    class func sendToLex(_ rowText: String, _ uText: String = "", _ sessionAttributes: Dictionary<String, String> = ["platform" : "iOS"]) {
        
        if !APPDELEGATE.isReachable {
            guard let block = LexHelper.helper.responseBlock else { return }
            
            var result = BotResponse()
            result.error = Constants.netError
            result.outputText = Constants.netError.errorDescription
            block(result)
            return
        }
        
        let postText = uText.trimmingCharacters(in: .whitespaces)
        let rText = rowText.trimmingCharacters(in: .whitespaces)
        
        if postText.count != 0 {
            LexHelper.helper.onSendingText?(postText)
        } else {
            LexHelper.helper.onSendingText?(rText)
        }
        
        guard let _ = LexHelper.helper.currentBOT else { return }
        
        if rText.count > 0 {
            // as input text cannot be blank
            print("Input: text: \(String(describing: rText))")
            print("Input: sessionAttributes: \(String(describing: sessionAttributes))")
            LexHelper.helper.onChangeBotState?(.requesting)
        }
    }
    
}
