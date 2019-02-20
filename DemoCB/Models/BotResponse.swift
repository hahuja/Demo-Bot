//
//  BotResponse.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

enum ResponseType {
    case information, greetingCard, defaultCard, noBOT, botInfo, typingLoader
}

struct BotResponse {
    
    //MARK:- Properties
    
    var responseType: ResponseType = .information
    var outputText: String?
    var error: Error?
    
    //MARK:- Initializer
    
    init() { }
    
    init(error: Error) {
        
        self.error = error
        
        if let errorObj = error as? NSError {
            
            if let localizedDescription = errorObj.userInfo[NSLocalizedDescriptionKey] as? String {
                self.outputText = localizedDescription
                return
            }
        }

//        if error.code == 4 {
//            self.outputText = BotConstants.dontRecognize
//        } else {
//            self.outputText = BotConstants.unknown
//        }
    }
    
    static func getResponseTypeForString(_ string: String) -> ResponseType {
        
        switch string {
        case "greeting_card": return .greetingCard
            
        default:
            return .information
        }
    }
}
