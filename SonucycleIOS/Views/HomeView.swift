//
//  HomeView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/17/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = SignInViewModel()
    @Environment(\.colorScheme) var colorScheme // Detects Light/Dark Mode
    @State private var toast: Toast? = nil
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                // Welcome Text
                HStack {
                    Text("Sonucycle")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.top, 20)
                    Image(systemName: "moonphase.new.moon.inverse")
                        .font(.largeTitle)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.top, 20)
                }

                // Input Fields
                VStack(spacing: 12) {
                    TextField("Email address", text: $viewModel.email)
                        .padding()
                        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .padding(.horizontal, 40)

                // Register Link
                Button(action: {}) {
                    Text("New User? Register Here")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.footnote)
                }
                .padding(.top, 10)

                // Sign In Button
                // Sign In Button
                Button {
                    Task {
                        if !viewModel.isFormValid() {
                            toast = Toast(message: "Invalid email or password.", style: .error)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation { toast = nil }
                            }
                            return
                        }
                        
                        await viewModel.signIn()
                        
                        if let errorMessage = viewModel.errorMessage {
                            toast = Toast(message: errorMessage, style: .error)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation { toast = nil }
                            }
                        }
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(colorScheme == .dark ? Color.white : Color.black)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .cornerRadius(12)
                    }
                }
                .contentShape(Rectangle()) // 🔹 Makes the whole button area clickable
                .padding(.horizontal, 40)
                .padding(.top, 10)
                    
        

                

                // Apple Sign-In Button
                Button(action: {
                    Task { await viewModel.signInWithApple() }
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                        Text("Sign in with Apple")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(colorScheme == .dark ? 0.2 : 1))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 40)
                .padding(.top, 10)

                // Google Sign-In Button
                Button(action: {
                    Task {
                        await viewModel.signInWithGoogle()
                        if let errorMessage = viewModel.errorMessage {
                            toast = Toast(message: errorMessage, style: .error)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    toast = nil
                                }
                            }
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Sign in with Google")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(colorScheme == .dark ? 0.2 : 1))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 40)
                .padding(.top, 10)


                Spacer(minLength: 10)

                // Footer Text
                Text("© 2025 Sonucycle")
                    .font(.footnote)
                Text("人生を掴み取れ。")
                    .font(.footnote)
                    .padding(.bottom, 20)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colorScheme == .dark ? [Color.sonucycleBG, Color.sonucycleBG] : [Color.white, Color.gray.opacity(0.2)]),
                    startPoint: .top, endPoint: .bottom
                )
            )
            .edgesIgnoringSafeArea(.all)

            // Show Toast at the Top of the Screen
            if let toast = toast {
                VStack {
                    ToastView(
                        message: toast.message,
                        style: toast.style,
                        onCancelledTapped: { self.toast = nil }
                    )
                    // fade in
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: toast)
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        // Hide Keyboard When Tapped Outside
        .onTapGesture {
            hideKeyboard()
        }
    }
       
}

#Preview {
    HomeView()
}
