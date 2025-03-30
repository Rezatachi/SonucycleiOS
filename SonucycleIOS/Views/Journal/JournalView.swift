import SwiftUI

struct JournalView: View {
    @State private var showJournalCreation = false
    @State private var journalEntries: [JournalEntry] = []
    @Environment(\.colorScheme) private var colorScheme
    @State private var toast: Toast? = nil

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if journalEntries.isEmpty {
                        Spacer()
                        Text("No journal entries yet")
                            .font(.silkBody())
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(journalEntries) { entry in
                                    JournalCardView(entry: entry)
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationTitle("Journal")
                .toolbarBackground(.hidden, for: .navigationBar)
                .sheet(isPresented: $showJournalCreation) {
                    JournalCreationView(
                        onSave: { newEntry in
                            journalEntries.append(newEntry)
                            toast = Toast(message: "Entry added!", style: .success)
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                AppTheme.background(for: colorScheme)
                    .ignoresSafeArea()
            )
            .safeAreaInset(edge: .bottom, alignment: .trailing) {
                Button(action: {
                    showJournalCreation.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 60, height: 60)
                        .background(AppTheme.accent(for: colorScheme))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
        .toastView(toast: $toast)
    }
}

#Preview{
    JournalView()
}
