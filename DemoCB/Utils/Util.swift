//
//  Util.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let kAppColor = RGBA(r: 220, g: 107, b: 41, a: 1)
let kSeparatorColor = RGBA(r: 230, g: 230, b: 230, a: 1)

let isDeviceHasCamera = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
let defaults = UserDefaults.standard

let mainStoryboard =                UIStoryboard(name: "Main", bundle: nil)

let kWindowWidth = UIScreen.main.bounds.size.width
let kWindowHeight = UIScreen.main.bounds.size.height


var currentTimestamp: String {
    return "\(Date().timeIntervalSince1970)"
}

// MARK: - Useful functions

func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: a)
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func hexStringToUIColor(_ hex: String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func delay(delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * (CGFloat.pi / 180)
}

func radiansToDegress(radians: CGFloat) -> CGFloat {
    return radians * 180 / CGFloat.pi
}

class AppUtility: NSObject {
    
    class func deviceUDID() -> String {
        
        var udidString = ""
        
        if let udid = UIDevice.current.identifierForVendor?.uuidString {
            udidString = udid
        }
        
        return udidString
    }
    
    // Date from unix timestamp from Date
    class func date(timestamp: Double) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    class func getStoryBoard(storyBoardName: String) -> UIStoryboard {
        return  UIStoryboard(name: storyBoardName, bundle:nil)
    }
    
    class func addSubview(subView: UIView, toView parentView: UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
}


