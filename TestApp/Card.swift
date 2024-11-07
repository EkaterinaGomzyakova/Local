//
//  Card.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import Foundation

struct Card: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var tags: [String]
}

