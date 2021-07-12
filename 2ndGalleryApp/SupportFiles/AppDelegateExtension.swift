//
//  AppDelegateExtension.swift
//  2ndGalleryApp
//
//  Created by Роман on 09.07.2021.
//

import UIKit

extension AppDelegate {
    
    func openStartScreen(window: UIWindow?) {
        if let window = window {
            self.window = window
        }
        guard let window = self.window else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return openStartScreen(window: nil)
        }
        DispatchQueue.main.async {
            let navController = UINavigationController()
            window.rootViewController = navController
            StartConfigurator.open(navigationController: navController)
            window.makeKeyAndVisible()
        }
    }
    
    func openStartGalleryScreen() {
        guard let window = self.window else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return openStartGalleryScreen()
        }
        DispatchQueue.main.async {
            let rootView = R.storyboard.mainGallery.instantiateInitialViewController()
            window.makeKeyAndVisible()
            window.rootViewController = rootView
        }
    }
}

extension AppDelegate {
    
    func doLogout() {
        self.settings?.clearUserData()
    }
}

