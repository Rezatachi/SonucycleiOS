import SwiftUI

struct JournalCreationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedFeeling: String? = nil

    let feelings = ["Happy", "Sad", "Anxious", "Grateful", "Angry", "Excited"]

    var onSave: (JournalEntry) -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Title Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Title")
                            .font(.silkCaption())
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        TextField("What's on your mind?", text: $title)
                            .padding()
                            .background(AppTheme.background(for: colorScheme))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                            .foregroundColor(AppTheme.text(for: colorScheme))
                    }

                    // Mood Selector
                    VStack(alignment: .leading, spacing: 6) {
                        Text("How are you feeling?")
                            .font(.silkCaption())
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(feelings, id: \.self) { feeling in
                                    Text(feeling)
                                        .font(.silkBody(size: 14))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedFeeling == feeling ? AppTheme.accent(for: colorScheme) : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedFeeling == feeling ? .white : AppTheme.text(for: colorScheme))
                                        .cornerRadius(20)
                                        .onTapGesture {
                                            selectedFeeling = feeling
                                        }
                                }
                            }
                        }
                    }

                    // Journal Text Area
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Write it out")
                            .font(.silkCaption())
                            .foregroundColor(AppTheme.text(for: colorScheme))

                        TextEditor(text: $content)
                            .frame(minHeight: 200)
                            .padding()
                            .background(AppTheme.background(for: colorScheme))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                            .foregroundColor(AppTheme.text(for: colorScheme))
                    }
                }
                .padding()
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .font(.silkBody())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEntry = JournalEntry(
                            title: title.isEmpty ? "Untitled" : title,
                            content: content,
                            timestamp: Date()
                        )
                        onSave(newEntry)
                        dismiss()
                    }
                    .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .font(.silkBody())
                }
            }
            .background(
                AppTheme.background(for: colorScheme)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    JournalCreationView(
        onSave: { entry in
            // Handle the new journal entry here
            print("New Journal Entry Saved: \(entry)")
        }
    )
    
}
