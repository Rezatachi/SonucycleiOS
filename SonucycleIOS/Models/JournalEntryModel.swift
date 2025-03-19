//
//  JournalEntryModel.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 2/12/25.
//

import Foundation


struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var timestamp: Date
}
