//
//  AppDelegate.swift
//  PizzaApp
//
//  Created by CongTung on 1/1/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = PizzaRouter.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }


}

