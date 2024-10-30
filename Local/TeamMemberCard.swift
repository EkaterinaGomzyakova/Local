//
//  TeamMemberCard.swift
//  Local
//
//  Created by Kate on 29.10.2024.
//

import Foundation
import SwiftUI

struct TeamMemberCard: View {
    let imageName: String
    let name: String
    let role: String
    let description: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 152, height: 152)
            Text(name)
                .font(.custom("SF Pro Medium", size: 32))
                .foregroundColor(Color("AlmostBlack"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text(role)
                .font(.custom("SF Pro Medium", size: 18))
                .foregroundColor(Color("MediumGray"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text(description)
                .font(.custom("SF Pro Medium", size: 18))
                .foregroundColor(Color("AlmostBlack"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding() 
        .frame(width: 255, height: 328)
        .background(Color("White"))
        .cornerRadius(20) //
        .padding(.horizontal, 16)
    }
}

