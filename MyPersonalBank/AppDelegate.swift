//
//  AppDelegate.swift
//  MyPersonalBank
//
//  Created by Tatiana Dmitrieva on 20/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptionts: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
       // window?.rootViewController = LoginViewController()
        window?.rootViewController = OnboardingContainerViewController()
        //window?.rootViewController = OnboardingViewController(heroImageName: "001-rocket", titleText: "MyPersonalBank is faster, easier to use, and has a brand new look")
        return true
    }
}

