//
//  SettingsRow.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/25/25.
//

import SwiftUI

struct SettingsRow<TrailingView: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let icon: String
    let title: String
    var subtitle: String? = nil
    var trailing: TrailingView
    var showChevron: Bool
    
    init(icon: String, title: String, subtitle: String? = nil, showChevron: Bool = true, @ViewBuilder trailing: () -> TrailingView) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing()
        self.showChevron = showChevron
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 40, height: 40)
                if title == "Delete Account" {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                } else {
                    Image(systemName: icon)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                if title == "Delete Account" {
                    Text(title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                } else {
                    Text(title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            if showChevron == true {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
            
            trailing
            
            
            
            
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    SettingsRow(icon: "gear", title: "Settings", showChevron: false, trailing: {
        EmptyView()
    })
}

