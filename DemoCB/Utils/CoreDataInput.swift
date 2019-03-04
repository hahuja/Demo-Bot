//
//  CoreDataInput.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 01/03/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataInput {
    
    class func saveMessage(text : String , timeStamp : Int , cardType : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let privateManagedObjectContext: NSManagedObjectContext = {
            let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            moc.parent = context
            return moc
        }()
        let insertMessageEntity = NSEntityDescription.entity(forEntityName: "MessageModel", in: privateManagedObjectContext)
//        let insertMessageData = NSEntityDescription.insertNewObject(forEntityName: "Message", into: privateManagedObjectContext)
        
        let messageObject = NSManagedObject(entity: insertMessageEntity!, insertInto: privateManagedObjectContext)
        if cardType == "typingLoader" {
            return
        }
        let timeStampString = String(describing: timeStamp)
        messageObject.setValue("\(text)", forKey: "text")
        messageObject.setValue("\(timeStampString)", forKey: "timeStamp")
        messageObject.setValue("\(cardType)", forKey: "cardType")

        privateManagedObjectContext.perform {
            do {
                print("Thread :- \(Thread.current.isMainThread)")
                try privateManagedObjectContext.save()
                
                
            }catch {
                print("Failed to save")
            }
        }
    }
    
    class func retreiveSavedMessages() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let privateManagedObjectContext: NSManagedObjectContext = {
            let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            moc.parent = context
            return moc
        }()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageModel")
//        let insertMessageEntity = NSEntityDescription.entity(forEntityName: "MessageModel", in: privateManagedObjectContext)
        
        do {
            let result = try privateManagedObjectContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print("\(data.value(forKey: "text") as! String)")
                print("\(data.value(forKey: "timeStamp") as! String)")
            }
        }
        catch {
            print("Failed to fetch")
        }
        
//        let message = Message[]()
    }
}
