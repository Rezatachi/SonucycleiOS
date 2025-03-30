import SwiftUI

struct RefreshedHomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                // Logo + Title
                VStack(spacing: 8) {
                    Image(systemName: "circle.grid.cross")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding()
                        .background(Color("SonuAccent").opacity(0.1))
                        .clipShape(Circle())
                    
                    Text("Welcome to Sonucycle")
                        .font(.custom("SilkFlowerDemo-Regular", size: 26))
                        .foregroundColor(Color("SonuText"))
                }

                // Input Fields
                VStack(spacing: 16) {
                    TextField("Email address", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 5)

                    SecureField("Password", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 5)
                }
                .padding(.horizontal, 24)

                // Button
                Button(action: {}) {
                    Text("Sign In")
                        .font(.custom("SilkFlowerDemo-Regular", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("SonuAccent"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)

                Spacer()
                
                // Footer
                VStack(spacing: 4) {
                    Text("© 2025 Sonucycle")
                        .font(.custom("SilkFlowerDemo-Regular", size: 12))
                        .foregroundColor(.gray)
                    Text("人生を掴み取れ。")
                        .font(.custom("SilkFlowerDemo-Regular", size: 10))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("SonuCream").ignoresSafeArea())
        }
    }
}

#Preview {
    RefreshedHomeView()
}
