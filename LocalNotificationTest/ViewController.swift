//
//  ViewController.swift
//  LocalNotificationTest
//
//  Created by Kanakaraju Chinnam on 1/25/17.
//  Copyright © 2017 ABC. All rights reserved.

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
    }
    //ADD Button
    @IBAction func DidTapButton(_ sender: UIButton) {
        // Request for Notification Settings

        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:

                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }

                    // Schedule The Local Notification

                    self.scheduleLocalNotification()
                })

            // Request Authorization
            case .authorized:
                self.scheduleLocalNotification()

            // Schedule Local Notification
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
    }
    // Add Trigger
    // let notificationtrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)

    // MARK: - Private Methods

    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {

        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            completionHandler(success)
        }
    }
    private func scheduleLocalNotification() {

        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()

        // Configure Notification Content
        notificationContent.title =  "Title"
        notificationContent.subtitle = "Sub Titile"
        //  notificationContent.badge =
        notificationContent.body = "Hey Hi!"

        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)

        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "HP Inc_local_notification", content: notificationContent, trigger: notificationTrigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

