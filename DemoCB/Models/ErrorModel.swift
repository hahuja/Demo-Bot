//
//  ErrorModel.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
public class ErrorModel : NSObject {
    
    private override init() { }
    
    static let sharedInstance = ErrorModel()
    
    var apiResponse : String = ""
    var apiUrl : String = ""
    var httpErrorCode : String = ""
    var messageToBeDisplayed : String = ""
    
}
