//
//  The_FavourApp.swift
//  The Favour
//
//  Created by Atta khan on 05/04/2023.
//

import SwiftUI
import IQKeyboardManagerSwift
import FirebaseCore
import GoogleSignIn

@main
struct The_FavourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
//            ExampleView()
            
            if PrefsManager.shared.isWalkThrough {
                if KeychainManager.getAuthToken() != nil  && PrefsManager.shared.favorType != "" {
                    MainTabView()
                } else {
                    NavigationView {
                        SignupView()
                    }
                }
            } else {
                SplashScreenView()
            }
        }

    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
