//
//  SceneDelegate.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/13/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            
            let postsViewController = PostsViewController(nibName: "PostsViewController", bundle: nil)
            
            let mainNavigationController = UINavigationController(rootViewController: postsViewController)
            
            self.window!.rootViewController = mainNavigationController
            self.window!.makeKeyAndVisible()
        }
    }
}
