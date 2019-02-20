//
//  Helper.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 20/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

protocol ChatDelegate : class {
    func didReceiveResponseFor(chatModel : ChatModel? , errorModel : ErrorModel?)
    
}

class Helper {
    
    weak var chatDelegate: ChatDelegate?
    
    let serviceManager = ServiceManager()
    
    func addActivityIndicator(view: UIView) -> Void {
        
        let activityView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityView.center = view.center
        activityView.startAnimating()
        view.addSubview(activityView)
    }
    
    func removeActivityIndicator(view:UIView) -> Void {
        
        for subView:UIView in view.subviews {
            if(subView is UIActivityIndicatorView) {
                subView.removeFromSuperview()
            }
        }
    }
    
    func getDataForHomePage(textMessage: String) {
        serviceManager.getDataForChat(textMessage: textMessage) { (_ chatModel : ChatModel?, _ errorModel : ErrorModel?) in
            let q = DispatchQueue.global(qos: .default)
            q.async(execute: {() -> Void in
                DispatchQueue.main.async(execute: {() -> Void in
                    self.chatDelegate?.didReceiveResponseFor(chatModel: chatModel, errorModel: errorModel)
                })
            })
        }
    }
}
