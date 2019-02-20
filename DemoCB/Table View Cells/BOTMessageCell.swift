//
//  BOTMessageCell.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class BOTMessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    /*
     Although messageLabel -> UILabel is there, but textView -> UITextView is placed
     to detect links, numbers and for cut, copy, paste option
     */
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageLabel.textColor = UIColor.clear
        messageLabel.font = APPFont.aveNextMedium(16)
        textView.font = APPFont.aveNextMedium(16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
