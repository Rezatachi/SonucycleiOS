//
//  Extensions.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/17/25.
//

import Foundation
import SwiftUI

struct AppTheme {
    static func background(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color(hex: "#1B1B1E") : Color("SonuCream")
    }
    
    static func text(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color(hex: "#F4F1EB") : Color("SonuText")
    }
    
    static func accent(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color(hex: "#A28BD4") : Color("SonuAccent")
    }
}

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

extension Font {
    static func silkHeading(size: CGFloat = 26) -> Font {
        .custom("SilkFlowerDemo-Regular", size: size)
    }
    
    static func silkBody(size: CGFloat = 16) -> Font {
        .custom("SilkFlowerDemo-Regular", size: size)
    }
    
    static func silkCaption(size: CGFloat = 12) -> Font {
        .custom("SilkFlowerDemo-Regular", size: size)
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
            return Color.sonuCream
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

