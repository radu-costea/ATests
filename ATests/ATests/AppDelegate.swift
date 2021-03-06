//
//  AppDelegate.swift
//  ATests
//
//  Created by Radu Costea on 06/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import CoreData
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if let url = launchOptions?[UIApplicationLaunchOptionsURLKey] as? NSURL {
            NSUserDefaults.standardUserDefaults().setURL(url, forKey: "launchURL")
        }
        
        configureParse()
        AppearenceCustomizer.setupAppearence()
        
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        print("handle open url \(url)")
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        print("open url \(url)")
        return true
    }
    
    
    func configureParse() {
        // Enable storing and querying data from Local Datastore.
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
        Parse.enableLocalDatastore()
        
        // ****************************************************************************
        // Uncomment and fill in with your Parse credentials:
        ParseConfiguration.registerClassNames()
        
        Parse.setApplicationId("LhlGs02Z4VsK2eRQF8WPDR8VpGMpjRO2LZ5PLnDQ", clientKey: "YI7FfxORbIYGZITklq1ONROZFV6WDpz5HQg4tTfr")
        
        PFUser.enableAutomaticUser()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
    }
}

