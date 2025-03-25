//
//  ForgotPasswordView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/21/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var showConfirmation: Bool = false
    @State private var errorMessage: String?
    @State private var toast: Toast? = nil
    @State private var navigateToHome = false
    @Environment(\.colorScheme) var colorScheme // Detects Light/Dark Mode
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack{
                    Image(.vector)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(.black)
                        .cornerRadius(50)
                    Text("Reset Your Password")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Enter your email to receive a password reset link.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    
                    Button{
                        Task {
                            
                            await viewModel.resetPassword(email: email)
                            
                            if let errorMessage = viewModel.errorMessage {
                                toast = Toast(message: errorMessage, style: .error)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { toast = nil }
                            } else {
                                showConfirmation = true
                                toast = Toast(message: "Password reset link sent to \(email)", style: .success)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    navigateToHome = true
                                    print("Navigating to HomeView")
                                }
                            }
                        }
                    } label: {
                        Text("Send Reset Link")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .disabled(email.isEmpty)
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigateToHome) {
                SignInView(toastFromChild: toast)
                    .navigationBarBackButtonHidden(true)// Navigate to HomeView after sending reset link
            }
            
        }
    }
}

#Preview {
    ForgotPasswordView()
}
