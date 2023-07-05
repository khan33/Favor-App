//
//  The_FavourApp.swift
//  The Favour
//
//  Created by Atta khan on 05/04/2023.
//

import SwiftUI
import IQKeyboardManagerSwift
import Firebase

@main
struct The_FavourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            
            if PrefsManager.shared.isWalkThrough {
                if KeychainManager.getAuthToken() != nil {
                    MainTabView()
//                        .preferredColorScheme(.light) // Set preferred color scheme to light

                } else {
                    NavigationView {
                        SignupView()
//                            .preferredColorScheme(.light) // Set preferred color scheme to light

                    }
                }
            } else {
                SplashScreenView()
//                    .preferredColorScheme(.light) // Set preferred color scheme to light

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
}
