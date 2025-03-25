import SwiftUI

struct YouView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    Spacer()

                    // Profile Header
                    VStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)

                        Text("Your Name")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)

                        Text("you@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.black] : [Color.white, Color.gray.opacity(0.2)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                // Settings button
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showSettings.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsModalView()
                    .presentationDetents([.large])
            }
        }
    }
}




#Preview {
    YouView()
}
