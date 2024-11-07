//
//  ThemeManager.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") var selectedTheme: String = "light" {
        didSet {
            switch selectedTheme {
            case "light":
                currentTheme = Themes.light
            case "dark":
                currentTheme = Themes.dark
            case "blue":
                currentTheme = Themes.blue
            default:
                currentTheme = Themes.light
            }
        }
    }

    @Published var currentTheme: Theme = Themes.light

    init() {
        switch selectedTheme {
        case "light":
            currentTheme = Themes.light
        case "dark":
            currentTheme = Themes.dark
        case "blue":
            currentTheme = Themes.blue
        default:
            currentTheme = Themes.light
        }
    }
}
