//
//  AppConstants.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

let themeChangeObserver = "ThemeChanged"

struct SRColor {
    static let navBlue = RGBA(r: 0, g: 138, b: 247, a: 1)
    static let darkBlue = RGBA(r: 47, g: 65, b: 150, a: 1) //#254F88
    static let appColor = darkBlue
    static let lightGray = RGBA(r: 223, g: 227, b: 229, a: 1)
    static let darkGray = RGBA(r: 192, g: 192, b: 192, a: 1)
    static let lightOrange = RGBA(r: 245, g: 165, b: 68, a: 1) //#F5A544
    static let darkOrange = RGBA(r: 171, g: 103, b: 41, a: 1) //#F5A544
    static let lightNight = RGBA(r: 48, g: 48, b: 48, a: 1)
    static let darkNight = RGBA(r: 33, g: 33, b: 33, a: 1)
    static let darkRed = RGBA(r: 130, g: 52, b: 47, a: 1)
    static let blueLink = RGBA(r: 63, g: 136, b: 236, a: 1)
}



class APPFont {
    
    class func aveNextMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
}

class Constants: NSObject {
    
    class var netError: OurErrorProtocol {
        
        return CustomError(title: "Connection Error!", description: "Internet connection appears to be offline. Please check your internet connection.", code: 9999)
    }
    
    class func showInternetErrorAlert() {
        AlertController.alert(title: "Connection Error!", message: "Internet connection appears to be offline. Please check your internet connection.")
    }
}
