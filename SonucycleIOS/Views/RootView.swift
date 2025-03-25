//
//  RootView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/23/25.
//

import SwiftUI

struct RootView: View {
    // get environemnt object for authviewmodel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group{
            if authViewModel.isSignedIn{
                // User is signed in, show the main app view
                MainTabView()
                    .environmentObject(authViewModel)
            } else {
                // User is not signed in, show the sign-in view
                SignInView()
                    .environmentObject(authViewModel)
            }
        }
        .animation(.easeInOut, value: authViewModel.isSignedIn)
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel()) // Provide a default AuthViewModel for preview
}
