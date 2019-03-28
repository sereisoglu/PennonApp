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
    
    var orientationLock = UIInterfaceOrientationMask.all
    var phoneOrientation: UIDeviceOrientation?
    var padOrientation: UIDeviceOrientation?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.detectOrientation), name:UIDevice.orientationDidChangeNotification, object:nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            AppUtility.lockOrientation(.all)
        } else {
            AppUtility.lockOrientation(.portrait)
        }
        
        ControlData.shared.controlData()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let mainController = MainController()
        window?.rootViewController = mainController
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if window?.rootViewController is PlayerController {
            let playerController: PlayerController = window?.rootViewController as! PlayerController
            playerController.closePlayer()
        }
        self.saveContext()
        NotificationCenter.default.removeObserver(self)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if window?.rootViewController is PlayerController {
            let playerController: PlayerController = window?.rootViewController as! PlayerController
            if #imageLiteral(resourceName: "pause-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate) == playerController.controlLayerView.centerViewCenterButton.image(for: .normal) {
                playerController.avPlayer.pause()
                playerController.controlLayerView.centerViewCenterButton.setImage(#imageLiteral(resourceName: "play-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    @objc func detectOrientation() {
        switch UIDevice.current.orientation {
        case UIDeviceOrientation.unknown:
            //print("Unknown")
            phoneOrientation = .landscapeLeft
            padOrientation = .landscapeLeft
        case UIDeviceOrientation.portrait:
            //print("Portrait")
            phoneOrientation = .landscapeLeft
            padOrientation = .portrait
        case UIDeviceOrientation.portraitUpsideDown:
            //print("PortraitUpsideDown")
            phoneOrientation = .landscapeLeft
            padOrientation = .portraitUpsideDown
        case UIDeviceOrientation.landscapeLeft:
            //print("LandscapeLeft")
            phoneOrientation = .landscapeLeft
            padOrientation = .landscapeLeft
        case UIDeviceOrientation.landscapeRight:
            //print("LandscapeRight")
            phoneOrientation = .landscapeRight
            padOrientation = .landscapeRight
        case UIDeviceOrientation.faceUp:
            //print("FaceUp")
            phoneOrientation = .landscapeLeft
        case UIDeviceOrientation.faceDown:
            //print("FaceDown")
            phoneOrientation = .landscapeLeft
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    //UIInterfaceOrientation
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIDeviceOrientation) {
//        self.lockOrientation(orientation)
//        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
//        UINavigationController.attemptRotationToDeviceOrientation()
//    }
}
