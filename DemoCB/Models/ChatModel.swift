//
//  ChatModel.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
public class ChatModel : NSObject {
    
    private override init() { }
    
    static let sharedInstance = ChatModel()
    
    var chatDataArray : Array<Dictionary<String,Any>> = []
    var messageDict : Dictionary<String,Any> = [:]
    var multiMediaArray : Array<Dictionary<String,Any>> = []
}
