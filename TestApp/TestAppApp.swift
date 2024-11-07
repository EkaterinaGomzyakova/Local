//
//  TestAppApp.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

@main
struct TestAppApp: App {
    let persistenceController = PersistenceController.shared  // Получаем контроллер для управления данными
    @StateObject var themeManager = ThemeManager()  // Создаем объект для управления темами

    var body: some Scene {
        WindowGroup {
            MainTabView()  // Главный экран
                .environment(\.managedObjectContext, persistenceController.container.viewContext)  // Передаем контекст данных
                .environmentObject(themeManager)  // Передаем объект themeManager для управления темой
        }
    }
}
