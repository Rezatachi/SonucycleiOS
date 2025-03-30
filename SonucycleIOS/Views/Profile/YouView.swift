import SwiftUI

struct YouView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Card
                    VStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)

                        Text("Your Name")
                            .font(.silkHeading(size: 20))
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        Text("you@example.com")
                            .font(.silkBody(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppTheme.background(for: colorScheme))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 4)

                    // Recent Logs Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Emotional Logs")
                            .font(.silkHeading(size: 18))
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        ForEach(0..<3) { i in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(AppTheme.background(for: colorScheme).opacity(0.8))
                                .frame(height: 60)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Feeling \(i == 0 ? "Grateful" : i == 1 ? "Anxious" : "Calm")")
                                                .font(.silkBody())
                                            Text("Mar 27, 2025")
                                                .font(.silkCaption(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal)
                                )
                        }
                    }
                    .padding()
                    .background(AppTheme.background(for: colorScheme))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.1), radius: 8, x: 0, y: 2)

                    // Other Suggestions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Things you could add here:")
                            .font(.silkBody())
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        Text("• Add a profile picture")
                        Text("• Add a bio")
                        Text("• Add a goal")
                    }
                    .font(.silkCaption())
                    .foregroundColor(.gray)
                    .padding()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(AppTheme.text(for: colorScheme))
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsModalView()
                    .presentationDetents([.large])
            }
            .background(AppTheme.background(for: colorScheme).ignoresSafeArea())
        }
        .background(AppTheme.background(for: colorScheme).ignoresSafeArea())
    }
}

#Preview {
    YouView().environmentObject(AuthViewModel()).preferredColorScheme(.dark)
}
