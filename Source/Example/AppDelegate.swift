//
//  AppDelegate.swift
//  Example
//
//  Created by Palmero, Antonio on 28/06/16.
//  Copyright © 2016 Uttopia. All rights reserved.
//

import UIKit
import UserNotifications
import ACPReminder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let manager = ACPReminderManager.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization([.badge, .alert, .sound]) { granted, error in
            print("granted: \(granted)")
            print("error: \(error)")
            if granted {
                // same as old API
                application.registerForRemoteNotifications()
            }
        }
        
        manager.messages = ["12121","54545"]
        manager.testFlagSeconds = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

        manager.createLocalNotification()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Called when the application is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        print("center: \(center)\nnotification: \(notification)")
        if let trigger = notification.request.trigger {
            switch trigger {
            case let n as UNPushNotificationTrigger:
                print("UNPushNotificationTrigger: \(n)")
            case let n as  UNTimeIntervalNotificationTrigger:
                print("UNTimeIntervalNotificationTrigger: \(n)")
            case let n as  UNCalendarNotificationTrigger:
                print("UNCalendarNotificationTrigger: \(n)")
            case let n as  UNLocationNotificationTrigger:
                print("UNLocationNotificationTrigger: \(n)")
            default:
                assert(false)
                break
            }
        }
        completionHandler([.badge, .alert, .sound])
    }
    // Called when the application is in background
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        print("center: \(center)\nresponse: \(response)")
        completionHandler()
    }
}
