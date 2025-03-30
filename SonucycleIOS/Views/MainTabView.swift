//
//  MainTabView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/25/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "book")
                }
            
            YouView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
        .preferredColorScheme(.dark)
}
