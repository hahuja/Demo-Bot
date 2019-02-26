//
//  Bot.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

class Bot: NSObject {
    
    var botName = ""
    var displayName = ""
    var botDescription = ""
    var botAlias = ""
    var botVersion = ""
    var chatConfigKey = "chatConfig"
    var identityPoolId = ""
    var avater = ""
    var region = ""
    var options : Array<Any> = ["Would you like me to suggest something to eat?" , "Would you like me to suggest something to shop online?" , "Or are you just bored?"]
    
    class func bot(infoDict: Dictionary<String, Any>) -> Bot {
        
        let info = Bot()
        info.botName = infoDict.stringForKey("botName")
        info.botAlias = infoDict.stringForKey("botAlias")
        info.identityPoolId = infoDict.stringForKey("identityPoolId")
        info.avater = infoDict.stringForKey("avater")
        info.region = infoDict.stringForKey("region")
        info.botDescription = infoDict.stringForKey("botDescription")
        info.displayName = infoDict.stringForKey("displayName")
        
        return info
    }
    
    class func list(array: Array<Dictionary<String, Any>>) -> Array<Bot> {
        var list = [Bot]()
        for item in array {
            list.append(Bot.bot(infoDict: item))
        }
        return list
    }
}
