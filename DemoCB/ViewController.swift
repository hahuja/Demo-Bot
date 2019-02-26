//
//  ViewController.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 25/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inpoutWidthConstraint : NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.inpoutWidthConstraint.constant = 4*(UIScreen.main.bounds.width/5)
        }else {
            self.inpoutWidthConstraint.constant = 7*(UIScreen.main.bounds.width/10)
        }
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
