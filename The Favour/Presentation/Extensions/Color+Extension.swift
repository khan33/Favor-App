//
//  Color+Extension.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    
    
    /// #18A94A
    static let appPrimaryColor = Color(hex: "#A54AFF")
    
    static let appTitleColor = Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1))
    /// #18A94A with alpha
    static let appGreenWithAlpha = Color(red: 0.196, green: 0.392, blue: 0.239)
    /// #172327
    static let appBlack = Color(red: 0.129, green: 0.129, blue: 0.129)
    /// #FFFFFF
    static let appWhite = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    /// #F7D8D4
    static let appPink = Color(red: 0.969, green: 0.847, blue: 0.831)
    /// #F2F2F2
    static let appLightGrey = Color(red: 0.949, green: 0.949, blue: 0.949)
    /// #979797
    static let appLightBlack = Color(red: 0.592, green: 0.592, blue: 0.592)
    /// #
    static let appIconBackground = Color(red: 0.858, green: 0.854, blue: 0.854)
    /// #5FD8C9
    static let appGreenIconColor = Color(red: 0.373, green: 0.847, blue: 0.788)
    /// #EA4335
    static let appRed = Color(red: 0.917, green: 0.262, blue: 0.207)
    /// #FBBC04
    static let appYellow = Color(red: 0.984, green: 0.737, blue: 0.015)
    
    static let appBorderColor = Color(red: 0.933, green: 0.933, blue: 0.933)
    
    static let appTextFieldColor = Color(red: 0.98, green: 0.98, blue: 0.98)
    
}
