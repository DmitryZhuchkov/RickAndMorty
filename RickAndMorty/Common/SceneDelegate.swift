//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Дмитрий Жучков on 21.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
               guard let windowScene = (scene as? UIWindowScene) else { return }
        // MARK: Navigation controller rooting and settings
                       window = UIWindow(frame: windowScene.coordinateSpace.bounds)
                       window?.windowScene = windowScene
                       let navigatonController = UINavigationController(rootViewController: MenuController())
                       navigatonController.navigationBar.setBackgroundImage(UIImage(), for: .default)
                       navigatonController.navigationBar.shadowImage = UIImage()
                       navigatonController.navigationBar.layoutIfNeeded()
                       navigatonController.navigationBar.barTintColor = UIColor(named: "Background")
                       navigatonController.navigationBar.isTranslucent = false
                       navigatonController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor")!]
                       navigatonController.navigationBar.tintColor = UIColor(named: "TextColor")
                       window?.rootViewController = navigatonController
                       window?.makeKeyAndVisible()
    }
}
