//
//  UITextFieldExtension.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func nameType(_ returnKeyType: UIReturnKeyType = .next) {
        self.autocapitalizationType = .words
        setupWith(.asciiCapable, returnKeyType: returnKeyType)
    }
    
    func emailType(_ returnKeyType: UIReturnKeyType = .next) {
        setupWith(.emailAddress, returnKeyType: returnKeyType)
    }
    
    func passwordType(_ returnKeyType: UIReturnKeyType = .next) {
        self.autocapitalizationType = .words
        self.isSecureTextEntry = true
        setupWith(.asciiCapable, returnKeyType: returnKeyType)
    }
    
    func mobileNumberType(_ returnKeyType: UIReturnKeyType = .next) {
        setupWith(.phonePad, returnKeyType: returnKeyType)
    }
    
    func numberType(_ returnKeyType: UIReturnKeyType = .next) {
        setupWith(.numberPad, returnKeyType: returnKeyType)
    }
    
    // MARK:- Private function >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    private func setupWith(_ keyBoardType: UIKeyboardType, returnKeyType: UIReturnKeyType) {
        
        self.returnKeyType = returnKeyType
        self.keyboardType = keyBoardType
        
        self.autocorrectionType = .no
        self.spellCheckingType = .no
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat = 8){
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
