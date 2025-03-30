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
                .font(.silkHeading(size: 20))
                .foregroundColor(AppTheme.text(for: colorScheme))

            Text(entry.content)
                .font(.silkBody(size: 16))
                .foregroundColor(AppTheme.text(for: colorScheme))

            Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened))
                .font(.silkCaption(size: 12))
                .foregroundColor(.gray)
        }
        .padding()
        .background(AppTheme.background(for: colorScheme))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

#Preview{
    JournalCardView(entry: JournalEntry(title: "Today's Journal", content: "I had a great day today!", timestamp: Date()))
}
