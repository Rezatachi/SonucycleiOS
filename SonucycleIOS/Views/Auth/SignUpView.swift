import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var toast: Toast? = nil
    

    var body: some View {
        NavigationStack {
            ScrollView{
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
                                Text("Email Address")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                TextField("Email address", text: $viewModel.email)
                                    .padding()
                                    .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Password")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                SecureField("Password", text: $viewModel.password)
                                    .padding()
                                    .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            
                            Button {
                                Task {
                                    print("Password: \(viewModel.password)") // Debugging line to check password input
                                    print("---")
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
                                        print("Sign up failed: \(errorMessage)")
                                    } else {
                                        print("User signed up successfully!")
                                        dismiss() // Dismiss after sign-up
                                    }
                                }
                            } label: {
                                if viewModel.isLoading {
                                    ProgressView().frame(maxWidth: .infinity).padding()
                                } else {
                                    Text("Sign Up")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(colorScheme == .dark ? Color.white : Color.black)
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.top, 20)
                            
                            NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                                Text("Already have an account? Sign in here")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .font(.footnote)
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding()
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
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
