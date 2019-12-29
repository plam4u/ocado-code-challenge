//
//  AppDelegate.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()
    let appDependencies = AppDependencies()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appDependencies.installRootViewController(into: window!)

        return true
    }
}

