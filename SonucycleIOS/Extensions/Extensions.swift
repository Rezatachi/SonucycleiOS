//
//  Extensions.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/17/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

struct Toast: Equatable {
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
    var style: ToastStyle
}

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error:
            return Color.red
        case .warning:
            return Color.orange
        case .success:
            return Color.green
        case .info:
            return Color.sonucycleBG
        }
    }
    var iconFileName: String {
        switch self {
        case .error:
            return "exclamationmark.triangle"
        case .warning:
            return "exclamationmark.circle"
        case .success:
            return "checkmark.circle"
        case .info:
            return "moonphase.new.moon.inverse"
        }
    }
}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

extension UITextField {
    open override var inputAssistantItem: UITextInputAssistantItem {
        let item = super.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        return item
    }
}

