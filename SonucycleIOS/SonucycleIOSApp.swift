//
//  SonucycleIOSApp.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 2/12/25.
//

import SwiftUI

@main
struct SonucycleIOSApp: App {
    
    // Deep link handling can be added here if needed
    @State private var deepLink: DeepLink?
    @StateObject private var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authViewModel)
                .onOpenURL{ url in
                    guard url.scheme == "sonucycle", url.host == "reset-password" else {
                        return
                    }
                    deepLink = DeepLink(url: url)
                }
                .fullScreenCover(item: $deepLink) { _ in
                    // Reset password view can be presented here if needed
                    ResetPasswordView()
                }
                .task {
                    await authViewModel.restoreSession()
                }
        }
    }
}
