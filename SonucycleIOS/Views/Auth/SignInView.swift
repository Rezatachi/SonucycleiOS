//
//  HomeView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/17/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var toast: Toast? = nil
    @State private var navigateToHome = false
    
    // Accept toast from child view like ForgotPasswordView
    var toastFromChild: Toast? = nil
    
    var body: some View {
        NavigationStack{
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
                        Image(.vector)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .background(.black)
                            .cornerRadius(50)
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
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
                        Text("New User? Register Here")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.footnote)
                    }
                    .padding(5)
                    // Sign In Button
                    Button {
                        Task {
                            if !viewModel.isFormValid(email: viewModel.email, password: viewModel.password) {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.error)
                                toast = Toast(message: "Invalid email or password.", style: .error)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation { toast = nil }
                                }
                                return
                            }
                            
                            await viewModel.signIn(
                                email: viewModel.email,
                                password: viewModel.password
                            )
                            
                            
                            
                            
                            if let errorMessage = viewModel.errorMessage {
                                toast = Toast(message: errorMessage, style: .error)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation { toast = nil }
                                }
                            } else {
                                toast = Toast(message: "Sign in successful!", style: .success)
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
                    .onTapGesture {
                        hideKeyboard()
                    
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
                    .background(Color.white.opacity(colorScheme == .dark ? 0 : 1))
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
                    .background(Color.white.opacity(colorScheme == .dark ? 0 : 1))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    
                    // Forgot Password Link
                    NavigationLink(destination: ForgotPasswordView().navigationBarBackButtonHidden(true)) {
                        Text("Forgot Password?")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.footnote)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    
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
                        gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.black] : [Color.white, Color.gray.opacity(0.2)]),
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .edgesIgnoringSafeArea(.all)
                
            }
            .safeAreaInset(edge: .top) {
                if let toast = toast {
                    ToastView(
                        message: toast.message,
                        style: toast.style,
                        onCancelledTapped: { self.toast = nil }
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: toast)
                }
            }
            // Hide Keyboard When Tapped Outside
            .onTapGesture {
                hideKeyboard()
            }
            .scrollDismissesKeyboard(.interactively)
            .onAppear {
                if let toastFromChild = toastFromChild {
                    toast = toastFromChild
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            toast = nil
                        }
                    }
                    
                }
            }
        }
    }
}






#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
