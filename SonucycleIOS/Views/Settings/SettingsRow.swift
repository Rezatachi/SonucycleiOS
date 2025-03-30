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
                    .fill(AppTheme.accent(for: colorScheme).opacity(0.1))
                    .frame(width: 40, height: 40)
                if title == "Delete Account" {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                } else {
                    Image(systemName: icon)
                        .foregroundColor(AppTheme.text(for: colorScheme))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                if title == "Delete Account" {
                    Text(title)
                        .font(.silkBody())
                        .foregroundColor(.red)
                } else {
                    Text(title)
                        .font(.silkBody())
                        .foregroundColor(AppTheme.text(for: colorScheme))
                }

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.silkCaption(size: 12))
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            if showChevron {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }

            trailing
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(AppTheme.background(for: colorScheme))
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    SettingsRow(icon: "gear", title: "Settings", showChevron: false, trailing: {
        EmptyView()
    })
}
