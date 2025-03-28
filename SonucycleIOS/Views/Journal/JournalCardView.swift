//
//  JournalCardView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/28/25.
//

import SwiftUI

struct JournalCardView: View {
    let entry: JournalEntry
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.title)
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black)

            Text(entry.content)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .black)

            Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

#Preview{
    JournalCardView(entry: JournalEntry(title: "Today's Journal", content: "I had a great day today!", timestamp: Date()))
}
