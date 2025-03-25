//
//  SettingsModalView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/25/25.
//

import SwiftUI

struct SettingsModalView: View {
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme
    var body: some View {
           NavigationStack {
               List {
                   Section(header: Text("General")) {
                       SettingsRow(icon: "bell", title: "Notifications")
                       SettingsRow(icon: "circle.lefthalf.filled", title: "Appearance", subtitle: "Same as device")
                       SettingsRow(icon: "text.bubble", title: "Report a bug")
                       SettingsRow(icon: "info.circle", title: "Our agreements")
                       SettingsRow(icon: "questionmark.circle", title: "About")
                   }

                   Section(header: Text("Account actions")) {
                       SettingsRow(icon: "person", title: "Personal details", subtitle: "View and edit your account info")
                   }
               }
               .listStyle(.automatic)
               .navigationTitle("Settings")
               .navigationBarTitleDisplayMode(.inline)
           }
           .background(
               colorScheme == .dark
               ? Color.black
               : Color.white
           )
       }
}

#Preview {
    SettingsModalView()
}
