//
//  ServiceManager.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation

class ServiceManager: NSObject, URLSessionDelegate {
    
    func getDataForChat(textMessage : String, withCompletionHandler completionHandler: @escaping (_ chatModel: ChatModel?, _ errorModel: ErrorModel?) -> Void) {
        
        let networkStatus = APPDELEGATE.isReachable
        if networkStatus == true {
            
            let request:URLRequest = ServiceHelper.getRequestObjectForChat(textMessage: textMessage) as URLRequest
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    
                    let errorModel : ErrorModel = Parser.parseErrorWith(error: error!)
                    completionHandler(nil,errorModel)
                    
                }
                else {
                    
                    if (response as! HTTPURLResponse).statusCode == 200 {
                        let chatModel : ChatModel = Parser.parseChat(data: data!)
                        completionHandler(chatModel, nil)
                    }else {
                        //Some Other Error
                        let errorModel : ErrorModel = Parser.parseErrorWith(response: response!)
                        completionHandler(nil,errorModel)
                    }
                }
            }
            task.resume()
        }else {
            print("No Internet")
            completionHandler(nil,nil)
        }
    }
}
