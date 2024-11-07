//
//  PersistenceController.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()  // Синглтон для доступа к контроллеру
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")  // Название модели данных
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }

    // Функция для сохранения контекста данных
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
