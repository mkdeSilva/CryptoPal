//
//  AppDelegate.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 04/04/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        window = UIWindow()
        
        let nav = storyboard.instantiateViewController(withIdentifier: "CurrencyNavigationController") as? UINavigationController
        
        window?.makeKeyAndVisible()
        window?.rootViewController = nav
        
        return true
    }
}

