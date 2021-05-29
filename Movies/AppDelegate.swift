//
//  AppDelegate.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
           CoreDataManager.shared.saveContext()
      
    }

}
