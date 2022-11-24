//
//  SceneDelegate.swift
//  WaterfallTrueCompositionalLayoutDemo
//
//  Created by Evgeny Shishko on 12.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let viewController = ViewController()
        
        let window = UIWindow(windowScene: scene)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

