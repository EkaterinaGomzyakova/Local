//
//  Theme.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import Foundation
import SwiftUI

//Для поддержки хексов
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        let r, g, b: Double
        let a: Double = 1.0

        r = Double((hexNumber & 0xFF0000) >> 16) / 255
        g = Double((hexNumber & 0x00FF00) >> 8) / 255
        b = Double(hexNumber & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

struct Theme {
    var backgroundColor: Color
    var textColor: Color
    var buttonColor: Color
    var buttonTextColor: Color
}

struct Themes {
    static let light = Theme(
        backgroundColor: Color(hex: "#ECE7E4"),
        textColor: Color.black,
        buttonColor: Color.blue,
        buttonTextColor: Color.white
    )
    
    static let dark = Theme(
        backgroundColor: Color.black,
        textColor: Color.white,
        buttonColor: Color.gray,
        buttonTextColor: Color.black
    )
    
    static let blue = Theme(
        backgroundColor: Color.blue.opacity(0.1),
        textColor: Color.blue,
        buttonColor: Color.blue,
        buttonTextColor: Color.white
    )
}
