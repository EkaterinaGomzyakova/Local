//
//  OnboardingData.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import Foundation

struct OnboardingData: Identifiable, Hashable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}
