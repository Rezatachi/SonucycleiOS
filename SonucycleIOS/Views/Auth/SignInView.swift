import SwiftUI

struct SignInView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var toast: Toast? = nil
    @State private var navigateToHome = false

    var toastFromChild: Toast? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    // Welcome Text
                    HStack {
                        Text("Sonucycle")
                            .font(.silkHeading(size: 28))
                            .foregroundColor(AppTheme.text(for: colorScheme))
                            .padding(.top, 20)

                        Image(.vector)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .background(AppTheme.accent(for: colorScheme))
                            .cornerRadius(50)
                            .padding(.top, 20)
                    }

                    // Input Fields
                    VStack(spacing: 12) {
                        TextField("Email address", text: $viewModel.email)
                            .padding()
                            .background(AppTheme.background(for: colorScheme))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(AppTheme.background(for: colorScheme))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                            .foregroundColor(AppTheme.text(for: colorScheme))
                    }
                    .padding(.horizontal, 40)

                    // Register Link
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
                        Text("New User? Register Here")
                            .foregroundColor(AppTheme.text(for: colorScheme))
                            .font(.silkCaption())
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
                                .font(.silkBody())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.accent(for: colorScheme))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .contentShape(Rectangle())
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                    // OAuth Buttons
                    Group {
                        Button(action: {
                            Task { await viewModel.signInWithApple() }
                        }) {
                            HStack {
                                Image(systemName: "applelogo")
                                Text("Sign in with Apple")
                            }
                        }
                        .font(.silkBody())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.background(for: colorScheme))
                        .foregroundColor(AppTheme.text(for: colorScheme))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                        .padding(.horizontal, 40)
                        .padding(.top, 10)

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
                        .font(.silkBody())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.background(for: colorScheme))
                        .foregroundColor(AppTheme.text(for: colorScheme))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    }

                    // Forgot Password Link
                    NavigationLink(destination: ForgotPasswordView().navigationBarBackButtonHidden(true)) {
                        Text("Forgot Password?")
                            .foregroundColor(AppTheme.text(for: colorScheme))
                            .font(.silkCaption())
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 20)

                    Spacer(minLength: 10)

                    // Footer Text
                    Text("© 2025 Sonucycle")
                        .font(.silkCaption())
                    Text("人生を掴み取れ。")
                        .font(.silkCaption())
                        .padding(.bottom, 20)
                }
                .background(
                    AppTheme.background(for: colorScheme)
                        .ignoresSafeArea()
                )
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
