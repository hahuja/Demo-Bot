//
//  FirstViewController.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import UIKit

class ChatBotVC : UIViewController , UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate {


    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var sendButton : UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputBarBottomLayout: NSLayoutConstraint!
    
    var items = [Message]()
    let barHeight: CGFloat = 50
    var helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        CoreDataInput.retreiveSavedMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- IBActions
    @IBAction func didTapSendBtn(_ sender : UIButton) {
        if let text = self.inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            LexHelper.sendToLex(text)
            self.addLoaderMessage()
            self.helper.getDataForHomePage(textMessage: text)
        }
    }
    
    @IBAction func didTapMenuClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }

    fileprivate func initialSetUp() {
        self.setupTableView()
        self.setupInputBar()
        self.addWelcomeMessage()
        self.handleBOTResponse()
        self.helper.chatDelegate = self
        self.navigationItem.title = "ChatBot"
        self.addFetchBtn()
    }

    fileprivate func addWelcomeMessage() {
        items.append(Message.getHelloMessageFromBOT())
        
    }
    
    //MARK:- TableView Delegates and DataSources
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        
        return cell
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputTextField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let trimmedtext = self.inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedtext!.isEmpty {
            let lightGrayImg = self.sendButton.imageView!.image!.color(color: UIColor.lightGray)
            self.sendButton.setImage(lightGrayImg, for: .normal)
            self.sendButton.isEnabled = false
        }else {
            let newGrayImg = self.sendButton.imageView!.image!.color(color: UIColor.blue)
            self.sendButton.setImage(newGrayImg, for: .normal)
            self.sendButton.isEnabled = true
        }
    }
    
    //MARK:- Keyboard NotificationCenter handlers
    @objc func keyboardWillShow(notification: Notification) {
        if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            let userInfo = (notification as NSNotification).userInfo!
            let keyboardHeight =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//            self.tableView.contentInset.bottom = height
            self.tableView.scrollIndicatorInsets.bottom = height
            self.inputBarBottomLayout.constant =  keyboardHeight.height - self.view.safeAreaInsets.bottom
            
//            if self.view.frame.origin.y == 0 {
//
//                self.view.frame.origin.y -= keyboardHeight.height - self.view.safeAreaInsets.bottom
//            }
            if self.items.count > 0 {
                let lastSectionIndex = self.tableView.numberOfSections - 1
                let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
                let pathToLastRow = IndexPath(row: lastRowIndex, section: lastSectionIndex)
                self.tableView.scrollToRow(at: pathToLastRow, at: .bottom, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
//        let userInfo = (notification as NSNotification).userInfo!
//        let keyboardHeight =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        if self.view.frame.origin.y != 0{
//            self.view.frame.origin.y += keyboardHeight.height - self.view.safeAreaInsets.bottom
//            self.view.frame.origin.y = 0
//        }
//        self.tableView.contentInset.bottom = 0
        self.tableView.scrollIndicatorInsets.bottom = 0
        self.inputBarBottomLayout.constant = 0
    }
    
    func addFetchBtn() {
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.setTitle("Fetch", for: .normal)
        btn1.setTitleColor(UIColor.black, for: .normal)
        btn1.addTarget(self, action: #selector(self.didTapFetchMessagesBtn), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = item1
    }
    
    @objc func didTapFetchMessagesBtn() {
        CoreDataInput.retreiveSavedMessages()
    }
}

