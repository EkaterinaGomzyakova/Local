//
//  FeatureCard.swift
//  Local
//
//  Created by Kate on 29.10.2024.
//

import Foundation
import SwiftUI

struct FeatureCard: View {
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.custom("TT Interphases Edu", size: 32))
                .fontWeight(.medium)
                .foregroundColor(Color("AlmostBlack"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(maxWidth: 260)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(description)
                .foregroundColor(Color("AlmostBlack"))
                .font(.custom("TT Interphases Edu", size: 18))
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .lineSpacing(0)
                .tracking(-0.72)
        }
        .padding(24)
        .frame(width: 300)
        .background(Color("White"))
        .cornerRadius(20)
//        .padding(.horizontal, 16)
    }
}
