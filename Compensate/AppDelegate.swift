//
//  AppDelegate.swift
//  Compensate
//
//  Created on 23.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = RootViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        window!.overrideUserInterfaceStyle = .light
        
        return true
    }

}

