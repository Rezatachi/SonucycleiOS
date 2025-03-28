//
//  JournalEntryModel.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 2/12/25.
//

import Foundation
import SwiftUI

struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var timestamp: Date
    var feelings: [String] = []         // e.g., ["Happy", "Anxious"]
    var audioURL: URL? = nil           // local or remote audio recording
    var videoURL: URL? = nil           // local or remote video recording
    var moodColorHex: String? = nil    // optional color representing emotion (UI usage)
    var isVoiceMemo: Bool = false
    var isVideoMemo: Bool = false
    var isTextOnly: Bool = true
}

