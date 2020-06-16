//
//  AppDelegate.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {} else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            
            let postsViewController = UINavigationController(rootViewController: PostsViewController(nibName: Constants.Nibs.postViewController, bundle: nil))
            
            window.rootViewController = postsViewController
            window.makeKeyAndVisible()
            
            self.window = window
        }
        
        return true
    }

}

