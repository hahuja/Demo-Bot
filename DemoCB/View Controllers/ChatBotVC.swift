//
//  FirstViewController.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class ChatBotVC : UIViewController , UITableViewDataSource , UITableViewDelegate {


    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var sendButton : UIButton!
    
    var items = [Message]()
    let barHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK:- IBActions
    @IBAction func didTapSendBtn(_ sender : UIButton) {
        
    }


    //MARK:- TableView Delegates and DataSources
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let message = self.items[indexPath.section]
        
//        if message.cardType == .generalSender {
//            return 44
//        }
//        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.items[indexPath.section]
        
        let cell = cellType(indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        if let cell = cell as? BOTMessageCell {
            
            cell.dateAndTimeLabel.text = message.timeAgo
            cell.messageLabel.text = message.text
            cell.textView.text = message.text
        }
        else if let cell = cell as? SenderMessageCell {
            cell.dateAndTimeLabel.text = message.timeAgo
            cell.messageLabel.text = message.text
            cell.textView.text = message.text
        }
        else if let cell = cell as? TypingLoaderCell {
            cell.gifImageView.loadGif(name: "typing_loader")
        }
    }
    
}

