// MeetCard.swift

import Foundation

/// Модель данных для «встречи»
struct MeetCard: Identifiable, Hashable {
    /// Уникальный идентификатор встречи
    let id = UUID()
    
    /// Краткое описание встречи
    let description: String
    
    /// Дата и время проведения
    let date: Date
    
    /// Текущее число участников/откликнувшихся
    let participants: Int
}
