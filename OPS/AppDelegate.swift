//
//  AppDelegate.swift
//  Whoops
//
//  Created by Aaron on 4/25/21.
//

import UIKit
import Firebase
import SwiftTheme

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        switch UIScreen.main.traitCollection.userInterfaceStyle {
                //todo: support white mode
            case _ : MyThemes.switchTo(theme: .darkBlue)
            case .light:
                MyThemes.switchTo(theme: .white)
                window?.backgroundColor = .white
            case .dark:
                MyThemes.switchTo(theme: .darkBlue)
                window?.backgroundColor = .black
            case .unspecified:
                MyThemes.switchTo(theme: .white)
                window?.backgroundColor = .white
            @unknown default:
                MyThemes.switchTo(theme: .white)
                window?.backgroundColor = .white
        }
//        MyThemes.restoreLastTheme()
        UIApplication.shared.theme_setStatusBarStyle(MyThemes.statusBarStyle, animated: true)
        let a = WalletController()
//        if !WalletController.hasWallet {
//            window?.rootViewController = UINavigationController(rootViewController: LoginPage1())
//        } else {
            window?.rootViewController = TabBarController()
//        }

        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        MyThemes.saveLastTheme()
    }
}

