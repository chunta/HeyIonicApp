//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by chunta on 2020/11/13.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Appier
class NotificationViewController: QGNotificationContentViewController {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    /*
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
*/
}
