//
//  NotificationViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 11/4/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationViewController : UIViewController {
    
    
    //MARK: - THIS MODULE IS NOT FINISHED DUE TO THE DISCOVERY THAT YOU NEED A DEVELOPER ACCOUNT TO SEND PUSH NOTIFICATIONS WHICH I CURRENTLY DONT HAVE
    //BUT LOCAL NOTIFCATIONS SHOULD WORK - THIS MODULE HAS NO SEGUES THEREFORE NOT ACCESIBLE AND THIS IS FOR FUTURE DEVELOPMENT
    
    @IBAction func btnLocalNotif(_ sender: Any) {
        
        
        let alerts = UIAlertController(title: "Send Local Notification", message: "Enter Notification Details, Please Press Home Button After Pressing Save in order For Notification to Appear", preferredStyle: .alert)
        alerts.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Notification Title"
        }
        alerts.addTextField { (textField : UITextField!) -> Void in
            textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 100))
            textField.placeholder = "Enter Notification Message/Body"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let alertTitle = alerts.textFields![0] as UITextField
            let alertBody = alerts.textFields![1] as UITextField
            let strtitle = alertTitle.text
            let strbody = alertBody.text
            
            let content = UNMutableNotificationContent()
            content.title = strtitle!
            content.body = strbody!
            content.sound = UNNotificationSound.default()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5 , repeats: false)
            let request = UNNotificationRequest (identifier: "testIdentifier", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            print("Notif Succesfully Sent")
           
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        alerts.addAction(saveAction)
        alerts.addAction(cancelAction)
        
        self.present(alerts, animated: true, completion: nil)
        
    }
    
    @IBAction func btnPushNotif(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
