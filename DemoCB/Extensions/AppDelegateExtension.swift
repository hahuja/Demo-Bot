//
//  AppDelegateExtension.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func setupReachability() {
        // Allocate a reachability object
        
        
        let reach = Reachability()!
        if reach.connection == .cellular {
            APPDELEGATE.isReachable = true
        }else if reach.connection == .wifi {
            APPDELEGATE.isReachable = true
        }else {
            APPDELEGATE.isReachable = false
        }
////        reach!.whenReachable
////        APPDELEGATE.isReachable = reach!.isReachable()
////
//        // Set the blocks
//        reach.whenReachable = { (reachability) in
//            
//            DispatchQueue.main.async(execute: {
//                APPDELEGATE.isReachable = true
//            })
//        }
//        reach.whenUnreachable = { (reachability) in
//            DispatchQueue.main.async(execute: {
//                APPDELEGATE.isReachable = false
//            })
//        }
//        do {
//            try reach.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }
    }
}

