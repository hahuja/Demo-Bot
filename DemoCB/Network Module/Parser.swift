//
//  Parser.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation

class Parser {
    
    class func parseErrorWith(response : URLResponse) -> ErrorModel {
        
        let errorModel = ErrorModel.sharedInstance
        
        //        errorModel.apiResponse = "<html>Not Found</html>"
        let url = (response as! HTTPURLResponse).url!
        errorModel.apiUrl = url.absoluteString
        errorModel.httpErrorCode = String(describing:(response as! HTTPURLResponse).statusCode)
        
        if (response as! HTTPURLResponse).statusCode >= 502 {
            errorModel.messageToBeDisplayed = "Servers Temporarily Unavailable"
        }else {
            errorModel.messageToBeDisplayed = "Something went wrong"
        }
        
        return errorModel
    }
    
    class func parseErrorWith(error : Error) -> ErrorModel {
        
        let errorModel = ErrorModel.sharedInstance
        errorModel.messageToBeDisplayed = error.localizedDescription
        
        return errorModel
    }
    
    class func parseChat(data:Data) -> ChatModel {
        let chatModel = ChatModel.sharedInstance
        
        let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
        let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8)
        print(modifiedDataInUTF8Format)
        
        do {
            let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format!)
            print(responseJSONDict)
            
//            chatModel.chatDataArray = (responseJSONDict as AnyObject).value(forKey : "rows") as! Array<Dictionary<String, Any>>
            chatModel.messageDict = (responseJSONDict as AnyObject).value(forKey : "message") as! Dictionary<String, Any>
        } catch {
            print(error)
        }
        print("chatModel.messageDict :\(chatModel.messageDict["message"])")
        return chatModel
    }
}
