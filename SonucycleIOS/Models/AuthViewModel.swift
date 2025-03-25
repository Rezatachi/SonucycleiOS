//
//  AuthViewModel.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/17/25.
//

import Foundation
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSignedIn = false
    @Published var user: User? // Optional user property to store the signed-in user
    
    private let supabase = SupabaseClient(
      supabaseURL: URL(string: "https://ubkdlalkljvwmowjnarb.supabase.co")!,
      supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVia2RsYWxrbGp2d21vd2puYXJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIyNTc4NjksImV4cCI6MjA1NzgzMzg2OX0.h1wsq9O5PfUKMP-FVTIwQvV-m8Uut7zQRIEzYrR5VVM"
    )

    // MARK: - Form Validation
    func isFormValid(email: String, password: String) -> Bool {
        print("Email: \(email)")
        print("Password: \(password)")
        return !email.isEmpty &&
               email.contains("@") && email.contains(".") &&
               !password.isEmpty &&
               password.count >= 6
    }
    
    // MARK: - Sign In (Email & Password)
    func signIn(email: String, password: String) async {
        guard isFormValid(email: email, password: password) else {
            errorMessage = "Invalid email or password."
            return
        }

        isLoading = true
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            print("User signed in: \(session)")
            isSignedIn = true
        } catch {
            errorMessage = "Sign in failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Sign Up (Email & Password)
    func signUp(email: String, password: String) async {
        guard isFormValid(email: email, password: password) else {
            errorMessage = "Invalid email or password."
            return
        }
        isLoading = true
        do {
            let user = try await supabase.auth.signUp(email: email, password: password)
            print("User signed up: \(user)")
        } catch {
            errorMessage = "Sign up failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Sign Out
    func signOut() async {
        isLoading = true
        do {
            try await supabase.auth.signOut()
            print("User signed out")
            isSignedIn = false
        } catch {
            errorMessage = "Sign out failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Sign In With Google
    func signInWithGoogle() async {
        isLoading = true
        do {
            let session = try await supabase.auth.signInWithOAuth(
                provider: .google)
            print("User signed in with Google: \(session)")
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Google sign in failed: \(error.localizedDescription)"
            }
        }
        isLoading = false
    }

    // MARK: - Sign In With Apple
    func signInWithApple() async {
        isLoading = true
        do {
            let session = try await supabase.auth.signInWithOAuth(provider: .apple)
            print("User signed in with Apple: \(session)")
        } catch {
            errorMessage = "Apple sign in failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String) async {
        isLoading = true
        do {
            try await supabase.auth.resetPasswordForEmail(
                email,
                redirectTo: URL(filePath: "sonucycle://reset-password")
            )
        } catch {
            errorMessage = "Password reset failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Update Password
    func updatePassword(newPassword: String) async {
        isLoading = true
        do {
            try await supabase.auth.update(user: UserAttributes(password: newPassword))
            print("Password updated successfully")
        } catch {
            errorMessage = "Password update failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Session Restoration
    func restoreSession() async {
        isLoading = true
        do {
            let session = try await supabase.auth.session
            if session.accessToken.isEmpty {
                errorMessage = "No active session found."
            } else {
                isSignedIn = true
                print("Session restored: \(session.user)")
                user = session.user // Store the user in the published property
            }
        } catch {
            errorMessage = "Session restoration failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
