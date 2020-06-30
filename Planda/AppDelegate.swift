//
//  AppDelegate.swift
//  Planda
//
//  Created by Prince Carter on 4/21/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase
import FBSDKCoreKit

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        return true
    }
          
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }

}

