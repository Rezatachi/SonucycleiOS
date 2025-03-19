//
//  JournalView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 2/18/25.
//

import SwiftUI

struct JournalView: View {
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing: 20) {
                   
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
