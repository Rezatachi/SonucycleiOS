//
//  DeepLinkModel.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/22/25.
//

import Foundation

struct DeepLink : Identifiable {
    let id = UUID()
    let url: URL
}
