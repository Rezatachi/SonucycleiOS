//
//  ResetPasswordView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/23/25.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var viewModel = AuthViewModel()
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var toast: Toast? = nil
    @State private var isSuccess: Bool = false
    @State private var navigateToHome: Bool = false

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image(.vector)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(.black)
                        .cornerRadius(50)

                    Spacer().frame(height: 100)

                    VStack(spacing: 12) {
                        VStack(alignment: .leading) {
                            Text("New Password")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            SecureField("Enter new password", text: $newPassword)
                                .padding()
                                .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }

                        VStack(alignment: .leading) {
                            Text("Confirm Password")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            SecureField("Re-enter new password", text: $confirmPassword)
                                .padding()
                                .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }

                        Button {
                            Task {
                                guard newPassword == confirmPassword else {
                                    showErrorToast("Passwords do not match")
                                    return
                                }
                                
                                guard isPasswordStrong(newPassword) else {
                                    showErrorToast("Password must be 8+ characters and include a number & special character")
                                    return
                                }
                                
                                await viewModel.updatePassword(newPassword: newPassword)
                                if viewModel.errorMessage != nil {
                                    showErrorToast(viewModel.errorMessage!)
                                } else {
                                    toast = Toast(message: "Password updated successfully", style: .success)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        navigateToHome = true
                                    }
                                    isSuccess = true
                                }
                            }
                        } label: {
                            Text("Update Password")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(colorScheme == .dark ? Color.white : Color.black)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 20)

                    }
                    .padding(.horizontal, 40)
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToHome) {
                SignInView()
                    .navigationBarBackButtonHidden(true)
            }
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
    }

    private func showErrorToast(_ message: String) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        toast = Toast(message: message, style: .error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { toast = nil }
        }
    }

    private func isPasswordStrong(_ password: String) -> Bool {
        let pattern = #"^(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$"#
        return password.range(of: pattern, options: .regularExpression) != nil
    }
}


#Preview {
    ResetPasswordView()
}
