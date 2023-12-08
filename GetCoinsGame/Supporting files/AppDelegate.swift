//
//  AppDelegate.swift
//  8888
//
//  Created by Дарья Носова on 15.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let introViewController = IntroViewController(nibName: "IntroViewController", bundle: nil)
        window?.rootViewController = introViewController
        window?.makeKeyAndVisible()
        open()
        return true
    }
    
        func open() {
            let navigation = UINavigationController()
            let vc = GameViewController()
            navigation.viewControllers = [vc]
            navigation.isNavigationBarHidden = true
            window!.rootViewController = navigation
            window?.makeKeyAndVisible()
        }

}

