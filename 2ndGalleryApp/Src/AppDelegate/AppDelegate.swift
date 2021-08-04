//
//  AppDelegate.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import CoreData
import DBDebugToolkit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var settings: Settings?
    
    static var shared: AppDelegate {
        if Thread.isMainThread {
            return UIApplication.shared.delegate as! AppDelegate
        }
        let dispatchGroup = DispatchGroup()
        var realDelegate: AppDelegate?
        dispatchGroup.enter()
        DispatchQueue.main.async {
            realDelegate = UIApplication.shared.delegate as? AppDelegate
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        return realDelegate!
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.8117647059, green: 0.2862745098, blue: 0.4941176471, alpha: 1)
        #if DEBUG
        DBDebugToolkit.setup(with: [DBShakeTrigger()])
        UserDefaults.standard.set(false,
                                  forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        #endif
        
        DI.initDependencies(appDelegate: self)
        self.settings = DI.resolve()
        
        checkAuth(window: self.window)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "_ndGalleryApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
