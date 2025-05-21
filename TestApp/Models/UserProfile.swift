//
//  UserProfile.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import Foundation
import SwiftUI

struct UserProfile: Identifiable {
var id = UUID()
var firstName: String
var lastName: String
var email: String
var avatar: UIImage?
}
