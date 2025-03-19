//
//  SignInViewModel.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/17/25.
//

import Foundation
import Supabase

@MainActor
class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let supabase = SupabaseClient(
      supabaseURL: URL(string: "https://ubkdlalkljvwmowjnarb.supabase.co")!,
      supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVia2RsYWxrbGp2d21vd2puYXJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIyNTc4NjksImV4cCI6MjA1NzgzMzg2OX0.h1wsq9O5PfUKMP-FVTIwQvV-m8Uut7zQRIEzYrR5VVM"
    )

    // MARK: - Form Validation
    func isFormValid() -> Bool {
        return !email.isEmpty &&
               !password.isEmpty &&
               password.count >= 6 &&
               email.contains("@")
    }
    
    // MARK: - Sign In (Email & Password)
    func signIn() async {
        guard isFormValid() else {
            errorMessage = "Invalid email or password."
            return
        }
        
        isLoading = true
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            print("User signed in: \(session)")
        } catch {
            errorMessage = "Sign in failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // MARK: - Sign Up (Email & Password)
    func signUp() async {
        guard isFormValid() else {
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
        // Automatically sign in after signing up
        await signIn()

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
}
