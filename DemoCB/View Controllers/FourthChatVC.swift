//
//  FourthChatVC.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 28/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class FourthChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Fourth View Controller"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapMenuClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
