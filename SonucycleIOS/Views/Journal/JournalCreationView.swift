//
//  JournalCreationView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/28/25.
//

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
                            .font(.subheadline)
                            .fontWeight(.bold)
                        TextField("What's on your mind?", text: $title)
                            .padding()
                            .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    }

                    // Mood Selector
                    VStack(alignment: .leading, spacing: 6) {
                        Text("How are you feeling?")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(feelings, id: \.self) { feeling in
                                    Text(feeling)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedFeeling == feeling ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedFeeling == feeling ? .white : .primary)
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
                            .font(.subheadline)
                            .fontWeight(.bold)
                        TextEditor(text: $content)
                            .frame(minHeight: 200)
                            .padding()
                            .background(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                    }
                }
                .padding()
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
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
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colorScheme == .dark ? [Color.black, Color.black] : [Color.white, Color.gray.opacity(0.2)]),
                    startPoint: .top, endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

#Preview {
    JournalCreationView { _ in }
}
