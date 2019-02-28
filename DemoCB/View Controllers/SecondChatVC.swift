//
//  SecondChatVC.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class SecondChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second View Controller"
        print("nav :\(self.navigationController)")
    }

    @IBAction func didTapMenuClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    

}

