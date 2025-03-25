//
//  SettingsRow.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/25/25.
//

import SwiftUI

struct SettingsRow: View {
    @Environment(\.colorScheme) var colorScheme
    let icon: String
    let title: String
    var subtitle: String? = nil

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
#Preview {
    SettingsRow(icon: "gearshape", title: "Settings", subtitle: "Manage your preferences")
        
}
