import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var email: String = ""
    @State private var showConfirmation: Bool = false
    @State private var errorMessage: String?
    @State private var toast: Toast? = nil
    @State private var navigateToHome = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background(for: colorScheme)
                    .ignoresSafeArea()

                VStack {
                    Image(.vector)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(AppTheme.accent(for: colorScheme))
                        .cornerRadius(50)

                    Spacer().frame(height: 50)

                    Text("Enter your email to receive a password reset link.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 40)
                        .font(.silkBody())

                    Spacer().frame(height: 50)

                    VStack(spacing: 12) {
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.silkCaption())
                                .foregroundColor(AppTheme.text(for: colorScheme))

                            TextField("Enter your email", text: $email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                                .padding()
                                .background(AppTheme.background(for: colorScheme))
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                .foregroundColor(AppTheme.text(for: colorScheme))
                        }

                        Button {
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
                                    }
                                }
                            }
                        } label: {
                            Text("Send Reset Link")
                                .font(.silkBody())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.accent(for: colorScheme))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToHome) {
                SignInView(toastFromChild: toast)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(AppTheme.text(for: colorScheme))
                }
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
}

#Preview {
    ForgotPasswordView()
        .environmentObject(AuthViewModel()) // Ensure to provide the AuthViewModel for preview
}
