import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var toast: Toast? = nil

    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        Image(.vector)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .background(AppTheme.accent(for: colorScheme))
                        
                            .cornerRadius(50)

                        Spacer().frame(height: 100)

                        VStack(spacing: 12) {
                            VStack(alignment: .leading) {
                                Text("Email Address")
                                    .font(.silkCaption())
                                    .foregroundColor(AppTheme.text(for: colorScheme))

                                TextField("Email address", text: $viewModel.email)
                                    .padding()
                                    .background(AppTheme.background(for: colorScheme))
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .foregroundColor(AppTheme.text(for: colorScheme))
                            }

                            VStack(alignment: .leading) {
                                Text("Password")
                                    .font(.silkCaption())
                                    .foregroundColor(AppTheme.text(for: colorScheme))

                                SecureField("Password", text: $viewModel.password)
                                    .padding()
                                    .background(AppTheme.background(for: colorScheme))
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                    .foregroundColor(AppTheme.text(for: colorScheme))
                            }

                            Button {
                                Task {
                                    if !viewModel.isFormValid(email: viewModel.email, password: viewModel.password) {
                                        let generator = UINotificationFeedbackGenerator()
                                        generator.notificationOccurred(.error)
                                        toast = Toast(message: "Please enter a valid email and password", style: .error)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation { toast = nil }
                                        }
                                        return
                                    }

                                    await viewModel.signUp(
                                        email: viewModel.email,
                                        password: viewModel.password
                                    )

                                    if let errorMessage = viewModel.errorMessage {
                                        toast = Toast(message: errorMessage, style: .error)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation { toast = nil }
                                        }
                                    } else {
                                        dismiss()
                                    }
                                }
                            } label: {
                                if viewModel.isLoading {
                                    ProgressView().frame(maxWidth: .infinity).padding()
                                } else {
                                    Text("Sign Up")
                                        .font(.silkBody())
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(AppTheme.accent(for: colorScheme))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.top, 20)

                            NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                                Text("Already have an account? Sign in here")
                                    .foregroundColor(AppTheme.text(for: colorScheme))
                                    .font(.silkCaption())
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppTheme.background(for: colorScheme))
                    
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
    SignUpView()
        .environmentObject(AuthViewModel())
}
