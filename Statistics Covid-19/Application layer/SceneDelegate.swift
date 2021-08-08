//
//  SceneDelegate.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let assemblyBuilder = AssemblyBuilder()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = assemblyBuilder.makeRootTabBarController()
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
