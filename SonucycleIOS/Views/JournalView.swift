//
//  JournalView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 2/18/25.
//

import SwiftUI

struct JournalView: View {
    // get environemnt object for authviewmodel
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing: 20) {
                     // Debugging line to print user ID
                    Text("User ID: \(authViewModel.user?.email ?? "No user")")
                        
                        // sign out button
                    Button {
                        Task {
                            await authViewModel.signOut()
                        }
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Journal")
            .frame(maxWidth: .infinity)
            .background(Color.sonucycleBG)
        }
    }
}

#Preview {
    JournalView()
}
