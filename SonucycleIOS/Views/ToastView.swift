//
//  ToastView.swift
//  SonucycleIOS
//
//  Created by Abraham Belayneh on 3/18/25.
//

import SwiftUI

struct ToastView: View {
    
    var message: String
    var width: Double = .infinity
    var style: ToastStyle
    var onCancelledTapped: (() -> Void)
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .center, spacing: 12){
            Image(systemName: style.iconFileName)
                .foregroundColor(colorScheme == .dark ? .black : style.themeColor)
            Text(message)
                .font(Font.caption.bold())
                .foregroundColor(colorScheme == .dark ? .black : .black)
                .lineLimit(2)
            Spacer(minLength: 10)
            Button(action: {
                onCancelledTapped()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(colorScheme == .dark ? Color.white : Color.white)
        .cornerRadius(12)
        
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black)
                .opacity(1)
            )
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    ToastView(message: "This is a sample toast message", style: .info, onCancelledTapped: {})
}
