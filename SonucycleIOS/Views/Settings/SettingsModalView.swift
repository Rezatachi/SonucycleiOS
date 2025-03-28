import SwiftUI

struct SettingsModalView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var notificationsEnabled = true
    @State private var selectedTheme = "Same as device"
    @State private var showDeleteAlert = false

    let themes = ["Same as device", "Light", "Dark"]

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("General")) {
                    SettingsRow(icon: "bell", title: "Notifications", showChevron: false) {
                        Toggle(isOn: $notificationsEnabled) {
                            EmptyView()
                        }
                    }
                    
                    
                    SettingsRow(icon: "circle.lefthalf.filled", title: "Appearance", showChevron: false) {
                        Picker("", selection: $selectedTheme) {
                            ForEach(themes, id: \.self) { theme in
                                Text(theme)
                            }
                        }
                        .pickerStyle(.automatic)
                        .labelsHidden()
                    }
                    
                    
                    Button(action: {
                        if let url = URL(string: "https://yourappsupport.com/bug") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsRow(icon: "text.bubble", title: "Report a bug"){
                            EmptyView()
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://yourappsupport.com/agreements") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsRow(icon: "info.circle", title: "Our agreements"){
                            EmptyView()
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://yourappsupport.com/about") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsRow(icon: "questionmark.circle", title: "About", subtitle: "Version 1.0.0"){
                            EmptyView()
                        }
                    }
                    Button {
                        Task {
                            await authViewModel.signOut()
                        }
                    } label: {
                        SettingsRow(icon: "arrowshape.turn.up.left", title: "Sign Out"){
                            EmptyView()
                        }
                    }
                }

                Section(header: Text("Account actions")) {
                    SettingsRow(icon: "person", title: "Personal details", subtitle: "View and edit your account info"){
                        EmptyView()
                    }

                    Button(role: .destructive) {
                        showDeleteAlert.toggle()
                    } label: {
                        SettingsRow(icon: "trash", title: "Delete Account"){
                            EmptyView()
                        }
                    }
                }
            }
            .listStyle(.automatic)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete your account?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    // Handle account deletion logic
                    print("Account deleted")
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action is PERMANENT and cannot be undone.")
            }
        }
        .background(
            colorScheme == .dark ? Color.black : Color.white
        )
    }
}

#Preview {
    SettingsModalView()
        .environmentObject(AuthViewModel())
}
