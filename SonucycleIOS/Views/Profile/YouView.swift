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
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)

                        Text("you@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 4)

                    // Recent Logs Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Emotional Logs")
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)

                        ForEach(0..<3) { i in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 60)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Feeling \(i == 0 ? "Grateful" : i == 1 ? "Anxious" : "Calm")")
                                                .font(.body)
                                                .fontWeight(.medium)
                                            Text("Mar 27, 2025")
                                                .font(.caption)
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
                    .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.1), radius: 8, x: 0, y: 2)

                    // Other Suggestions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Things you could add here:")
                            .font(.headline)

                        Text("• Add a profile picture")
                            .foregroundColor(.gray)
                        Text("• Add a bio")
                            .foregroundColor(.gray)
                        Text("• Add a goal")
                            .foregroundColor(.gray)
                    }
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
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsModalView()                    .presentationDetents([.large])
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.black] : [Color.white, Color.gray.opacity(0.2)]),
                    startPoint: .top, endPoint: .bottom
                )
            )
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.black] : [Color.white, Color.gray.opacity(0.2)]),
                startPoint: .top, endPoint: .bottom
            )
        )
    }
}

#Preview {
    YouView().environmentObject(AuthViewModel())
}
