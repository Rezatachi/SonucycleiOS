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
            ScrollView {
                VStack(spacing: 24) {
                    // General Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("General")
                            .font(.silkCaption(size: 14))
                            .foregroundColor(AppTheme.text(for: colorScheme))
                            .padding(.top, 10)

                        VStack(spacing: 10) {
                            SettingsRow(icon: "bell", title: "Notifications", showChevron: false) {
                                Toggle(isOn: $notificationsEnabled) {
                                    EmptyView()
                                }
                            }

                            SettingsRow(icon: "circle.lefthalf.filled", title: "Appearance", showChevron: false) {
                                Picker("", selection: $selectedTheme) {
                                    ForEach(themes, id: \.self) { theme in
                                        Text(theme)
                                            .font(.silkBody())
                                    }
                                }
                                .pickerStyle(.automatic)
                                .labelsHidden()
                            }

                            SettingsRow(icon: "text.bubble", title: "Report a bug") {
                                EmptyView()
                            }
                            .onTapGesture {
                                if let url = URL(string: "https://yourappsupport.com/bug") {
                                    UIApplication.shared.open(url)
                                }
                            }

                            SettingsRow(icon: "info.circle", title: "Our agreements") {
                                EmptyView()
                            }
                            .onTapGesture {
                                if let url = URL(string: "https://yourappsupport.com/agreements") {
                                    UIApplication.shared.open(url)
                                }
                            }

                            SettingsRow(icon: "questionmark.circle", title: "About", subtitle: "Version 1.0.0") {
                                EmptyView()
                            }
                            .onTapGesture {
                                if let url = URL(string: "https://yourappsupport.com/about") {
                                    UIApplication.shared.open(url)
                                }
                            }

                            SettingsRow(icon: "arrowshape.turn.up.left", title: "Sign Out") {
                                EmptyView()
                            }
                            .onTapGesture {
                                Task {
                                    await authViewModel.signOut()
                                }
                            }
                        }
                        .padding()
                        .background(AppTheme.background(for: colorScheme))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                    }

                    // Account Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Account actions")
                            .font(.silkCaption(size: 14))
                            .foregroundColor(AppTheme.text(for: colorScheme))
                            .padding(.top, 10)

                        VStack(spacing: 10) {
                            SettingsRow(icon: "person", title: "Personal details", subtitle: "View and edit your account info") {
                                EmptyView()
                            }

                            SettingsRow(icon: "trash", title: "Delete Account") {
                                EmptyView()
                            }
                            .onTapGesture {
                                showDeleteAlert.toggle()
                            }
                        }
                        .padding()
                        .background(AppTheme.background(for: colorScheme))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                    }
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(AppTheme.background(for: colorScheme))
            .alert("Delete your account?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    print("Account deleted")
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action is PERMANENT and cannot be undone.")
            }
        }
    }
}

#Preview {
    SettingsModalView()
        .environmentObject(AuthViewModel())
}
