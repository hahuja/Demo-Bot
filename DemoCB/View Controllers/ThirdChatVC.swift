//
//  ThirdChatVC.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 27/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class ThirdChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Third View Controller"
        print("nav :\(self.navigationController)")
    }
    

    @IBAction func didTapMenuClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
