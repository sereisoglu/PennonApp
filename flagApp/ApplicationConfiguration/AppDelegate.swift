//
//  AppDelegate.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let mainController = MainController()
        window?.rootViewController = mainController
        
        AppUtility.openApplication()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
        AppUtility.closeApplication()
    }
    
    var orientationLock = UIInterfaceOrientationMask.all
    // TODO: orientationLock degistiginde bu fonskyion calisiyor mu bak?
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print(url)
//
//        return true
//    }
    
}
