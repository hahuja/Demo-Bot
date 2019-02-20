//
//  ServiceHelper.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation

class ServiceHelper {
    
    static let urlRoute = "https://www.personalityforge.com/api/chat/"
    
    class func getRequestObjectForChat(textMessage : String) -> URLRequest {
        var url = URLComponents(string: "\(urlRoute)")!
        url.queryItems = [
            URLQueryItem(name: "apiKey", value: "6nt5d1nJHkqbkphe"),
            URLQueryItem(name: "chatBotID", value: "63906"),
            URLQueryItem(name: "externalID", value: "Humpty"),
            URLQueryItem(name: "message", value: "\(textMessage)")
        ]
        var urlRequest = URLRequest(url: url.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
        
    }
}
