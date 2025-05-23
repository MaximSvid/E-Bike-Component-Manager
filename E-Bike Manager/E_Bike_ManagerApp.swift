//
//  E_Bike_ManagerApp.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 12.05.25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct E_Bike_ManagerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            AuthWrapper()
                .environmentObject(authViewModel)
                .environmentObject(homeViewModel)
        }
    }
}
